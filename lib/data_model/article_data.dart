import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/data_model/article_model.dart';

class ArticleData {
  String? url;
  ArticleData({this.url});
  geturl(url) {
    this.url = url;
  }

  List<ArticleModel> getDetails() {
    return _newsdata;
  }

  List<ArticleModel> _newsdata = [];
  Future<void> getData() async {
    var response = await http.get(Uri.parse(url!));
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element["title"],
              description: element["description"],
              content: element["content"],
              articleurl: element["url"],
              imageurl: element["urlToImage"],
              publishedAt: element["publishedAt"]);
          _newsdata.add(articleModel);
        }
      });
    }
  }
}
