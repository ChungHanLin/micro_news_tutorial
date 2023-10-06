import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsPostRepository {
  Future<List<NewsPost>> getHotPosts() async {
    try {
      final response = await http
          .get(Uri.parse('http://localhost:3000/posts?_page=1&_limit=5'));
      if (response.statusCode == 200) {
        final List<dynamic> posts = jsonDecode(response.body);
        return posts.map((post) => NewsPost.fromJson(post)).toList();
      }
      throw Exception('取得失敗');
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }

  Future<List<NewsPost>> getPosts(
      {String query = '',
      String source = '',
      String category = '',
      int page = 1,
      int limit = 20}) async {
    try {
      String url =
          'http://localhost:3000/posts?q=$query&_page=$page&_limit=$limit';
      if (source.isNotEmpty) {
        url += '&source.name=$source';
      }
      if (category.isNotEmpty) {
        url += '&category=$category';
      }
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> posts = jsonDecode(response.body);
        return posts.map((post) => NewsPost.fromJson(post)).toList();
      }
      throw Exception('取得失敗');
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
