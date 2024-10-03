import 'package:shared_preferences/shared_preferences.dart';

extension SharedPreferencesExtensions on SharedPreferences {
  Future<void> setStringWithLogging(String key, String value) async {
    print('Saving $key = $value');
    await setString(key, value);
  }

  String? getStringWithLogging(String key) {
    final value = getString(key);
    print('Retrieving $key = $value');
    return value;
  }
}