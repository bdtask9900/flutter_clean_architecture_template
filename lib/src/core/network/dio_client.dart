import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient();
});

class DioClient {
  final Dio _dio;
  DioClient()
      : _dio = Dio(BaseOptions(
          baseUrl:
              'https://jsonplaceholder.typicode.com/', // Replace with your API base URL
          connectTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 40),
        )) {
    //  _dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
    _setupInterceptors();
  }

  Dio get client => _dio;

  void _setupInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      // Log request method and URL
      print('--- Request ---');
      print('Method: ${options.method}');
      print('URL: ${options.uri}');
      //       String? token = getTokenFromStorage(); // Implement this method
//       if (token != null) {
//         options.headers['Authorization'] = 'Bearer $token';
//       }
      //       options.headers.addAll({
      //   "Content-Type": "application/json",
      //   "Accept": "*/*",
      // });
      // // if (MemoryManagement.getAccessToken() != null) {
      // //   options.headers.addAll({
      // //     "Authorization": "Bearer ${MemoryManagement.getLoginToken()}",
      // //     "access-token": "Bearer ${MemoryManagement.getAccessToken()}"
      // //   });
      // // }
      // return super.onRequest(options, handler);
      return handler.next(options); // Proceed with the request
    }, onResponse: (response, handler) {
      // Log response status code and data
      print('--- Response ---');
      print('Status Code: ${response.statusCode}');
      print('Data: ${response.data}');
      return handler.next(response); // Proceed with the response
    }, onError: (DioException e, ErrorInterceptorHandler handler) async {
      // Log error details
      print('--- Error ---');
      print('Message: ${e.message}');
      // await refreshToken();
      // try {
      //   handler.resolve(await _retry(e.requestOptions));
      // } on DioException catch (e) {
      //   handler.next(e);
      // }

      // return;
      return handler.next(e); // Proceed with the error
    }));
  }

  Future<Response<dynamic>> refreshToken() async {
    var response = await _dio.post("refresh token URL",
        options: Options(
            headers: {"Refresh-Token": "get refresh token from your storage"}));

    if (response.statusCode == 200) {
      // LoginResponse loginResponse = LoginResponse.fromJson(response.data);

      //   await setAuthenticationValuesInMemoryManagement(
      //       accessToken: loginResponse.accessToken,
      //       refreshToken: loginResponse.refreshToken);
    }
    return response;
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: {
        // "Authorization": "Bearer ${MemoryManagement.getLoginToken()}",
        // "access-token": "Bearer ${MemoryManagement.getAccessToken()}"
      },
    );

    return _dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}

//  void _setupInterceptors() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onRequest: (options, handler) {
//       // Assume you have a method to get a stored token
//       String? token = getTokenFromStorage(); // Implement this method
//       if (token != null) {
//         options.headers['Authorization'] = 'Bearer $token';
//       }
//       return handler.next(options); // Proceed with the request
//     },
//     onError: (DioError e, handler) {
//       if (e.response?.statusCode == 401) {
//         // Handle unauthorized access
//         print('Unauthorized! Refreshing token...');
//         refreshAuthToken().then((newToken) {
//           if (newToken != null) {
//             options.headers['Authorization'] = 'Bearer $newToken';
//             return handler.resolve(_dio.request(
//               options.path,
//               data: options.data,
//               queryParameters: options.queryParameters,
//               options: options,
//             ));
//           }
//         });
//       }
//       return handler.next(e); // Proceed with the error
//     },
//   ));
// }
// void _setupInterceptors() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onError: (DioError e, handler) async {
//       if (e.type == DioErrorType.other) { // Check for network errors
//         print('Network error, retrying...');
//         try {
//           final response = await _dio.request(
//             e.requestOptions.path,
//             data: e.requestOptions.data,
//             queryParameters: e.requestOptions.queryParameters,
//             options: e.requestOptions,
//           );
//           return handler.resolve(response); // Resolve with the response
//         } catch (retryError) {
//           return handler.next(retryError); // If retry fails, pass the error
//         }
//       }
//       return handler.next(e); // Proceed with the error
//     },
//   ));
// }

// void _setupInterceptors() {
//   _dio.interceptors.add(InterceptorsWrapper(
//     onResponse: (response, handler) {
//       final remaining = response.headers['X-RateLimit-Remaining'];
//       if (remaining != null && int.parse(remaining.first) == 0) {
//         // Handle the case where the rate limit is exceeded
//         print('Rate limit exceeded. Please wait before making new requests.');
//       }
//       return handler.next(response); // Proceed with the response
//     },
//   ));
// }
