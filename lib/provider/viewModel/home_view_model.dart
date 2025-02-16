import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/models/source_model.dart';
import '../../constants/theme/app_assets.dart';
import '../../models/categoryModel.dart';
import '../../network/api_network.dart';

class HomeViewModel extends ChangeNotifier{
  CategoryDataModel? _selectedCategory;
  final List<CategoryDataModel>  _categories =[
      CategoryDataModel(
        CategoryID: "general",
        CategoryName: "General",
        CategoryImg:
            AppAssets.generalLight
      ),
      CategoryDataModel(
        CategoryID: "business",
        CategoryName: "Business",
        CategoryImg:
             AppAssets.businessLight
      ),
      CategoryDataModel(
        CategoryID: "sports",
        CategoryName: "Sports",
        CategoryImg:
             AppAssets.sportsLight
      ),
      CategoryDataModel(
        CategoryID: "technology",
        CategoryName: "Technology",
        CategoryImg:
             AppAssets.technologyLight
      ),
      CategoryDataModel(
        CategoryID: "science",
        CategoryName: "Science",
        CategoryImg:
            AppAssets.scienceLight
      ),
      CategoryDataModel(
        CategoryID: "health",
        CategoryName: "Health",
        CategoryImg:
            AppAssets.healthLight
      ),
      CategoryDataModel(
        CategoryID: "entertainment",
        CategoryName: "Entertainment",
        CategoryImg:
           AppAssets.entertainmentLight
      ),
    ];
  List<Source?> _sourceList = [];
   List<Article?> _articleList = [];
   int _selectedTabIndex = 0;


  CategoryDataModel? get selectedCategory => _selectedCategory;
  List<CategoryDataModel> get categories => _categories;
  List<Source?> get sourceList => _sourceList;
  List<Article?> get articleList => _articleList;
  int get selectedTabIndex => _selectedTabIndex;



  void setSelectedSource(int index){
    _selectedTabIndex = index;
    notifyListeners();
    //callback btakhod el index bta3 kol tab
  }
  void onCategoryClicked(CategoryDataModel selectedCategory) async  {
    _selectedCategory = selectedCategory;
    notifyListeners();
  }

  void goToHome(){
    _selectedCategory = null ;
    notifyListeners();
  }

Future<void> getAllSources() async{
  _sourceList = await ApiNetwork.getAllSources(selectedCategory!.CategoryID);
notifyListeners();
}

Future<void> getAllArticles() async{
    _articleList = await ApiNetwork.getAllArticles(_sourceList[_selectedTabIndex]!.id);
    notifyListeners();
  }

  String timeAgo (String dateString) {
    DateTime publishedDate = DateTime.parse(dateString);
    Duration difference = DateTime.now().difference(publishedDate);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} seconds ago';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays == 1) {
      return '${difference.inDays} day ago';
    }else if (difference.inDays < 30) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 365) {
      return '${difference.inDays ~/ 30} months ago';
    } else {
      return '${difference.inDays ~/ 365} years ago';
    }
  }



}