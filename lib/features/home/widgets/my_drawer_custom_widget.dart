import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../constants/theme/app_styles.dart';
import '../../../constants/widgets/custom_drop_down_menu.dart';
import '../../../main.dart';
import '../../../provider/app_language_provider.dart';
import '../../../provider/app_theme_provider.dart';
import '../../../provider/viewModel/home_view_model.dart';

class MyDrawerCustomWidget extends StatefulWidget{
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

    return  Column(
      children: [
        Container(
          width: double.infinity,
          height: height * 0.3,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
              child: Text(
                "News App",
                style: AppStyles.W500Black24.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              )),
        ),
        SizedBox(
          width: 5,
        ),
        Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                       navigatorKey.currentState!.pop();
                       homeProvider.goToHome();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(
                            Icons.home,
                            color: Colors.white,
                            size: 40,
                          ),
                          Text(
                            AppLocalizations.of(context)!.goToHome,
                            style: AppStyles.W500Black20.copyWith(
                                color: Colors.white, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      AppLocalizations.of(context)!.theme,
                      style:
                      AppStyles.W500Black20.copyWith(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomDropdownMenu(
                        value: "Light",
                        dropdownColor: Colors.white,
                        // Ensure visibility
                        hintText: 'Choose Theme',
                        fontWeight: FontWeight.w400,
                        options: const ["Light", "Dark"],
                        onChange: (String? theme) {
                          if (theme == AppLocalizations.of(context)!.light) {
                            themeProvider.changeAppTheme(ThemeMode.light);
                          } else {
                            themeProvider.changeAppTheme(ThemeMode.dark);
                          }

                          setState(() {

                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 30,),
                    Text(
                      AppLocalizations.of(context)!.language,
                      style:
                      AppStyles.W500Black20.copyWith(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomDropdownMenu(
                        value: "English",
                        dropdownColor: Colors.white,
                        // Ensure visibility
                        hintText: 'Choose Language',
                        fontWeight: FontWeight.w400,
                        options: const ["English", "Arabic"],
                        onChange: (String? language) {
                          if(language == languageProvider.appLanguage ) return;

                          if (language == AppLocalizations.of(context)!.arabic) {
                            languageProvider.changeAppLanguage("ar");
                          } else {
                            languageProvider.changeAppLanguage("en");
                          }

                          setState(() {

                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}