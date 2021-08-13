import 'Article.dart';

class Feed {
  final int limit;
  final int offset;
  final int count;
  final int total;
  final List<Article> articles;

  Feed({
    required this.limit,
    required this.offset,
    required this.count,
    required this.total,
    required this.articles,
  });

  factory Feed.fromJson(Map<String, dynamic> json) {
    return Feed(
      limit: json['limit'],
      offset: json['offset'],
      count: json['count'],
      total: json['total'],
      articles: json['data'].Map((s) => Article.fromJson(s)).toList(),
    );
  }
}
