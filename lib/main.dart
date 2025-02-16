import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/provider/app_language_provider.dart';
import 'package:news_app/provider/app_theme_provider.dart';
import 'package:news_app/provider/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';
import 'constants/routes/app_routes.dart';
import 'constants/theme/app_theme_manager.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppLanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppThemeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => HomeViewModel(),
        ),
      ],
      child:  MyApp()));
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppThemeManager.lightMode,
      darkTheme: AppThemeManager.DarkMode,
      themeMode: themeProvider.appTheme,

      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
