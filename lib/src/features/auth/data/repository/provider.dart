import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/core/services/api_service.dart';

import '../../domain/repository/user_repository.dart';
import 'user_repository_implementation.dart';

final userListProvider = Provider<UserRepository>((ref) {
  var api = ref.watch(apiServiceProvider);
  return UserRepositoryImpl(api);
});

final newUserProvider = Provider<UserRepository>((ref) {
  var api = ref.watch(apiServiceProvider);
  return UserRepositoryImpl(api);
});

final updateUserProvider = Provider<UserRepository>((ref) {
  var api = ref.watch(apiServiceProvider);
  return UserRepositoryImpl(api);
});

final deleteUserProvider = Provider<UserRepository>((ref) {
  var api = ref.watch(apiServiceProvider);
  return UserRepositoryImpl(api);
});
