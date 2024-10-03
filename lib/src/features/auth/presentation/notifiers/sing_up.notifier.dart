// SignUp Notifier to handle form validation and API call
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/features/auth/data/repository/auth_repository_impl.dart';
import 'package:go_riverpod_dio/src/features/auth/domain/repository/auth_repository.dart';

import '../states/sign_up.state.dart';

final signUpProvider =
    StateNotifierProvider<SignUpNotifier, SignUpState>((ref) {
  final authRepo = ref.watch(authRepoProvider);
  return SignUpNotifier(authRepository: authRepo);
});

class SignUpNotifier extends StateNotifier<SignUpState> {
  final AuthRepository authRepository;

  SignUpNotifier({required this.authRepository})
      : super(SignUpState(isSubmitting: false, isSuccess: false));

  Future<void> signUp(String email, String username, String password) async {
    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      final response = await authRepository.signUp(email, username, password);

      // Handle successful response
      if (response.statusCode == 200) {
        state = state.copyWith(isSuccess: true, isSubmitting: false);
      }
    } catch (e) {
      // Handle errors (show error message in UI)
      state = state.copyWith(
        isSuccess: false,
        isSubmitting: false,
        errorMessage: e.toString(),
      );
    }
  }
}
