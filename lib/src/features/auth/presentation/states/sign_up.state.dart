// SignUp State class to manage form states
class SignUpState {
  final bool isSubmitting;
  final bool isSuccess;
  final String? errorMessage;

  SignUpState({
    required this.isSubmitting,
    required this.isSuccess,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignUpState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
