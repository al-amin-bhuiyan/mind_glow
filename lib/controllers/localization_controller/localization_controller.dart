import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationController extends GetxController {
  final String _prefKey = 'app_language';
  
  // Observable to track current locale if needed in UI
  final Rx<Locale> _currentLocale = const Locale('en').obs;
  Locale get currentLocale => _currentLocale.value;

  // Loads the saved language or defaults to English
  Future<void> loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString(_prefKey);
    if (savedLanguage != null) {
      _currentLocale.value = Locale(savedLanguage);
      Get.updateLocale(_currentLocale.value);
    } else {
      // Default to English
      _currentLocale.value = const Locale('en');
      Get.updateLocale(_currentLocale.value);
    }
  }

  // Changes language and saves to preferences
  Future<void> changeLanguage(String languageCode) async {
    final locale = Locale(languageCode);
    _currentLocale.value = locale;
    Get.updateLocale(locale); // Instantly updates the UI
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, languageCode);
  }
}
