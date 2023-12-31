import 'package:micro_news_tutorial/models/news_source.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsSourceRepository {
  Future<List<NewsSource>> getSources() async {
    try {
      final response =
          await http.get(Uri.parse('http://localhost:3000/sources'));
      if (response.statusCode == 200) {
        // 回傳為 List
        final List<dynamic> sources = jsonDecode(response.body);
        // 將 List 轉換為 NewsSource
        return sources
            .map((dynamic source) => NewsSource.fromJson(source))
            .toList();
      }
      throw Exception('取得失敗');
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }
}
