import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_source.dart';
import 'package:micro_news_tutorial/repositories/news_source.dart';
import 'package:micro_news_tutorial/views/widgets/news_source_row_button.dart';

class NewsSourceScreen extends StatefulWidget {
  const NewsSourceScreen({super.key});

  @override
  State<NewsSourceScreen> createState() => _NewsSourceScreenState();
}

class _NewsSourceScreenState extends State<NewsSourceScreen> {
  late Future<List<NewsSource>> _sources;

  Widget _buildCategories(List<NewsSource> sources) {
    return ListView.builder(
        itemCount: sources.length,
        itemBuilder: (conext, index) {
          return NewsSourceRowButton(source: sources[index]);
        });
  }

  @override
  void initState() {
    super.initState();
    _sources = NewsSourceRepository().getSources();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('新聞來源',
            style: CupertinoTheme.of(context)
                .textTheme
                .navLargeTitleTextStyle
                .copyWith(fontSize: 20)),
        previousPageTitle: '探索',
      ),
      child: FutureBuilder(
          future: _sources,
          builder: (conext, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('發生${snapshot.error}'));
              } else if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: _buildCategories(snapshot.data as List<NewsSource>),
                );
              } else {
                return const Center(child: Text('沒有資料'));
              }
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          }),
    );
  }
}
