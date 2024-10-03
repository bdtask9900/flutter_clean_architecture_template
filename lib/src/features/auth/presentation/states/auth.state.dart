import '../../../../core/states/api.state.dart';
import '../../domain/model/user.dart';

class AuthState {
  final ApiState<User> userState;
  final ApiState<List<ProductModel>> productState;

  AuthState({
    required this.userState,
    required this.productState,
  });

  factory AuthState.initial() {
    return AuthState(
      userState: ApiState<User>(),
      productState: ApiState<List<ProductModel>>(),
    );
  }

  AuthState copyWith({
    ApiState<User>? userState,
    ApiState<List<ProductModel>>? productState,
  }) {
    return AuthState(
      userState: userState ?? this.userState,
      productState: productState ?? this.productState,
    );
  }
}
