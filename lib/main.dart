import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/core/services/storage_service.dart';
import 'src/pkg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await StorageService.instance.init();
  DependencyInjection.init();
  var langConde = StorageService.instance.getString('language') ?? 'en';

  runApp(ProviderScope(
      child: EasyLocalization(
          supportedLocales: const [Locale('en'), Locale('ar'), Locale('bn')],
          path: 'assets/lang', // Path to language JSON files
          fallbackLocale: Locale('$langConde'), // Default locale
          child: const MyApp())));
}
