import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/widgets/news_card_widget.dart';
import 'package:news_app/models/categoryModel.dart';
import 'package:provider/provider.dart';
import '../../../constants/theme/app_styles.dart';
import '../../../constants/widgets/custom_elevated_button.dart';
import '../../../models/articles_model.dart';
import '../../../provider/app_theme_provider.dart';
import '../../../provider/viewModel/home_view_model.dart';

class SelectedCategoryView extends StatefulWidget {
  final CategoryDataModel selectedCategoryModel;

  const SelectedCategoryView({
    super.key,
    required this.selectedCategoryModel
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
    ]).then((value){
      _viewModel.getAllArticles();

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return Column(
      children: [
        DefaultTabController(
          length: _viewModel.sourceList.length,
          child: Container(
            color: Colors.transparent,
            child: TabBar(
              tabAlignment: TabAlignment.start,
              isScrollable: true,
              indicatorColor: themeProvider.appTheme == ThemeMode.dark ? Colors
                  .white : Colors.black,
              labelColor: themeProvider.appTheme == ThemeMode.dark ? Colors
                  .white : Colors.black,
              unselectedLabelColor: themeProvider.appTheme == ThemeMode.dark
                  ? Colors.white
                  : Colors.black,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              dividerColor: Colors.transparent,
              tabs: _viewModel.sourceList.map((source) =>
                  Tab(text: source!.name)).toList(),
              onTap: _viewModel.setSelectedSource, // btrg3le l index 3shan ageb el news
            ),
          ),
        ),

        Expanded(
            child: ListView.separated(
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => showArticleDetails(context , _viewModel.articleList[index]!),
                child: NewsCardWidget(index: index,)
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 2,),
            itemCount:_viewModel.articleList.length,
            ),
        ),
      ],
    );
  }


  void showArticleDetails(context, Article article) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20 , left: 15 , right: 15),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(30)
            ),
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: double.infinity,
                    height: 320,
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
                      placeholder: (context, url) =>
                          Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  article.description,
                  style: AppStyles.W500Black20.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton.text(
                          text: "View Full Article",
                          buttonColor: Colors.white,
                          textColor: Colors.black,
                        onPressed: (){
                            _viewModel.launchUrlCustom(article.url);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

}


