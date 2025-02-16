import 'package:flutter/material.dart';
import 'package:news_app/constants/theme/app_colors.dart';
import 'package:news_app/features/home/widgets/home_view_widget.dart';
import 'package:news_app/features/home/widgets/my_drawer_custom_widget.dart';
import 'package:news_app/features/home/widgets/selected_category_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/network/api_network.dart';
import 'package:news_app/provider/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/app_styles.dart';
import '../../provider/app_theme_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    var homeProvider = Provider.of<HomeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? AppColors.primaryColorLight
            : AppColors.primaryColorDark,
        centerTitle: true,
        title: Text(
          homeProvider.selectedCategory == null
              ? AppLocalizations.of(context)!.home
              : homeProvider.selectedCategory!.CategoryName,
          style: themeProvider.appTheme == ThemeMode.light
              ? AppStyles.W500Black20
              : AppStyles.W500Black20.copyWith(
                  color: AppColors.primaryColorLight),
        ),
        actions: [
          Icon(
            Icons.search,
            color: themeProvider.appTheme == ThemeMode.light
                ? AppColors.primaryColorDark
                : AppColors.primaryColorLight,
            size: 35,
          ),
          SizedBox(width: 5,)
        ],
      ),
      drawer: Drawer(
        child: MyDrawerCustomWidget(),
      ),
      body: homeProvider.selectedCategory == null
          ? HomeViewWidget(
              categories : homeProvider.categories,
              onCategoryClicked: homeProvider.onCategoryClicked,
            )
          : SelectedCategoryView(
              selectedCategoryModel: homeProvider.selectedCategory!,
            ),
    );
  }


}
