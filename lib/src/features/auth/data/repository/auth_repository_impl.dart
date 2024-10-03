import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/core/services/api_service.dart';
import 'package:go_riverpod_dio/src/features/auth/domain/model/user.dart';
import 'package:go_riverpod_dio/src/features/auth/domain/repository/auth_repository.dart';

final authRepoProvider = Provider<AuthRepository>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  return AuthRepositoryImpl(apiServices: apiService);
});

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiServices;

  AuthRepositoryImpl({required this.apiServices});
  @override
  Future<NewUser> addNewUser(String name, String job) {
    // TODO: implement addNewUser
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUser(String id) {
    // TODO: implement deleteUser
    throw UnimplementedError();
  }

  @override
  Future<List<User>> getUserList() {
    // TODO: implement getUserList
    throw UnimplementedError();
  }

  @override
  Future signUp(String email, String username, String password) {
    return apiServices.fetchData('endpoint');
  }

  @override
  Future<NewUser> updateUser(String id, String name, String job) {
    // TODO: implement updateUser
    throw UnimplementedError();
  }

  @override
  Future<dynamic> login(String email, String password) async {
    final response = await apiServices.postData(
      '/login', // Replace with your login endpoint
      {
        'email': email,
        'password': password,
      },
    );
    return response;
  }

  @override
  Future<List<ProductModel>> getProducts() async {
    return [
      ProductModel(id: '1', name: 'Product 1', price: 10.0),
      ProductModel(id: '2', name: 'Product 2', price: 20.0),
    ];
  }

  @override
  Future<User> getUser(int userId) async {
    return User(
        id: userId,
        firstName: 'John Doe',
        email: 'john.doe@example.com',
        lastName: "",
        avatar: "");
  }
}
