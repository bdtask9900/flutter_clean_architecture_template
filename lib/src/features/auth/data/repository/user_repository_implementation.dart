import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/pkg.dart';
import '../../../../core/services/api_service.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;
  UserRepositoryImpl(this.apiService);
  @override
  Future<NewUser> addNewUser(String name, String job) async {
    try {
      final response = await apiService.post(
        'users',
        data: {
          'name': name,
          'job': job,
        },
      );
      return NewUser.fromJson(response);
    } on DioException catch (e) {
      // var error = DioException.(e);
      throw 'error';
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    try {
      await apiService.delete('users/$id');
    } on DioException catch (e) {
      // var error = DioException.fromDioError(e);
      // throw error.errorMessage;
    }
  }

  @override
  Future<List<User>> getUserList() async {
    try {
      final response = await apiService.get("user");
      final userList =
          (response["data"] as List).map((e) => User.fromJson(e)).toList();
      return userList;
    } on DioException catch (e) {
      // var error = DioException.fromDioError(e);
      throw 'error.errorMessage';
    }
  }

  @override
  Future<NewUser> updateUser(String id, String name, String job) async {
    try {
      final response = await apiService.put(
        'users/$id',
        data: {
          'id': id,
          'name': name,
          'job': job,
        },
      );
      return NewUser.fromJson(response);
    } on DioException catch (e) {
      // var error = DioException.fromDioError(e);
      throw 'error.errorMessage';
    }
  }
}

class UserRepository2 {
  final ApiService _dioClient;

  UserRepository2(this._dioClient);

  Future<List<dynamic>> fetchUsers() async {
    final response = await _dioClient.fetchData('/users');
    printLog(response.data);
    printLog(response.statusCode);
    printLog(response.statusMessage);
    return response.data;
  }

  // Future<dynamic> createUser(Map<String, dynamic> userData) async {
  //   final response = await _dioClient.post('/users', data: userData);
  //   return response.data;
  // }
}

final userRepositoryProvider = Provider<UserRepository2>((ref) {
  final dioClientService = ref.watch(apiServiceProvider);
  return UserRepository2(dioClientService);
});
