import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Ui/articleWebView.dart';
import 'package:news_app/Ui/articleList.dart';
import 'package:news_app/data_model/article_model.dart';
import 'package:news_app/data_model/searchdata.dart';

class Search extends StatefulWidget {
  final User? user;
  Search({this.user});
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  List<ArticleModel> searchedResult = [], searchedArticles = [];
  SearchData searchData = SearchData();
  final TextEditingController searchController = TextEditingController();
  bool container1 = false, container2 = false;
  search(String text) async {
    FocusScope.of(context).unfocus();
    container1 = false;
    if (searchedArticles.isNotEmpty) {
      searchedArticles.removeRange(0, searchedArticles.length);
    }
    searchedResult = await searchData.getArticles();
    for (var i in searchedResult) {
      final title = i.title!.toLowerCase();
      final txt = text.toLowerCase();
      if (title.contains(txt)) {
        searchedArticles.add(i);
      }
    }
    setState(() {
      searchedArticles = searchedArticles.toSet().toList();
      if (searchedArticles.isEmpty) {
        setState(() {
          container1 = true;
        });
      }
    });
    print(searchedArticles.length);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          TextField(
            controller: searchController,
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black38)),
                labelText: "search",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  splashColor: Colors.blue,
                  onPressed: () => search(searchController.text),
                  color: Colors.blueAccent,
                )),
          ),
          Expanded(child: Builder(builder: (BuildContext context) {
            if (container1) {
              return Center(
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(
                    "No Results Match",
                    style: TextStyle(fontSize: 30, color: Colors.blueGrey),
                  ),
                ),
              );
            } else {
              return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(color: Colors.black),
                  itemCount: searchedArticles.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleWebView(
                                    articleUrl:
                                        searchedArticles[index].articleurl)));
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        height: 350,
                        child: Column(children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            searchedArticles[index].imageurl!),
                                        fit: BoxFit.fill))),
                          ),
                          Expanded(
                              flex: 1,
                              child: Text(searchedArticles[index].title!,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                          Container(
                            height: 30,
                            child: Text(
                              searchedArticles[index].description!,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Divider(
                            color: Colors.black,
                          ),
                          Container(
                            height: 40,
                            child: Opinion(
                              imgUrl: searchedArticles[index].imageurl,
                              titleUrl: searchedArticles[index].title,
                              snapshot: searchedArticles[index],
                              fuser: widget.user,
                            ),
                          )
                        ]),
                      ),
                    );
                  });
            }
          })),
        ],
      ),
    );
  }
}
