import 'package:micro_news_tutorial/models/news_source.dart';

class NewsPost {
  final String id;
  final String title;
  final String body;
  final String cover;
  final String category;
  final NewsSource source;

  NewsPost(
      {required this.id,
      required this.title,
      required this.body,
      required this.cover,
      required this.category,
      required this.source});

  factory NewsPost.fromJson(Map<String, dynamic> json) {
    return NewsPost(
        id: json['id'],
        title: json['title'],
        body: json['body'],
        cover: json['cover'],
        category: json['category'],
        source: NewsSource.fromJson(json['source']));
  }
}
