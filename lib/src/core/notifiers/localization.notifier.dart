import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationNotifier extends StateNotifier<Locale> {
  LocalizationNotifier() : super(Locale('en')) {
    loadLanguage();
  } // Default to English

  Future<void> loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language') ?? 'en';
    state = Locale(languageCode);
  }

  Future<void> changeLanguage(String langCode, BuildContext context) async {
    state = Locale(langCode);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', langCode);
    await EasyLocalization.of(context)!
        .setLocale(state); // Change locale in easy_localization
  }
}

final localizationProvider =
    StateNotifierProvider<LocalizationNotifier, Locale>((ref) {
  return LocalizationNotifier();
});
