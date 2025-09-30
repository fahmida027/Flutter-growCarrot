import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  Locale _locale = const Locale('en');
  
  Locale get locale => _locale;
  
  bool get isBangla => _locale.languageCode == 'bn';
  
  LanguageProvider() {
    _loadLanguage();
  }
  
  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final languageCode = prefs.getString('language_code') ?? 'en';
    _locale = Locale(languageCode);
    notifyListeners();
  }
  
  Future<void> setLanguage(Locale locale) async {
    if (_locale == locale) return;
    
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    notifyListeners();
  }
  
  Future<void> toggleLanguage() async {
    final newLocale = _locale.languageCode == 'en' 
        ? const Locale('bn') 
        : const Locale('en');
    await setLanguage(newLocale);
  }
  
  String getLanguageCode() {
    return _locale.languageCode;
  }
  
  String getLanguageName() {
    return _locale.languageCode == 'bn' ? 'বাংলা' : 'English';
  }
  
  String getOtherLanguageName() {
    return _locale.languageCode == 'bn' ? 'English' : 'বাংলা';
  }
}