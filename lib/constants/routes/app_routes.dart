
import 'package:flutter/material.dart';
import 'package:news_app/constants/routes/pages_route_name.dart';
import 'package:news_app/features/home/home_screen.dart';

import '../../features/splashScreen/splash_screen.dart';

abstract class AppRoutes{

  static Route onGenerateRoute(RouteSettings settings){

    switch(settings.name){
      case PagesRouteName.initial:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
          settings: settings,
        );
      case PagesRouteName.home:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (context) =>  SplashScreen(),
          settings: settings,
        );
    }

  }
}