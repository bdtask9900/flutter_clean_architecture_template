import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/features/auth/data/repository/auth_repository_impl.dart';

import '../../../../core/states/api.state.dart';
import '../../domain/model/user.dart';
import '../../domain/repository/auth_repository.dart';
import '../states/auth.state.dart';

final emailCodeController = Provider.autoDispose<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
final testEditingControllerProvider =
    Provider.autoDispose((ref) => TextEditingController());
final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = ref.read(authRepoProvider);
  return AuthNotifier(authRepository);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;

  AuthNotifier(this.authRepository) : super(AuthState.initial());

  // Fetch user data
  Future<void> fetchUser(int userId) async {
    state = state.copyWith(
      userState: state.userState.copyWith(status: ApiStatus.loading),
    );
    try {
      final user = await authRepository.getUser(userId);
      state = state.copyWith(
        userState: ApiState<User>(
          status: ApiStatus.success,
          data: user,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        userState: state.userState.copyWith(
          status: ApiStatus.error,
          message: e.toString(),
        ),
      );
    }
  }

  // Fetch products
  Future<void> fetchProducts() async {
    state = state.copyWith(
      productState: state.productState.copyWith(status: ApiStatus.loading),
    );
    try {
      final products = await authRepository.getProducts();
      state = state.copyWith(
        productState: ApiState<List<ProductModel>>(
          status: ApiStatus.success,
          data: products,
        ),
      );
    } catch (e) {
      state = state.copyWith(
        productState: state.productState.copyWith(
          status: ApiStatus.error,
          message: e.toString(),
        ),
      );
    }
  }
}
