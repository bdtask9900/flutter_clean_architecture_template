class LoginState {
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  LoginState({
    required this.isSubmitting,
    required this.isSuccess,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return LoginState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
