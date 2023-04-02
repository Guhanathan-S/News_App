import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:news_app/data_model/article_data.dart';
import 'package:news_app/Ui/articlesAtCategories.dart';
import 'package:news_app/Ui/ui.dart';

class Category extends StatefulWidget {
  final User? user;
  const Category({this.user});
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      scrollDirection: Axis.vertical,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      children: <Widget>[
        Categorytile(business, "Business", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticlesCategories(
                      fuser: widget.user,
                      categoryName: "Business",
                      articleData: ArticleData(
                          url:
                              "https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=c8ecea489b42438ba4841d807fc69ee5"))));
        }),
        Categorytile(entertainment, "Entertainment", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticlesCategories(
                      fuser: widget.user,
                      categoryName: "Entertainment",
                      articleData: ArticleData(
                          url:
                              "https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=c8ecea489b42438ba4841d807fc69ee5"))));
        }),
        Categorytile(health, "Health", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticlesCategories(
                      fuser: widget.user,
                      categoryName: "Health",
                      articleData: ArticleData(
                          url:
                              "https://newsapi.org/v2/top-headlines?country=in&category=health&apiKey=c8ecea489b42438ba4841d807fc69ee5"))));
        }),
        Categorytile(science, "Science", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticlesCategories(
                      fuser: widget.user,
                      categoryName: "Science",
                      articleData: ArticleData(
                          url:
                              "https://newsapi.org/v2/top-headlines?country=in&category=science&apiKey=c8ecea489b42438ba4841d807fc69ee5"))));
        }),
        Categorytile(sports, "Sports", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticlesCategories(
                      fuser: widget.user,
                      categoryName: "Sports",
                      articleData: ArticleData(
                          url:
                              "https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=c8ecea489b42438ba4841d807fc69ee5"))));
        }),
        Categorytile(technology, "Technology", () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticlesCategories(
                      fuser: widget.user,
                      categoryName: "Technology",
                      articleData: ArticleData(
                          url:
                              "https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=c8ecea489b42438ba4841d807fc69ee5"))));
        }),
      ],
    );
  }
}

class Categorytile extends StatefulWidget {
  final image, text, onPress;
  Categorytile(this.image, this.text, this.onPress);

  @override
  _CategorytileState createState() => _CategorytileState();
}

class _CategorytileState extends State<Categorytile> {
  Image? preloadImage;
  @override
  void initState() {
    super.initState();
    preloadImage = Image.asset(widget.image);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    precacheImage(preloadImage!.image, context);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.image), fit: BoxFit.fill)),
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.black26),
            child: Text(widget.text,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white))),
      ),
    );
  }
}
