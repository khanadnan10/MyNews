import 'dart:convert';

List<News> newsFromJson(String str) => json.decode(str) == null
    ? []
    : List<News>.from(json.decode(str)!.map((x) => News.fromJson(x)));

String newsToJson(List<News?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class News {
  News({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  Source source;
  String? author;
  String title;
  String? description;
  String url;
  String? urlToImage;
  DateTime publishedAt;
  String content;

  factory News.fromJson(Map<String, dynamic> json) => News(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"] as String,
        description: json["description"],
        url: json["url"] as String,
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"] as String),
        content: json["content"] as String,
      );

  Map<String, dynamic> toJson() => {
        "source": source.toJson(),
        "author": author,
        "title": title,
        "description": description,
        "url": url,
        "urlToImage": urlToImage,
        "publishedAt": publishedAt.toIso8601String(),
        "content": content,
      };
}

class Source {
  Source({
    this.id,
    this.name,
  });

  String? id;
  String? name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
