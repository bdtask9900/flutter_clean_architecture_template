import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

import 'core/services/connectivity_service.dart';
import 'core/services/storage_service.dart';

final getIt = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    getIt.registerLazySingleton<ISharedPreferencesService>(
        () => StorageService());
    //  Get.lazyPut(() => StorageService());
    // Get.put<ThemeServices>(ThemeServices(),permanent: true);
    //  Get.lazyPut(() => SocketDBService(AppConfig.marketUrl));
  }
}

//service

final sharedPreferencesServiceProvider =
    Provider<ISharedPreferencesService>((ref) {
  return StorageService();
});
final connectionServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});
