import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../constants/theme/app_colors.dart';
import '../../../constants/theme/app_styles.dart';
import '../../../constants/widgets/custom_drop_down_menu.dart';
import '../../../main.dart';
import '../../../provider/app_language_provider.dart';
import '../../../provider/app_theme_provider.dart';
import '../../../provider/viewModel/home_view_model.dart';

class MyDrawerCustomWidget extends StatefulWidget {
  @override
  State<MyDrawerCustomWidget> createState() => _MyDrawerCustomWidgetState();
}

class _MyDrawerCustomWidgetState extends State<MyDrawerCustomWidget> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var homeProvider = Provider.of<HomeViewModel>(context);

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: height * 0.3,
          decoration: BoxDecoration(
            color: themeProvider.appTheme == ThemeMode.light
                ? AppColors.primaryColorDark
                : AppColors.primaryColorDark,
          ),
          child: Center(
            child: Text(
              "News App",
              style: AppStyles.W500Black24.copyWith(
                fontWeight: FontWeight.w700,
                color: themeProvider.appTheme == ThemeMode.light
                    ? Colors.white
                    : AppColors.primaryColorLight,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.light
                  ? Colors.white
                  : Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      navigatorKey.currentState!.pop();
                      homeProvider.goToHome();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: themeProvider.appTheme == ThemeMode.light
                            ? Colors.grey[100]
                            : Colors.grey[800],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.home,
                            color: themeProvider.appTheme == ThemeMode.light
                                ? AppColors.primaryColorDark
                                : AppColors.primaryColorLight,
                            size: 30,
                          ),
                          const SizedBox(width: 15),
                          Text(
                            AppLocalizations.of(context)!.goToHome,
                            style: AppStyles.W500Black20.copyWith(
                              color: themeProvider.appTheme == ThemeMode.light
                                  ? Colors.black
                                  : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.theme,
                    style: AppStyles.W500Black20.copyWith(
                      color: themeProvider.appTheme == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomDropdownMenu(
                      value: themeProvider.appTheme == ThemeMode.light
                          ? "Light"
                          : "Dark",
                      dropdownColor: themeProvider.appTheme == ThemeMode.light
                          ? Colors.white
                          : Colors.grey[800]!,
                      hintText: 'Choose Theme',
                      fontWeight: FontWeight.w400,
                      options: const ["Light", "Dark"],
                      onChange: (String? theme) {
                        if (theme == "Light") {
                          themeProvider.changeAppTheme(ThemeMode.light);
                        } else {
                          themeProvider.changeAppTheme(ThemeMode.dark);
                        }
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.language,
                    style: AppStyles.W500Black20.copyWith(
                      color: themeProvider.appTheme == ThemeMode.light
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: CustomDropdownMenu(
                      value: languageProvider.appLanguage == "en"
                          ? "English"
                          : "Arabic",
                      dropdownColor: themeProvider.appTheme == ThemeMode.light
                          ? Colors.white
                          : Colors.grey[800]!,
                      hintText: 'Choose Language',
                      fontWeight: FontWeight.w400,
                      options: const ["English", "Arabic"],
                      onChange: (String? language) {
                        if (language == languageProvider.appLanguage) return;

                        if (language == "Arabic") {
                          languageProvider.changeAppLanguage("ar");
                        } else {
                          languageProvider.changeAppLanguage("en");
                        }
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}