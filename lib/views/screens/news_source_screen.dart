import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_source.dart';
import 'package:micro_news_tutorial/repositories/news_source.dart';

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
          return CupertinoListTile(
              onTap: () {},
              title: Text(sources[index].name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.05,
                  )),
              subtitle:
                  Text(sources[index].id, style: const TextStyle(height: 1.4)),
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(sources[index].icon),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                        color: CupertinoColors.systemGrey, width: 0.2)),
              ),
              leadingSize: 60,
              backgroundColorActivated: CupertinoColors.systemGrey5,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              trailing: SizedBox(
                height: 30,
                child: CupertinoButton(
                  onPressed: () {},
                  color: CupertinoColors.systemGrey6,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  borderRadius: BorderRadius.circular(30),
                  child: const Text('前往',
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(255, 30, 84, 1))),
                ),
              ));
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
