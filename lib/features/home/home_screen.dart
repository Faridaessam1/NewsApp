import 'package:flutter/material.dart';
import 'package:news_app/constants/theme/app_colors.dart';
import 'package:news_app/constants/widgets/custom_text_form_field.dart';
import 'package:news_app/features/home/widgets/home_view_widget.dart';
import 'package:news_app/features/home/widgets/my_drawer_custom_widget.dart';
import 'package:news_app/features/home/widgets/selected_category_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:news_app/provider/viewModel/home_view_model.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/app_styles.dart';
import '../../provider/app_theme_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

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
            ? AppColors.primaryColorLight
            : AppColors.primaryColorDark,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: themeProvider.appTheme == ThemeMode.light
              ? Colors.black
              : AppColors.primaryColorLight,
        ),
        title: isSearching
            ? CustomTextFormField(
          hintText: "Search",
          controller: searchController,
        )
            : Text(
          homeProvider.selectedCategory == null
              ? AppLocalizations.of(context)!.home
              : homeProvider.selectedCategory!.CategoryName,
          style: themeProvider.appTheme == ThemeMode.light
              ? AppStyles.W500Black20.copyWith(color: Colors.white)
              : AppStyles.W500Black20.copyWith(
              color: AppColors.primaryColorLight),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  searchController.clear();
                }
              });
            },
            icon: Icon(
              Icons.search,
              size: 35,
              color: themeProvider.appTheme == ThemeMode.light
                  ? Colors.white
                  : AppColors.primaryColorLight,
            ),
          ),
          const SizedBox(width: 5),
        ],
      ),
      drawer: isSearching
          ? null
          : Drawer(
        backgroundColor: themeProvider.appTheme == ThemeMode.light
            ? Colors.black
            : Colors.white,
        child: MyDrawerCustomWidget(),
      ),
      body: homeProvider.selectedCategory == null
          ? HomeViewWidget(
        categories: homeProvider.categories,
        onCategoryClicked: homeProvider.onCategoryClicked,
      )
          : SelectedCategoryView(
        selectedCategoryModel: homeProvider.selectedCategory!,
      ),
    );
  }
}