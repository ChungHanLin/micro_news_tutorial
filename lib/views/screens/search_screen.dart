import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_keyword.dart';
import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:micro_news_tutorial/repositories/news_keyword.dart';
import 'package:micro_news_tutorial/repositories/news_post.dart';
import 'package:micro_news_tutorial/views/widgets/news_keyword_button.dart';
import 'package:micro_news_tutorial/views/widgets/news_post_card.dart';

import 'result_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late Future<List<NewsKeyword>> _keywords;
  late Future<List<NewsPost>> _posts;

  Widget _buildKeywords(List<NewsKeyword> keywords) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
      itemCount: keywords.length,
      itemBuilder: (context, index) {
        return Row(children: [
          NewsKeywordButton(keyword: keywords[index].keyword),
          const SizedBox(width: 16),
        ]);
      },
    );
  }

  Widget _buildPosts(List<NewsPost> posts) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (conext, index) {
          return NewsPostCard(post: posts[index]);
        });
  }

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _keywords = NewsKeywordRepository().getKeywords();
    _posts = NewsPostRepository().getHotPosts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
              largeTitle: Text(
                '搜尋',
              ),
              backgroundColor: CupertinoDynamicColor.withBrightness(
                  color: CupertinoColors.white,
                  darkColor: CupertinoColors.black)),
          SliverToBoxAdapter(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: CupertinoSearchTextField(
                    controller: _searchController,
                    placeholder: '搜尋關鍵字',
                    onSubmitted: (value) {
                      if (value == '') return;
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (context) => ResultScreen(query: value),
                        ),
                      );
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('熱門關鍵字',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                SizedBox(
                  height: 64,
                  child: FutureBuilder(
                      future: _keywords,
                      builder: (conext, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return Center(child: Text('發生${snapshot.error}'));
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            return _buildKeywords(
                                snapshot.data as List<NewsKeyword>);
                          } else {
                            return const Center(child: Text('沒有資料'));
                          }
                        } else {
                          return const Center(
                              child: CupertinoActivityIndicator());
                        }
                      }),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                  child: Text('熱門新聞',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                ),
                FutureBuilder(
                    future: _posts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return Center(child: Text('發生${snapshot.error}'));
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          return _buildPosts(snapshot.data as List<NewsPost>);
                        } else {
                          return const Center(child: Text('沒有資料'));
                        }
                      } else {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                    })
              ])),
        ],
      ),
    );
  }
}
