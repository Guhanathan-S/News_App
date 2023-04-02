class ArticleModel {
  String? title, description, content, articleurl, imageurl, publishedAt;
  int likeCount = 0, dislikeCount = 0;
  bool userPressedlike = false,
      userPresseddislike = false,
      userPressedcomment = false,
      userPressedbookmark = false;
  ArticleModel({
    this.title,
    this.description,
    this.content,
    this.imageurl,
    this.articleurl,
    this.publishedAt,
  });
}
