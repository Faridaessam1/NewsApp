import 'package:flutter/material.dart';
import 'package:news_app/constants/theme/app_assets.dart';
import 'package:news_app/constants/theme/app_colors.dart';
import 'package:news_app/features/home/widgets/home_category_card_widget.dart';
import 'package:news_app/models/categoryModel.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../constants/theme/app_styles.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CategoryDataModel> categories = [
    CategoryDataModel(
      CategoryID: "general",
      CategoryName: "General",
      CategoryImg: AppAssets.generalLight,
    ),
    CategoryDataModel(
      CategoryID: "business",
      CategoryName: "Business",
      CategoryImg: AppAssets.businessLight,
    ),
    CategoryDataModel(
      CategoryID: "sports",
      CategoryName: "Sports",
      CategoryImg: AppAssets.sportsLight,
    ),
    CategoryDataModel(
      CategoryID: "technology",
      CategoryName: "Technology",
      CategoryImg: AppAssets.technologyLight,
    ),
    CategoryDataModel(
      CategoryID: "science",
      CategoryName: "Science",
      CategoryImg: AppAssets.scienceLight,
    ),
    CategoryDataModel(
      CategoryID: "health",
      CategoryName: "Health",
      CategoryImg: AppAssets.healthLight,
    ),
    CategoryDataModel(
      CategoryID: "entertainment",
      CategoryName: "Entertainment",
      CategoryImg: AppAssets.entertainmentLight,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.home,
          style: AppStyles.W500Black20,
        ),
        actions: [
          Icon(
            Icons.search,
            color: AppColors.primaryColorDark,
          ),
        ],
      ),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                " Good Morning\n Here is Some News For You",
                style: AppStyles.W500Black24,
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
