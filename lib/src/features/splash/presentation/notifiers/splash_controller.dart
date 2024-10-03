import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/core/network/api_response.dart';
import 'package:go_riverpod_dio/src/core/services/api_service.dart';
import 'package:go_riverpod_dio/src/pkg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/services/storage_service.dart';
import '../../../auth/data/repository/user_repository_implementation.dart';

final splashController =
    AutoDisposeNotifierProvider<SplashController, void>(SplashController.new);

class SplashController extends AutoDisposeNotifier<void> {
  var pref = StorageService();
  @override
  FutureOr<void> build() async {
    printLog('call splash controller::::');

    pref.saveString('test', "mostafizur");
    await getIt<StorageService>().saveInt("age", 30);
  }

  void goRouterSplsh(BuildContext context) async {
    // await Future.delayed(Duration(seconds: 5));
    // context.go(Routes.userPath);
    Timer(const Duration(seconds: 2), () {
      // context.goNamed(Routes.home);
      // context.go(Routes.userPath);
      // context.goNamed(Routes.signUp);
    });
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   await Future.delayed(Duration(seconds: 3));
    //   context.goNamed(Routes.user);
    // });
  }
}

final apiTestProvider = FutureProvider<dynamic>((ref) async {
  // var api=ref.watch(apiServiceProvider);
  // var result=await api.fetchData('users');
  var repo = ref.watch(userRepositoryProvider);
  var result = await repo.fetchUsers();
  printLog(result);
  printLog('get api test ');

  return null;
});
