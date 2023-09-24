class NewsCategory {
  final int id;
  final String name;
  final String cover;

  NewsCategory({required this.id, required this.name, required this.cover});

  factory NewsCategory.fromJson(Map<String, dynamic> json) {
    return NewsCategory(
        id: json['id'], name: json['name'], cover: json['cover']);
  }
}
