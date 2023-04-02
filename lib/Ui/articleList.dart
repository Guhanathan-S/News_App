import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/data_model/article_data.dart';
import 'package:news_app/data_model/article_model.dart';
import 'package:news_app/Ui/articleWebView.dart';
import 'package:news_app/screens/bookmark.dart';
import 'package:news_app/screens/comments.dart';

class ArticleList extends StatefulWidget {
  final ArticleData? articleData;
  final User? users;
  ArticleList({@required this.articleData, this.users});
  @override
  _ArticleListState createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  List<ArticleModel> articles = [];
  getArticlesData() async {
    await widget.articleData!.getData();
    articles = widget.articleData!.getDetails();
    return articles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getArticlesData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 7,
            ));
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                color: Colors.black,
              ),
              scrollDirection: Axis.vertical,
              physics: const ClampingScrollPhysics(),
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ArticleWebView(
                                articleUrl: snapshot.data[index].articleurl)));
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 5),
                    height: 350,
                    child: Column(children: <Widget>[
                      Expanded(
                        flex: 3,
                        child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        snapshot.data[index].imageurl),
                                    fit: BoxFit.fill))),
                      ),
                      Expanded(
                          flex: 1,
                          child: Text(snapshot.data[index].title,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold))),
                      Container(
                        height: 30,
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          snapshot.data[index].description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      Container(
                        height: 30,
                        child: Opinion(
                          imgUrl: snapshot.data[index].imageurl,
                          titleUrl: snapshot.data[index].title,
                          snapshot: snapshot.data[index],
                          fuser: widget.users!,
                        ),
                      )
                    ]),
                  ),
                );
              },
            );
          }
        });
  }
}

class Opinion extends StatefulWidget {
  final String? imgUrl, titleUrl;
  final User? fuser;
  final snapshot;
  Opinion({this.imgUrl, this.titleUrl, this.snapshot, this.fuser});
  @override
  _OpinionState createState() => _OpinionState();
}

class _OpinionState extends State<Opinion> {
  Kcontainers? kcontainers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Kcontainers(
            icon: Icons.thumb_up,
            details: widget.snapshot.likeCount.toString(),
            iconColorPressed: Colors.blue,
            iconColorUnPressed: Colors.black38,
            pressed: widget.snapshot.userPressedlike,
            onPressed: () => setState(() {
                  if (widget.snapshot.userPressedlike == true) {
                    widget.snapshot.userPressedlike = false;
                    widget.snapshot.likeCount -= 1;
                  } else {
                    widget.snapshot.userPressedlike = true;
                    widget.snapshot.likeCount += 1;
                    if (widget.snapshot.userPresseddislike == true) {
                      widget.snapshot.userPresseddislike = false;
                      widget.snapshot.dislikeCount =
                          widget.snapshot.dislikeCount > 0
                              ? widget.snapshot.dislikeCount -= 1
                              : 0;
                    }
                  }
                })),
        Kcontainers(
            icon: Icons.thumb_down,
            details: widget.snapshot.dislikeCount.toString(),
            iconColorPressed: Colors.blue,
            iconColorUnPressed: Colors.black38,
            pressed: widget.snapshot.userPresseddislike,
            onPressed: () => setState(() {
                  if (widget.snapshot.userPresseddislike == true) {
                    widget.snapshot.userPresseddislike = false;
                    widget.snapshot.dislikeCount -= 1;
                  } else {
                    widget.snapshot.userPresseddislike = true;
                    widget.snapshot.dislikeCount += 1;
                    if (widget.snapshot.userPressedlike == true) {
                      widget.snapshot.userPressedlike = false;
                      widget.snapshot.likeCount = widget.snapshot.likeCount > 0
                          ? widget.snapshot.likeCount -= 1
                          : 0;
                    }
                  }
                })),
        Kcontainers(
            icon: Icons.comment,
            details: "Comments",
            iconColorPressed: Colors.black,
            iconColorUnPressed: Colors.black54,
            pressed: widget.snapshot.userPressedcomment,
            onPressed: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Comments(
                                urlImg: widget.imgUrl!,
                                urlTitle: widget.titleUrl!,
                                user: widget.fuser!,
                              )))
                }),
        Kcontainers(
            icon: Icons.bookmark,
            details: "BookMark",
            iconColorPressed: Colors.black,
            iconColorUnPressed: Colors.black54,
            pressed: widget.snapshot.userPressedbookmark,
            onPressed: () => setState(() {
                  if (widget.snapshot.userPressedbookmark == false) {
                    widget.snapshot.userPressedbookmark = true;
                    if (!bookMarkedArticles.contains(widget.snapshot)) {
                      bookMarkedArticles.add(widget.snapshot);
                    }
                  } else {
                    widget.snapshot.userPressedbookmark = false;
                    bookMarkedArticles.remove(widget.snapshot);
                  }
                })),
      ],
    );
  }
}

class Kcontainers extends StatefulWidget {
  final icon, details, onPressed, iconColorPressed, iconColorUnPressed, pressed;
  Kcontainers(
      {this.pressed,
      this.icon,
      this.details,
      this.onPressed,
      this.iconColorPressed,
      this.iconColorUnPressed});

  @override
  _KcontainersState createState() => _KcontainersState();
}

class _KcontainersState extends State<Kcontainers> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onPressed,
        child: Row(children: [
          Icon(
            widget.icon,
            color: widget.pressed
                ? widget.iconColorPressed
                : widget.iconColorUnPressed,
          ),
          Text(widget.details),
        ]));
  }
}
