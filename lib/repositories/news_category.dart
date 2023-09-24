import 'package:micro_news_tutorial/models/news_category.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class NewsCategoryRepository {
  Future<List<NewsCategory>> getCategories() async {
    // 透過 get 方法取得網址資訊，但由於僅能串接 Uri 物件 因此需透過 Uri 來 parse 網址
    final response = await http
        .get(Uri.parse('https://news-server-api.vercel.app/categories'));
    // html status code 200 表示取得成功
    if (response.statusCode == 200) {
      final List<dynamic> categories = jsonDecode(response.body);
      return categories
          .map((category) => NewsCategory.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }
}
