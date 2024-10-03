import '../model/user.dart';

abstract class AuthRepository {
  Future<List<User>> getUserList();
  Future<NewUser> addNewUser(String name, String job);
  Future<NewUser> updateUser(String id, String name, String job);
  Future<void> deleteUser(String id);
  Future<dynamic> signUp(String email, String username, String password);
  Future<dynamic> login(String email, String password);
  Future<User> getUser(int userId);
  Future<List<ProductModel>> getProducts();
}
