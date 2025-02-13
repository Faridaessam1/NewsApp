import 'package:flutter/material.dart';

import 'app_colors.dart';

abstract class AppThemeManager{

  static ThemeData lightMode = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryColorLight,
  );


  static ThemeData DarkMode = ThemeData(
    scaffoldBackgroundColor: AppColors.primaryColorDark,

appBarTheme: AppBarTheme(
  backgroundColor: AppColors.primaryColorDark
),
  );
}