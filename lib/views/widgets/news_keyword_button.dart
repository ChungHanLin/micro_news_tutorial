import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/styles.dart';
import 'package:micro_news_tutorial/views/screens/result_screen.dart';

class NewsKeywordButton extends StatelessWidget {
  final String keyword;

  const NewsKeywordButton({super.key, required this.keyword});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: CupertinoColors.systemGrey6,
      borderRadius: BorderRadius.circular(8),
      onPressed: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ResultScreen(query: keyword),
          ),
        );
      },
      child: Text(keyword,
          style: TextStyle(
              color: CupertinoTheme.of(context).textTheme.textStyle.color)),
    );
  }
}
