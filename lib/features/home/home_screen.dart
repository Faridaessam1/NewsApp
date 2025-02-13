import 'package:flutter/material.dart';
import 'package:news_app/constants/routes/pages_route_name.dart';
import 'package:news_app/constants/theme/app_assets.dart';
import 'package:news_app/constants/theme/app_colors.dart';
import 'package:news_app/constants/widgets/custom_drop_down_menu.dart';
import 'package:news_app/features/home/widgets/home_category_card_widget.dart';
import 'package:news_app/features/home/widgets/my_drawer_custom_widget.dart';
import 'package:news_app/models/categoryModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../constants/theme/app_styles.dart';
import '../../provider/app_language_provider.dart';
import '../../provider/app_theme_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var ThemeProvider = Provider.of<AppThemeProvider>(context);
    List<CategoryDataModel> categories = [
      CategoryDataModel(
        CategoryID: "general",
        CategoryName: "General",
        CategoryImg: ThemeProvider.appTheme == ThemeMode.light ? AppAssets.generalLight : AppAssets.generalDark,
      ),
      CategoryDataModel(
        CategoryID: "business",
        CategoryName: "Business",
        CategoryImg: ThemeProvider.appTheme == ThemeMode.light ? AppAssets.businessLight : AppAssets.businessDark,
      ),
      CategoryDataModel(
        CategoryID: "sports",
        CategoryName: "Sports",
        CategoryImg: ThemeProvider.appTheme == ThemeMode.light ? AppAssets.sportsLight : AppAssets.sportsDark,
      ),
      CategoryDataModel(
        CategoryID: "technology",
        CategoryName: "Technology",
        CategoryImg: ThemeProvider.appTheme == ThemeMode.light ? AppAssets.technologyLight : AppAssets.technologyDark,
      ),
      CategoryDataModel(
        CategoryID: "science",
        CategoryName: "Science",
        CategoryImg: ThemeProvider.appTheme == ThemeMode.light ? AppAssets.scienceLight :  AppAssets.scienceDark,
      ),
      CategoryDataModel(
        CategoryID: "health",
        CategoryName: "Health",
        CategoryImg: ThemeProvider.appTheme == ThemeMode.light ? AppAssets.healthLight :  AppAssets.healthDark,
      ),
      CategoryDataModel(
        CategoryID: "entertainment",
        CategoryName: "Entertainment",
        CategoryImg: ThemeProvider.appTheme == ThemeMode.light ? AppAssets.entertainmentLight : AppAssets.entertainmentDark,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemeProvider.appTheme == ThemeMode.light ? AppColors.primaryColorLight : AppColors.primaryColorDark,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.home,
          style:  ThemeProvider.appTheme == ThemeMode.light
              ? AppStyles.W500Black20
              : AppStyles.W500Black20.copyWith(
              color: AppColors.primaryColorLight),
        ),
        actions: [
          Icon(
            Icons.search,
            color:  ThemeProvider.appTheme == ThemeMode.light ? AppColors.primaryColorDark : AppColors.primaryColorLight,
          ),
        ],
        ),
      drawer: Drawer(
        child: MyDrawerCustomWidget(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.goodMorning,
                style: ThemeProvider.appTheme == ThemeMode.light
                    ? AppStyles.W500Black24
                    : AppStyles.W500Black24.copyWith(
                        color: AppColors.primaryColorLight),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) => HomeCategoryCardWidget(
                  index: index,
                  categories: categories,
                ),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 3,
                ),
                itemCount: categories.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
