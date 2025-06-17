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

  HomeViewWidget({required this.onCategoryClicked, required this.categories});

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Container(
      color: themeProvider.appTheme == ThemeMode.light
          ? Colors.white
          : Colors.black,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
              _getGreeting(context),
                style: themeProvider.appTheme == ThemeMode.light
                    ? AppStyles.W500Black24
                    : AppStyles.W500Black24.copyWith(
                    color: AppColors.primaryColorLight),
              ),
              const SizedBox(height: 10),
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
                separatorBuilder: (context, index) => const SizedBox(height: 3),
                itemCount: categories.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
  String _getGreeting(BuildContext context) {
    final hour = DateTime.now().hour;
    final localizations = AppLocalizations.of(context)!;

    if (hour >= 5 && hour < 12) {
      return localizations.goodMorning; // Good Morning (5 AM - 12 PM)
    } else if (hour >= 12 && hour < 17) {
      return localizations.goodAfternoon; // Good Afternoon (12 PM - 5 PM)
    } else if (hour >= 17 && hour < 21) {
      return localizations.goodEvening; // Good Evening (5 PM - 9 PM)
    } else {
      return localizations.goodEvening; // Good Night (9 PM - 5 AM)
    }
  }
}
