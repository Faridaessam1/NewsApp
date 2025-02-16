import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news_app/features/home/widgets/news_card_widget.dart';
import 'package:news_app/models/categoryModel.dart';
import 'package:news_app/models/source_model.dart';
import 'package:provider/provider.dart';
import '../../../provider/app_theme_provider.dart';
import '../../../provider/viewModel/home_view_model.dart';

class SelectedCategoryView extends StatefulWidget {
  final CategoryDataModel selectedCategoryModel;

  SelectedCategoryView({
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

        Expanded(child: ListView.separated(
            itemBuilder: (context, index) => NewsCardWidget(index: _viewModel.selectedTabIndex,),
            separatorBuilder: (context, index) => const SizedBox(height: 5,),
            itemCount:_viewModel.articleList.length,
            ),
        ),
      ],
    );
  }
}


