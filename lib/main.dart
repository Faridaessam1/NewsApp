import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/provider/app_language_provider.dart';
import 'package:news_app/provider/app_theme_provider.dart';
import 'package:provider/provider.dart';
import 'constants/routes/app_routes.dart';
import 'constants/theme/app_theme_manager.dart';

void main() {
  runApp(
      MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AppLanguageProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppThemeProvider(),
        )
      ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var ThemeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      onGenerateRoute: AppRoutes.onGenerateRoute,
      theme: AppThemeManager.lightMode,
      darkTheme: AppThemeManager.DarkMode,
      themeMode: ThemeProvider.appTheme,

      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
