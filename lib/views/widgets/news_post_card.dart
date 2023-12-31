import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:micro_news_tutorial/styles.dart';
import 'package:micro_news_tutorial/views/screens/post_screen.dart';

class NewsPostCard extends StatelessWidget {
  final NewsPost post;
  const NewsPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        showCupertinoModalPopup(
            context: context,
            barrierColor: const Color.fromRGBO(0, 0, 0, 0.7),
            builder: (BuildContext builder) {
              return CupertinoPopupSurface(child: PostScreen(post: post));
            });
      },
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
            color: ThemeColor.backGround.resolveFrom(context),
            border: Border.all(
                color: const CupertinoDynamicColor.withBrightness(
                    color: CupertinoColors.systemGrey6,
                    darkColor: CupertinoColors.systemGrey)),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: CupertinoDynamicColor.withBrightness(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      darkColor: Color.fromRGBO(0, 0, 0, 1)),
                  offset: Offset(0, 3),
                  blurRadius: 6),
              BoxShadow(
                  color: CupertinoDynamicColor.withBrightness(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      darkColor: Color.fromRGBO(0, 0, 0, 1)),
                  offset: Offset(0, 2),
                  blurRadius: 4)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 18,
                                height: 18,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  image: DecorationImage(
                                    image: NetworkImage(post.source.icon),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                post.source.name,
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: CupertinoColors.systemGrey),
                              )
                            ],
                          ),
                          const SizedBox(height: 6),
                          Text(post.title,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 16,
                                  color: ThemeColor.text.resolveFrom(context),
                                  fontWeight: FontWeight.w500,
                                  height: 1.2,
                                  letterSpacing: 1.01)),
                        ],
                      ),
                      Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                              color: CupertinoColors.systemBlue,
                              borderRadius: BorderRadius.circular(14)),
                          child: Text(post.category,
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: CupertinoColors.white))),
                    ]),
              ),
            ),
            const SizedBox(width: 16),
            Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(post.cover),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: CupertinoColors.systemGrey6, width: 0.2)),
                width: 100,
                height: 100),
          ],
        ),
      ),
    );
  }
}
