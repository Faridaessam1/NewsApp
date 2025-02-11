import 'dart:async';

import 'package:flutter/material.dart';
import 'package:news_app/constants/routes/pages_route_name.dart';

import '../../constants/theme/app_colors.dart';

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
    return Scaffold(
        backgroundColor: AppColors.primaryColorLight,
        body: Center(
          child: Image.asset("assets/images/newsLogo.png"),
        )

    );
  }
}