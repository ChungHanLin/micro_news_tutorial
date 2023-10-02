import 'dart:convert';
import 'package:micro_news_tutorial/models/news_keyword.dart';
import 'package:http/http.dart' as http;

class NewsKeywordRepository {
  Future<List<NewsKeyword>> getKeywords() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/hot_keywords'));
      if (response.statusCode == 200) {
        final List<dynamic> keywords = jsonDecode(response.body);
        return keywords
            .map((keyword) => NewsKeyword.fromList(keyword))
            .toList();
      }
      throw Exception('取得失敗');
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
