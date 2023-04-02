import 'package:news_app/data_model/article_data.dart';
import 'package:news_app/data_model/article_model.dart';

class SearchData {
  List<ArticleModel>? searchdata;
  final ArticleData _article = ArticleData();
  List<String> urls = [
    "https://newsapi.org/v2/top-headlines?country=in&apiKey=c8ecea489b42438ba4841d807fc69ee5",
    "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=c8ecea489b42438ba4841d807fc69ee5",
    "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=c8ecea489b42438ba4841d807fc69ee5",
    "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=c8ecea489b42438ba4841d807fc69ee5",
    "https://newsapi.org/v2/top-headlines?country=in&category=science&apiKey=c8ecea489b42438ba4841d807fc69ee5",
    "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=c8ecea489b42438ba4841d807fc69ee5",
    "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=c8ecea489b42438ba4841d807fc69ee5"
  ];
  Future<List<ArticleModel>> getArticles() async {
    for (var i in urls) {
      _article.geturl(i);
      await _article.getData();
      searchdata = _article.getDetails();
    }
    print(searchdata!.length);
    return searchdata!;
  }
}
