class NewsSource {
  String id;
  String name;
  String icon;

  NewsSource({required this.id, required this.name, required this.icon});

  factory NewsSource.fromJson(Map<String, dynamic> json) {
    return NewsSource(id: json['id'], name: json['name'], icon: json['icon']);
  }
}
