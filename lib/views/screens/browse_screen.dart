import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_category.dart';
import 'package:micro_news_tutorial/models/news_source.dart';
import 'package:micro_news_tutorial/repositories/news_category.dart';
import 'package:micro_news_tutorial/repositories/news_source.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  List<NewsCategory> categories = [];
  List<NewsSource> sources = [];

  @override
  void initState() {
    super.initState();
    NewsCategoryRepository().getCategories().then(
      (value) {
        setState(() {
          categories = value;
        });
      },
    );
    NewsSourceRepository().getSources().then(
      (value) {
        setState(() {
          sources = value;
        });
      },
    );
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
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 16 / 9,
          ),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: categories.length,
          itemBuilder: (BuildContext context, int index) {
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
          },
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 32, 16, 0),
          child: Text('新聞來源',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
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
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
                itemCount: sources.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Column(
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
                                  fontWeight: FontWeight.w700)),
                        )
                      ],
                    ),
                  );
                })),
      ]),
    );
  }
}
