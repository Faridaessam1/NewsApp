import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/constants/theme/app_colors.dart';
import 'package:news_app/constants/theme/app_styles.dart';
import 'package:provider/provider.dart';
import '../../../constants/widgets/custom_elevated_button.dart';
import '../../../models/articles_model.dart';
import '../../../provider/app_theme_provider.dart';
import '../../../provider/viewModel/home_view_model.dart';

class NewsCardWidget extends StatelessWidget {
  int index;

  NewsCardWidget({required this.index});

  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<HomeViewModel>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);

    final article = viewModel.articleList[index];
    if (viewModel.articleList.length <= index) {
      return Container(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Text(
            "No Data",
            style: TextStyle(
              color: themeProvider.appTheme == ThemeMode.light
                  ? Colors.black
                  : Colors.white,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(15),
      child: Container(
        decoration: BoxDecoration(
          color: themeProvider.appTheme == ThemeMode.light
              ? Colors.white
              : Colors.grey[900],
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: themeProvider.appTheme == ThemeMode.light
                ? Colors.black
                : Colors.grey[700]!,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: themeProvider.appTheme == ThemeMode.light
                  ? Colors.grey.withOpacity(0.3)
                  : Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 320,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: CachedNetworkImage(
                  imageUrl: viewModel.articleList[index]!.urlToImage,
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
                  errorWidget: (context, url, error) => Icon(
                    Icons.error,
                    color: themeProvider.appTheme == ThemeMode.light
                        ? Colors.grey
                        : Colors.grey[400],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              viewModel.articleList[index]!.title,
              style: themeProvider.appTheme == ThemeMode.light
                  ? AppStyles.W700Black16
                  : AppStyles.W700Black16.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(
                    "by: ${viewModel.articleList[index]!.author}",
                    style: AppStyles.W500Black20.copyWith(
                      color: const Color(0xffA0A0A0),
                      fontSize: 12,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  viewModel.timeAgo(viewModel.articleList[index]!.publishedAt),
                  style: AppStyles.W500Black20.copyWith(
                    color: const Color(0xffA0A0A0),
                    fontSize: 12,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}