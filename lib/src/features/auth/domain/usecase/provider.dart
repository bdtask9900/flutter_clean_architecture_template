import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repository/provider.dart';
import 'user_usecase.dart';

final usersListProvider = Provider<UserUseCase>((ref){
  return UserUseCaseImpl(ref.read(userListProvider));
});

final createUserProvider = Provider<UserUseCase>((ref){
  return UserUseCaseImpl(ref.read(newUserProvider));
});
 
final updateUserDataProvider = Provider<UserUseCase>((ref){
  return UserUseCaseImpl(ref.read(updateUserProvider));
});

final deleteUserDataProvider = Provider<UserUseCase>((ref){
  return UserUseCaseImpl(ref.read(deleteUserProvider));
});