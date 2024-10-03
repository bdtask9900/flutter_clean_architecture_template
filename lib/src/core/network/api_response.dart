// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:go_riverpod_dio/src/pkg.dart';

import 'dio_client.dart';


List<Abc> abcFromJson(dynamic str) =>
    List<Abc>.from((str as List<dynamic>).map((x) => Abc.fromJson(x)));

String abcToJson(List<Abc> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Abc {
  final int userId;
  final int id;
  final String title;
  final String body;

  Abc({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Abc.fromJson(Map<String, dynamic> json) => Abc(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}

class ApiResponse<T> {
  final T? data;
  final String? errorMessage;

  ApiResponse({this.data, this.errorMessage});

  bool get isSuccess => data != null;
}

class ApiResponse2<T> {
  T? data; // The actual data returned from the API (generic type)
  String? error; // Error message in case of failure
  int? statusCode; // HTTP status code

  ApiResponse2.success(this.data) : error = null;
  ApiResponse2.failure(this.error, {this.statusCode}) : data = null;

  bool get isSuccess =>
      error == null; // Helper to check if the response is successful
}

class ApiService2 {
  final DioClient _dio;

  ApiService2(this._dio);

  Future<ApiResponse<T>> get<T>(String endpoint,
      {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.client.get(endpoint, queryParameters: params);
      return ApiResponse<T>(data: response.data);
    }on DioException catch (e) {
      return ApiResponse<T>(errorMessage: handleDioError(e));
    }
  }

  // Other methods like post, put, etc.

  String handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        throw TimeoutException();
      case DioExceptionType.receiveTimeout:
        throw TimeoutException();
      case DioExceptionType.badResponse:
        if (error.response?.statusCode == 401) {
          throw UnauthorizedException();
        }
        throw NetworkException('Server error: ${error.response?.statusCode}');
      case DioExceptionType.unknown:
        throw NoInternetException();
      default:
        throw NetworkException('An unexpected error occurred');
    }
  }
}

class NetworkException implements Exception {
  final String message;
  NetworkException(this.message);
}

class UnauthorizedException extends NetworkException {
  UnauthorizedException() : super('Unauthorized: Please login again.');
}

class TimeoutException extends NetworkException {
  TimeoutException() : super('The request has timed out.');
}

class NoInternetException extends NetworkException {
  NoInternetException() : super('No internet connection.');
}

final apiService2Provider = Provider<ApiService2>((ref) {
  final dio = ref.watch(dioClientProvider);
  return ApiService2(dio);
});
final itemRepoProvider = Provider<ItemRepository>((ref) {
  final api2 = ref.watch(apiService2Provider);
  return ItemRepository(api2);
});
final itemProvider = FutureProvider<List<Abc>>((ref) async {
  final item = ref.watch(itemRepoProvider);
  final result = await item.fetchItems();
  List<Abc>? data = abcFromJson(result.data);
  // printLog(data);
  printLog(result.errorMessage);
  printLog('item provider ::: ::: ');
  for (var item in data) {
    printLog(item.id);
  }
  return [];
});

class ItemRepository {
  final ApiService2 _apiService;

  ItemRepository(this._apiService);

  Future<ApiResponse<List<dynamic>>> fetchItems() async {
    return await _apiService.get<List<dynamic>>('/posts');
  }
}

class PaginatedResponse<T> {
  final List<T> items;
  final int currentPage;
  final int totalPages;

  PaginatedResponse(
      {required this.items,
      required this.currentPage,
      required this.totalPages});

  bool get hasMore => currentPage < totalPages;
}

class PaginatedRepository<T> {
  final ApiService2 _apiService;
  int _currentPage = 1;
  final int _totalPages = 1;

  PaginatedRepository(this._apiService);

  Future<PaginatedResponse<T>> fetchPage(String endpoint,
      {Map<String, dynamic>? params}) async {
    if (_currentPage > _totalPages) {
      throw Exception('No more data');
    }

    final response = await _apiService.get<List<T>>(endpoint, params: {
      'page': _currentPage,
      ...?params,
    });

    if (response.errorMessage != null) {
      throw Exception(response.errorMessage);
    }

    _currentPage++;
    // Assuming the response contains `totalPages` from the API
    return PaginatedResponse(
      items: response.data!,
      currentPage: _currentPage,
      totalPages: response.data!.isNotEmpty ? _totalPages : _currentPage,
    );
  }

  void resetPagination() {
    _currentPage = 1;
  }
}

class ItemRepository2 extends PaginatedRepository<dynamic> {
  ItemRepository2(super.apiService);

  Future<PaginatedResponse<dynamic>> fetchPaginatedItems() async {
    return await fetchPage('/items');
  }
}

class NetworkState<T> {
  const NetworkState();
}

class NetworkLoading<T> extends NetworkState<T> {}

class NetworkData<T> extends NetworkState<T> {
  final T data;
  const NetworkData(this.data);
}

class NetworkError<T> extends NetworkState<T> {
  final String message;
  const NetworkError(this.message);
}

// Example in StateNotifier
class ItemNotifier extends StateNotifier<NetworkState> {
  final ItemRepository2 _repository;

  ItemNotifier(this._repository) : super(NetworkLoading());

  Future<void> loadMoreItems() async {
    try {
      final paginatedResponse = await _repository.fetchPaginatedItems();
      state = NetworkData(paginatedResponse.items);
    } catch (e) {
      state = NetworkError(e.toString());
    }
  }

  void resetPagination() {
    _repository.resetPagination();
  }
}
