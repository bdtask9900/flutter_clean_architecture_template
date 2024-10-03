import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/pkg.dart';

import '../network/dio_client.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final dioClient = ref.read(dioClientProvider);
  return ApiService(dioClient);
});

class ApiService {
  final DioClient dioClient;
  const ApiService(this.dioClient);

  Future<Response> fetchData(String endpoint) async {
    return await dioClient.client.get(endpoint);
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    return await dioClient.client.post(endpoint, data: data);
  }

  // PUT method
  Future<Response> putData(String endpoint, Map<String, dynamic> data) async {
    try {
      return await dioClient.client.put(endpoint, data: data);
    } catch (e) {
      rethrow; // Handle error or log it if necessary
    }
  }

  // DELETE method
  Future<Response> deleteData(String endpoint,
      {Map<String, dynamic>? data}) async {
    try {
      return await dioClient.client.delete(endpoint, data: data);
    } on DioException catch (e) {
      _handleError(e);
      rethrow; // Handle error or log it if necessary
    }
  }

  // Add other methods as needed (PUT, DELETE, etc.)
  void _handleError(DioException error) {
    if (error.response != null) {
      printLog(
          'Error Status: ${error.response?.statusCode}, Data: ${error.response?.data}');
    } else {
      printLog('Error Message: ${error.message}');
    }
  }

  Future<Map<String, dynamic>> get(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await dioClient.client.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  ///Post Method
  Future<Map<String, dynamic>> post(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await dioClient.client.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  ///Put Method
  Future<Map<String, dynamic>> put(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await dioClient.client.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }

  ///Delete Method
  Future<dynamic> delete(String path,
      {data,
      Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onSendProgress,
      ProgressCallback? onReceiveProgress}) async {
    try {
      final Response response = await dioClient.client.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (response.statusCode == 204) {
        return response.data;
      }
      throw "something went wrong";
    } catch (e) {
      rethrow;
    }
  }
}


/*


final websocketProvider = Provider<WebSocketService>((ref) {
  return WebSocketService('wss://your-websocket-url'); // Replace with your WebSocket URL
});


class WebSocketService {
  final WebSocketChannel channel;

  WebSocketService(String url) : channel = WebSocketChannel.connect(Uri.parse(url));

  void sendMessage(String message) {
    channel.sink.add(message);
  }

  Stream<String> get messages => channel.stream.map((event) => event.toString());

  void dispose() {
    channel.sink.close();
  }
}
*/