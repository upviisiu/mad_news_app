class Article {
  final String author;
  final String title;
  final String description;
  final String url;
  final String image;
  final String category;
  final String language;
  final String country;
  final String publishedAt;

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

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      author: json['author'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      image: json['image'],
      category: json['category'],
      language: json['language'],
      country: json['country'],
      publishedAt: json['published_at'],
    );
  }
}
