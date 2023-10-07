import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:micro_news_tutorial/styles.dart';

class PostScreen extends StatelessWidget {
  final NewsPost post;

  const PostScreen({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.8,
        color: ThemeColor.backGround.resolveFrom(context),
        child: Column(children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: CupertinoColors.black,
                  image: DecorationImage(
                    opacity: 0.7,
                    image: NetworkImage(post.cover),
                    fit: BoxFit.cover,
                  )),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
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
                      const SizedBox(height: 8),
                      Text(post.title,
                          style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w700)),
                    ]),
              )),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(26),
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
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: CupertinoColors.systemGrey),
                        )
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(post.body,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.5,
                          fontWeight: FontWeight.w400,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ]));
  }
}
