import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/news_source.dart';

class NewsSourceRowButton extends StatelessWidget {
  final NewsSource source;
  const NewsSourceRowButton({super.key, required this.source});

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
        onTap: () {},
        title: Text(source.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.05,
            )),
        subtitle: Text(source.id, style: const TextStyle(height: 1.4)),
        leading: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: NetworkImage(source.icon),
                fit: BoxFit.cover,
              ),
              border:
                  Border.all(color: CupertinoColors.systemGrey, width: 0.2)),
        ),
        leadingSize: 60,
        backgroundColorActivated: CupertinoColors.systemGrey5,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        trailing: SizedBox(
          height: 30,
          child: CupertinoButton(
            onPressed: () {},
            color: CupertinoColors.systemGrey6,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            borderRadius: BorderRadius.circular(30),
            child: const Text('前往',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(255, 30, 84, 1))),
          ),
        ));
  }
}
