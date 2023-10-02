import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_category.dart';
import 'package:micro_news_tutorial/models/news_source.dart';
import 'package:micro_news_tutorial/repositories/news_category.dart';
import 'package:micro_news_tutorial/repositories/news_source.dart';
import 'package:micro_news_tutorial/views/screens/news_source_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  late Future<List<NewsCategory>> _categories;
  late Future<List<NewsSource>> _sources;

  Widget _buildCategories(List<NewsCategory> categories) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 16 / 9),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Stack(alignment: Alignment.bottomLeft, children: [
            Container(
              decoration: BoxDecoration(
                color: CupertinoColors.black,
                image: DecorationImage(
                  opacity: 0.7,
                  image: NetworkImage(categories[index].cover),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
              child: Text(categories[index].name,
                  style: const TextStyle(
                      fontSize: 20,
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.w700)),
            )
          ]);
        });
  }

  Widget _buildSources(List<NewsSource> sources) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
        itemCount: sources.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: CupertinoColors.black,
                    image: DecorationImage(
                      image: NetworkImage(sources[index].icon),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                        color: CupertinoColors.systemGrey4, width: 0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(sources[index].name,
                      style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.black,
                          fontWeight: FontWeight.w500)),
                )
              ],
            ),
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _categories = NewsCategoryRepository().getCategories();
    _sources = NewsSourceRepository().getSources();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Text('新聞分類',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
          child: Text('檢視所有新聞分類',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey)),
        ),
        FutureBuilder(
          future: _categories,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('發生${snapshot.error}'));
              } else if (snapshot.hasData) {
                return _buildCategories(snapshot.data as List<NewsCategory>);
              } else {
                return const Center(child: Text('沒有資料'));
              }
            } else {
              return const Center(child: CupertinoActivityIndicator());
            }
          },
        ),
        CupertinoButton(
          padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
          onPressed: () {
            Navigator.push(context, CupertinoPageRoute(builder: (context) {
              return const NewsSourceScreen();
            }));
          },
          child: const Row(
            children: [
              Text('新聞來源',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: CupertinoColors.black)),
              SizedBox(width: 4),
              Icon(CupertinoIcons.forward,
                  size: 22, color: CupertinoColors.systemGrey),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
          child: Text('檢視所有新聞來源',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey)),
        ),
        SizedBox(
            height: 200,
            child: FutureBuilder(
              future: _sources,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return Center(child: Text('發生${snapshot.error}'));
                  } else if (snapshot.hasData) {
                    return _buildSources(snapshot.data as List<NewsSource>);
                  } else {
                    return const Center(child: Text('沒有資料'));
                  }
                } else {
                  return const Center(child: CupertinoActivityIndicator());
                }
              },
            )),
      ]),
    );
  }
}
