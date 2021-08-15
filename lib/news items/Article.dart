import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(includeIfNull: false)
class Article {
  String author;
  String title;
  String description;
  String url;
  String image;
  String category;
  String language;
  String country;
  String publishedAt;

  Article({
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.image,
    required this.category,
    required this.language,
    required this.country,
    required this.publishedAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);
}

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    author: (json['author'] == null) ? "" : json['author'],
    title: (json['title'] == null) ? "" : json['title'],
    description: (json['description'] == null) ? "" : json['description'],
    url: (json['url'] == null) ? "" : json['url'],
    image: (json['image'] == null) ? "" : json['image'],
    category: (json['category'] == null) ? "" : json['category'],
    language: (json['language'] == null) ? "" : json['language'],
    country: (json['country'] == null) ? "" : json['country'],
    publishedAt: (json['published_at'] == null) ? "" : json['published_at'],
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'image': instance.image,
      'category': instance.category,
      'language': instance.language,
      'country': instance.country,
      'published_at': instance.publishedAt,
    };
