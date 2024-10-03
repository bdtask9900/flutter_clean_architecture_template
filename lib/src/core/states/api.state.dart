
enum ApiStatus { initial, loading, success, error }

class ApiState<T> {
  final ApiStatus status;
  final T? data;
  final String? message;

  ApiState({this.status = ApiStatus.initial, this.data, this.message});

  ApiState<T> copyWith({ApiStatus? status, T? data, String? message}) {
    return ApiState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  bool get isLoading => status == ApiStatus.loading;
  bool get isSuccess => status == ApiStatus.success;
  bool get isError => status == ApiStatus.error;
}
