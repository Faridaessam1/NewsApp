import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/widgets/news_card_widget.dart';
import 'package:news_app/models/categoryModel.dart';
import 'package:provider/provider.dart';
import '../../../constants/theme/app_colors.dart';
import '../../../constants/theme/app_styles.dart';
import '../../../constants/widgets/custom_elevated_button.dart';
import '../../../models/articles_model.dart';
import '../../../provider/app_theme_provider.dart';
import '../../../provider/viewModel/home_view_model.dart';

class SelectedCategoryView extends StatefulWidget {
  final CategoryDataModel selectedCategoryModel;

  const SelectedCategoryView({
    super.key,
    required this.selectedCategoryModel,
  });

  @override
  State<SelectedCategoryView> createState() => _SelectedCategoryViewState();
}

class _SelectedCategoryViewState extends State<SelectedCategoryView> {
  late HomeViewModel _viewModel;

  @override
  void initState() {
    _viewModel = Provider.of<HomeViewModel>(context, listen: false);
    Future.wait([
      _viewModel.getAllSources(),
    ]).then((value) {
      _viewModel.getAllArticles();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);

    return Container(
      color: themeProvider.appTheme == ThemeMode.light
          ? Colors.white
          : Colors.black,
      child: Column(
        children: [
          DefaultTabController(
            length: _viewModel.sourceList.length,
            child: Container(
              color: Colors.transparent,
              child: TabBar(
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                indicatorColor: themeProvider.appTheme == ThemeMode.dark
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark,
                labelColor: themeProvider.appTheme == ThemeMode.dark
                    ? AppColors.primaryColorLight
                    : AppColors.primaryColorDark,
                unselectedLabelColor: themeProvider.appTheme == ThemeMode.dark
                    ? Colors.grey[400]
                    : Colors.grey[600],
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                ),
                dividerColor: Colors.transparent,
                tabs: _viewModel.sourceList
                    .map((source) => Tab(text: source!.name))
                    .toList(),
                onTap: _viewModel.setSelectedSource,
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) => GestureDetector(
                onTap: () => showArticleDetails(
                  context,
                  _viewModel.articleList[index]!,
                ),
                child: NewsCardWidget(index: index),
              ),
              separatorBuilder: (context, index) => const SizedBox(height: 2),
              itemCount: _viewModel.articleList.length,
            ),
          ),
        ],
      ),
    );
  }

  void showArticleDetails(context, Article article) {
    var themeProvider = Provider.of<AppThemeProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.75,
            decoration: BoxDecoration(
              color: themeProvider.appTheme == ThemeMode.light
                  ? Colors.white
                  : Colors.grey[900],
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: themeProvider.appTheme == ThemeMode.light
                    ? Colors.grey[300]!
                    : Colors.grey[700]!,
                width: 1,
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: themeProvider.appTheme == ThemeMode.light
                              ? Colors.grey[200]
                              : Colors.grey[800],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: themeProvider.appTheme == ThemeMode.light
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                // Image
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    child: CachedNetworkImage(
                      imageUrl: article.urlToImage,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: themeProvider.appTheme == ThemeMode.light
                              ? AppColors.primaryColorDark
                              : AppColors.primaryColorLight,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.error,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // Title
                Text(
                  article.title,
                  style: AppStyles.W500Black20.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeProvider.appTheme == ThemeMode.light
                        ? Colors.black
                        : Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // Description
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      article.description ?? "No description available",
                      style: AppStyles.W500Black20.copyWith(
                        fontSize: 16,
                        color: themeProvider.appTheme == ThemeMode.light
                            ? Colors.grey[800]
                            : Colors.grey[300],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Button
                CustomElevatedButton.text(
                  text: "View Full Article",
                  buttonColor: themeProvider.appTheme == ThemeMode.light
                      ? AppColors.primaryColorDark
                      : AppColors.primaryColorLight,
                  textColor: themeProvider.appTheme == ThemeMode.light
                      ? Colors.white
                      : Colors.black,
                  onPressed: () {
                    _viewModel.launchUrlCustom(article.url);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}