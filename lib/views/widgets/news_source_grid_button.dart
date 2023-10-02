import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_source.dart';

class NewsSourceGridButton extends StatelessWidget {
  final NewsSource source;
  const NewsSourceGridButton({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: CupertinoColors.black,
        image: DecorationImage(
          image: NetworkImage(source.icon),
          fit: BoxFit.cover,
        ),
        border: Border.all(color: CupertinoColors.systemGrey4, width: 0.5),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
