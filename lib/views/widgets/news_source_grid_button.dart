import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_source.dart';
import 'package:micro_news_tutorial/views/screens/result_screen.dart';

class NewsSourceGridButton extends StatelessWidget {
  final NewsSource source;
  const NewsSourceGridButton({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => ResultScreen(source: source.name)));
      },
      child: Container(
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
      ),
    );
  }
}
