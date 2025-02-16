import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../constants/theme/app_colors.dart';
import '../../../constants/theme/app_styles.dart';
import '../../../models/categoryModel.dart';
import '../../../provider/app_theme_provider.dart';
import 'home_category_card_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeViewWidget extends StatelessWidget {
  List<CategoryDataModel> categories;
  void Function(CategoryDataModel) onCategoryClicked;

  HomeViewWidget({required this.onCategoryClicked , required this.categories});

  @override
  Widget build(BuildContext context) {
    var ThemeProvider = Provider.of<AppThemeProvider>(context);

    return SingleChildScrollView(
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
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  onCategoryClicked(categories[index]);
                  },
                child: HomeCategoryCardWidget(
                  index: index,
                  categories: categories,
                ),
              ),
              separatorBuilder: (context, index) => const SizedBox(
                height: 3,
              ),
              itemCount: categories.length,
            ),
          ],
        ),
      ),
    );
  }
}
