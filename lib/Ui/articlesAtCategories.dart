import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Ui/articleList.dart';
import 'package:news_app/data_model/article_data.dart';

class ArticlesCategories extends StatefulWidget {
  final String? categoryName;
  final ArticleData? articleData;
  final User? fuser;
  ArticlesCategories(
      {@required this.categoryName,
      @required this.articleData,
      @required this.fuser});
  @override
  _ArticlesCategoriesState createState() => _ArticlesCategoriesState();
}

class _ArticlesCategoriesState extends State<ArticlesCategories> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          widget.categoryName!,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.w900, color: Colors.black54),
        ),
      ),
      body: ArticleList(
        articleData: widget.articleData!,
        users: widget.fuser!,
      ),
    ));
  }
}
