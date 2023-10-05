import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_post.dart';
import 'package:micro_news_tutorial/views/screens/post_screen.dart';

class NewsPostFullCard extends StatelessWidget {
  final NewsPost post;
  const NewsPostFullCard({super.key, required this.post});

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
                color: CupertinoColors.white,
                border: Border.all(color: CupertinoColors.systemGrey5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      offset: Offset(0, 3),
                      blurRadius: 6),
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.06),
                      offset: Offset(0, 2),
                      blurRadius: 4)
                ]),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    image: DecorationImage(
                      image: NetworkImage(post.cover),
                      fit: BoxFit.cover,
                    )),
              ),
              const SizedBox(height: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
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
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(0, 0, 0, 0.8)),
                      )
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
                              color: CupertinoColors.white)))
                ],
              ),
              const SizedBox(height: 8),
              Text(post.title,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: CupertinoColors.black,
                      letterSpacing: 1.01)),
              const SizedBox(height: 8),
              Text(post.body,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      height: 1.2,
                      fontSize: 14,
                      color: Color.fromRGBO(0, 0, 0, 0.8))),
            ])));
  }
}
