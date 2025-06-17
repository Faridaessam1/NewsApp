import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/theme/app_colors.dart';
import '../../constants/theme/app_styles.dart';
import '../../provider/app_theme_provider.dart';
import '../../provider/viewModel/home_view_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../home/widgets/my_drawer_custom_widget.dart';

class ArticleDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var homeProvider = Provider.of<HomeViewModel>(context);

    return Scaffold(
      backgroundColor: themeProvider.appTheme == ThemeMode.light
          ? Colors.white
          : Colors.black,
      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? Colors.white
            : Colors.black,
        iconTheme: IconThemeData(
          color: themeProvider.appTheme == ThemeMode.light
              ? Colors.black
              : Colors.white,
        ),
        title: Text(
          homeProvider.selectedCategory == null
              ? AppLocalizations.of(context)!.home
              : homeProvider.selectedCategory!.CategoryName,
          style: themeProvider.appTheme == ThemeMode.light
              ? AppStyles.W500Black20
              : AppStyles.W500Black20.copyWith(
              color: AppColors.primaryColorLight),
        ),
      ),
      drawer: Drawer(
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? Colors.white
            : Colors.black,
        child: MyDrawerCustomWidget(),
      ),
    );
  }
}