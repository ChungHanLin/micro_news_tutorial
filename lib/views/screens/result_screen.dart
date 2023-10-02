import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:micro_news_tutorial/repositories/news_post.dart';
import 'package:micro_news_tutorial/views/widgets/news_post_card.dart';

class ResultScreen extends StatefulWidget {
  final String query;
  const ResultScreen({super.key, required this.query});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Future<List<NewsPost>> _posts;

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
    _posts = NewsPostRepository().getPosts(query: widget.query);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(widget.query,
              style: CupertinoTheme.of(context)
                  .textTheme
                  .navLargeTitleTextStyle
                  .copyWith(fontSize: 20)),
          previousPageTitle: '搜尋',
        ),
        child: FutureBuilder(
            future: _posts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text('發生${snapshot.error}'));
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return _buildPosts(snapshot.data as List<NewsPost>);
                } else {
                  return const Center(child: Text('沒有資料'));
                }
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            }));
  }
}
