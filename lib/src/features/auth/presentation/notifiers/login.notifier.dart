// Login Notifier to handle login logic
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/features/auth/data/repository/auth_repository_impl.dart';

import '../../domain/repository/auth_repository.dart';
import '../states/login.state.dart';

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  var authRepo = ref.watch(authRepoProvider);
  return LoginNotifier(authRepo);
});

class LoginNotifier extends StateNotifier<LoginState> {
  final AuthRepository authRepository;

  LoginNotifier(this.authRepository)
      : super(LoginState(isSubmitting: false, isSuccess: false));

  Future<void> login(String email, String password) async {
    state = state.copyWith(isSubmitting: true, errorMessage: null);

    try {
      final response = await authRepository.login(email, password);

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
