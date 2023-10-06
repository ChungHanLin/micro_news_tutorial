import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:micro_news_tutorial/repositories/news_post.dart';
import 'package:micro_news_tutorial/views/widgets/news_post_card.dart';

class ResultScreen extends StatefulWidget {
  final String? query;
  final String? source;
  final String? category;
  const ResultScreen({super.key, this.query, this.source, this.category});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late Future<List<NewsPost>> _posts;

  Widget getNavigationBarTitle() {
    var style = CupertinoTheme.of(context)
        .textTheme
        .navLargeTitleTextStyle
        .copyWith(fontSize: 20);
    if (widget.query != null) {
      return Text(widget.query!, style: style);
    } else if (widget.category != null) {
      return Text(widget.category!, style: style);
    } else {
      return Row(
        children: [
          Text(widget.source!, style: style),
        ],
      );
    }
  }

  Widget _buildPosts(List<NewsPost> posts) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (conext, index) {
          return NewsPostCard(post: posts[index]);
        });
  }

  @override
  void initState() {
    super.initState();
    if (widget.source != null) {
      _posts = NewsPostRepository().getPosts(source: widget.source!);
    } else if (widget.category != null) {
      _posts = NewsPostRepository().getPosts(category: widget.category!);
    } else {
      _posts = NewsPostRepository().getPosts(query: widget.query!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: getNavigationBarTitle(),
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
