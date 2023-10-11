import 'package:flutter/cupertino.dart';

class WelcomePage1 extends StatelessWidget {
  const WelcomePage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemGroupedBackground,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Image.asset('assets/images/news.png', height: 64)),
            const SizedBox(height: 32),
            const Text('歡迎使用',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40)),
            const SizedBox(height: 6),
            const Text('新聞',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Color.fromRGBO(255, 30, 84, 1))),
            const SizedBox(height: 64),
            const Text('最新資訊 俯拾即是',
                style:
                    TextStyle(fontSize: 28, color: CupertinoColors.systemGrey)),
            const SizedBox(height: 64)
          ]),
    );
  }
}
