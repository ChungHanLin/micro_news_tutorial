class NewsKeyword {
  String keyword;

  NewsKeyword({required this.keyword});

  factory NewsKeyword.fromList(String keyword) {
    return NewsKeyword(keyword: keyword);
  }
}
