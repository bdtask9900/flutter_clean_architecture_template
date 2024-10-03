import 'package:dio/dio.dart';

abstract class BaseDioClient {
  Dio get dio;

  Future<Response<T>> get<T>(String path, {Map<String, dynamic>? queryParameters});
  Future<Response<T>> post<T>(String path, {dynamic data});
  // Define other methods like PUT, DELETE, etc. as needed
}