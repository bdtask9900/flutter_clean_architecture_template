

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) {
  // final authenticationService = ref.watch(authenticationServiceProvider);
  final Dio dio = Dio();

  ref.onDispose(dio.close);

  return dio
    ..interceptors.addAll([
      AuthenticatorInterceptor(
        // authenticationService, 
        dio), //this interceptor holds a reference of your authService and the dio instance that uses it
    ]);
}, name: 'Dio');

class AuthenticatorInterceptor extends Interceptor {
  // final AuthenticationService authService;
  final Dio dioReference;

  AuthenticatorInterceptor(
    // this.authService,
     this.dioReference);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // Tokens _tokens = await authService.token;
    // /// get the token from your authService and do some logic with it:
    // /// check if its still valid (expirationTime)
    // /// refresh it if its not, etc.
    // if (_token.refreshToken != null && _token.hasExpired) { // check somehow if the token is invalid and try to refresh it
    // try {
    //     dioReference.lock(); // lock the current dio instance
    //     authService.refresh(); //try to get a new access token
    //     _tokens = await authService.token; //get the new token if the refresh was succesful
    //   } on DioError catch (error) { // there was an error refreshing, report it or do some logic
    //     dioReference.clear();
    //     return handler.reject(error);
    //   } finally {
    //     dioReference.unlock(); //unlock the instance and move on
    //   }
    // }
    // // if there was no error you can move on with your request with the new token (if any)
    // options.headers
    //     .putIfAbsent(HttpHeaders.authorizationHeader, () => "Bearer ${_tokens.accessToken}");
  
    return handler.next(options);
  }

  @override
  void onError(DioError error, ErrorInterceptorHandler handler) async {
    // if (error.type == DioErrorType.response &&
    //     error.response!.statusCode == 401) {
    //   // If you still receive 401 then maybe you should logout and report the user that the refresh token is invalid (maybe the server removed it)
    // }
    return super.onError(error, handler);
  }
}