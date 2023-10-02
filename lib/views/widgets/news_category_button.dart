import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_category.dart';

class NewsCategoryButton extends StatelessWidget {
  final NewsCategory category;
  const NewsCategoryButton({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomLeft, children: [
      Container(
        decoration: BoxDecoration(
          color: CupertinoColors.black,
          image: DecorationImage(
            opacity: 0.7,
            image: NetworkImage(category.cover),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 8),
        child: Text(category.name,
            style: const TextStyle(
                fontSize: 20,
                color: CupertinoColors.white,
                fontWeight: FontWeight.w700)),
      )
    ]);
  }
}
