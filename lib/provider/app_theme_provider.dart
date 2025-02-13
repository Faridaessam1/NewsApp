import 'package:flutter/material.dart';

class AppThemeProvider extends ChangeNotifier{
  ThemeMode appTheme = ThemeMode.dark;

  void changeAppTheme(ThemeMode newTheme){
    if(appTheme == newTheme) return;
    appTheme = newTheme;
    notifyListeners();
  }
}