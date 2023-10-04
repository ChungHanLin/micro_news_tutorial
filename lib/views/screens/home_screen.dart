import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:micro_news_tutorial/repositories/news_post.dart';
import 'package:micro_news_tutorial/views/widgets/news_post_full_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 1;
  int limit = 10;
  bool isBottom = false;
  late List<NewsPost> _posts = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isBottom) {
        fetchMore();
      }
    });
    NewsPostRepository().getPosts(page: page, limit: limit).then((value) {
      setState(() {
        value.length < limit ? isBottom = true : isBottom = false;
        _posts = value;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchMore() async {
    late List<NewsPost> morePosts;
    try {
      morePosts =
          await NewsPostRepository().getPosts(page: page + 1, limit: limit);
    } catch (e) {
      morePosts = [];
    }
    setState(() {
      page++;
      _posts.addAll(morePosts);
      morePosts.length < limit ? isBottom = true : isBottom = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(controller: _scrollController, slivers: [
        const CupertinoSliverNavigationBar(
            largeTitle: Text(
              '焦點新聞',
            ),
            backgroundColor: CupertinoColors.white),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
          sliver: SliverToBoxAdapter(
            child: Text(
              '推薦新聞',
              style: TextStyle(
                  fontSize: 22,
                  color: CupertinoTheme.of(context).primaryColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
        _posts.isNotEmpty
            ? SliverList.builder(
                itemCount: _posts.length + 1,
                itemBuilder: (conext, index) {
                  if (index < _posts.length) {
                    return NewsPostFullCard(post: _posts[index]);
                  } else if (isBottom) {
                    return const SizedBox(
                        height: 36,
                        child: Center(
                            child: Text(
                          '已經到底拉',
                          style: TextStyle(color: CupertinoColors.systemGrey),
                        )));
                  } else {
                    return const SizedBox(
                        height: 36,
                        child: Center(child: CupertinoActivityIndicator()));
                  }
                })
            : const SliverToBoxAdapter(
                child: Center(child: CupertinoActivityIndicator()))
      ]),
    );
  }
}
