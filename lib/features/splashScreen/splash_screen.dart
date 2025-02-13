import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/constants/routes/pages_route_name.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/app_colors.dart';
import '../../provider/app_theme_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(
          seconds: 3,
        ),

            () {
          Navigator.pushNamedAndRemoveUntil(
            context, PagesRouteName.home, (route) => false,
          );
        }

    );
  }

  @override
  Widget build(BuildContext context) {
    var ThemeProvider = Provider.of<AppThemeProvider>(context);

    return Scaffold(
        backgroundColor:ThemeProvider.appTheme == ThemeMode.light ? AppColors.primaryColorLight :AppColors.primaryColorDark ,
        body: Center(
          child: Image.asset("assets/images/newsLogo.png" , color: ThemeProvider.appTheme == ThemeMode.dark ? AppColors.primaryColorLight :AppColors.primaryColorDark ,),
        )

    );
  }
}