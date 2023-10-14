import 'package:flutter/cupertino.dart';
import 'package:home_widget/home_widget.dart';
import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:micro_news_tutorial/repositories/news_post.dart';
import 'package:micro_news_tutorial/views/widgets/news_post_full_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String appGroupId = 'group.microNewsTutorial';
const String iOSWidgetName = 'MicroNewsWidget';
const String androidWidgetName = 'MicroNewsWidget';

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

  void updateHomeWidget(List<NewsPost> posts) {
    final List<Map<String, String>> postsData = posts
        .map((post) => {
              'title': post.title,
              'cover': post.cover,
              'source': post.source.name,
            })
        .toList();
    HomeWidget.saveWidgetData('posts', postsData);
    HomeWidget.updateWidget(
      iOSName: iOSWidgetName,
      androidName: androidWidgetName,
    );
  }

  @override
  void initState() {
    super.initState();
    HomeWidget.setAppGroupId(appGroupId);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isBottom) {
        fetchMore();
      }
    });
    NewsPostRepository().getPosts(page: page, limit: limit).then((value) {
      updateHomeWidget(value);
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
        CupertinoSliverNavigationBar(
            largeTitle: Text(
              AppLocalizations.of(context)!.home_title,
            ),
            backgroundColor: const CupertinoDynamicColor.withBrightness(
                color: CupertinoColors.white,
                darkColor: CupertinoColors.black)),
        CupertinoSliverRefreshControl(onRefresh: () async {
          final firstPagePosts =
              await NewsPostRepository().getPosts(page: 1, limit: limit);
          setState(() {
            page = 1;
            _posts = firstPagePosts;
            firstPagePosts.length < limit ? isBottom = true : isBottom = false;
          });
        }),
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
