import 'package:json_annotation/json_annotation.dart';

import 'Article.dart';

@JsonSerializable(includeIfNull: false)
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
      limit: (json['pagination']['limit']),
      offset: (json['pagination']['offset']),
      count: (json['pagination']['count']),
      total: (json['pagination']['total']),
      articles: List<Article>.from(
          json['data'].map((s) => Article.fromJson(s)).toList()),
    );
  }

// Map<String, dynamic> toJson() => _$FeedToJson(this);
}

// Feed _$FeedFromJson(Map<String, dynamic> json) {
//
// }

// Map<String, dynamic> _$FeedToJson(Feed instance) => <String, dynamic>{
//       'limit': instance.limit,
//       'offset': instance.offset,
//       'count': instance.count,
//       'total': instance.total,
//       'articles': instance.articles,
//     };
