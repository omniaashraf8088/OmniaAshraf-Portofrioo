import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  String _currentLanguage = 'en';

  String get currentLanguage => _currentLanguage;
  bool get isRTL => _currentLanguage == 'ar';

  LanguageProvider() {
    _loadLanguagePreference();
  }

  Future<void> _loadLanguagePreference() async {
    final prefs = await SharedPreferences.getInstance();
    _currentLanguage = prefs.getString('language') ?? 'en';
    notifyListeners();
  }

  Future<void> toggleLanguage() async {
    _currentLanguage = _currentLanguage == 'en' ? 'ar' : 'en';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', _currentLanguage);

    notifyListeners();
  }

  String translate(String enText, String arText) {
    return _currentLanguage == 'ar' ? arText : enText;
  }
}
