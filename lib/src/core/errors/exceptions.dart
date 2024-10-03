class ServerException implements Exception {
  final String message;
  ServerException(this.message);
}

class NetworkException implements Exception {}

class UnauthorizedException implements Exception {
  final String message;
  UnauthorizedException(this.message);
}