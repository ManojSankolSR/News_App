class datamodel {
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final String publishedAt;
  final String content;

  datamodel({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory datamodel.fromJson(Map<String, dynamic> json) {
    return datamodel(
      author: json['author'].toString(),
      title: json['title'].toString(),
      description: json['description'].toString(),
      url: json['url'].toString(),
      urlToImage: json['urlToImage'].toString(),
      publishedAt: json['publishedAt'].toString(),
      content: json['content'].toString(),
    );
  }
}
