import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_dio/src/core/routes/app_routes.dart';
import 'package:go_riverpod_dio/src/pkg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/configs/themes/theme_notifier.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/notifiers/localization.notifier.dart';
import '../notifiers/splash_controller.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();

    printLog('setState splash');
    homePageGo();
  }

  void homePageGo() async {
    await Future.delayed(Duration(seconds: 4));
    context.go('/user');
  }

  @override
  Widget build(BuildContext context) {
    // var api = ref.watch(apiTestProvider);
    var item = ref.watch(itemProvider);
    // printLog(api);
    printLog(item);
    final currentLocale = ref.watch(localizationProvider);
    final themeNotifier = ref.read(themeNotifierProvider.notifier);
    // var splashNotifier = ref.watch(splashController.notifier);

    // splashNotifier.goRouterSplsh(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('welcome')), // Translated welcome message
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(tr('hello')), // Translated hello message
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: currentLocale.languageCode, // Current language code
              items: <String>['en', 'ar', 'bn']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value
                      .toUpperCase()), // Display language code in uppercase
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  ref
                      .read(localizationProvider.notifier)
                      .changeLanguage(newValue, context); // Change language
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                themeNotifier.toggleTheme(); // Toggle theme on button press
              },
              child: Text('Toggle Theme'),
            ),
          ],
        ),
      ),
    );
  }
}
