import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/models/articles_model.dart';
import 'package:news_app/models/source_model.dart';

import '../constants/apiConstants/api_constants.dart';

abstract class ApiNetwork {


  static Future<List<Source?>> getAllSources(String categoryID) async {
    try {
      var queryParameters = {
        "apiKey": Constants.apiKey,
        "category": categoryID,
      };
      var uri = Uri.https(
          Constants.baseURL, "/v2/top-headlines/sources", queryParameters);

      var data = await http.get(uri);
      var response = data.body; //String
      Map<String , dynamic> json = jsonDecode(response); // Json
      SourcesModel? sourceModel =  SourcesModel.fromJson(json); // Object

      return sourceModel.sources;
      // el body el rag3 mn no3 string
      // ana 3yzah String ==> json ==> object
      // hstkhdm method esmha jsonDecode tdeha string trg3 json
    } catch (error) {
      throw Exception(error);
    }
  }


  static Future<List<Article>> getAllArticles(String sourceID) async {
    try {
      var queryParameters = {
        "apiKey": Constants.apiKey,
        "sources": sourceID,
      };
      var uri = Uri.https(
          Constants.baseURL, "/v2/everything", queryParameters);

      var data = await http.get(uri);
      var response = data.body; //String
      Map<String , dynamic> json = jsonDecode(response); // Json
      ArticlesModel? articleModel =  ArticlesModel.fromJson(json); // Object

      return articleModel.articles;
      // var response = data.body; //String
      // var json = jsonDecode(response); // Json
      // SourcesModel.fromJson(json); // Object
      // el body el rag3 mn no3 string
      // ana 3yzah String ==> json ==> object
      // hstkhdm method esmha jsonDecode tdeha string trg3 json
    } catch (error) {
      throw Exception(error);
    }
  }
}
