class ArticlesModel{
  String status;
  List<Article> articles;

  ArticlesModel({required this.status, required this.articles});

  factory ArticlesModel.fromJson(Map<String, dynamic> json) {
    return ArticlesModel(
      status: json['status'],
      articles: (json['articles'] as List)
          .map((article) => Article.fromJson(article))
          .toList(),
    );
  }
}

class Article{
  String id;
  String name;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article({
    required this.id,
    required this.name,
      required this.author,
      required this.title,
      required this.description,
      required this.url,
      required this.urlToImage,
      required this.publishedAt,
      required this.content});


  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['source']['id'],
      name: json["source"]['name'],
      author: json['author' ?? ""],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }
}