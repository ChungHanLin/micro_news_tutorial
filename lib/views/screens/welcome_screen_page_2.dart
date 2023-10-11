import 'package:flutter/cupertino.dart';

class WelcomePage2 extends StatelessWidget {
  const WelcomePage2({super.key});

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
                child:
                    Image.asset('assets/images/notification.png', height: 64)),
            const SizedBox(height: 32),
            const Text('鐵人賽',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40)),
            const SizedBox(height: 6),
            const Text('每日一篇',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Color.fromRGBO(255, 30, 84, 1))),
            const SizedBox(height: 64),
            const Text('歡迎訂閱 留言分享',
                style:
                    TextStyle(fontSize: 28, color: CupertinoColors.systemGrey)),
            const SizedBox(height: 64)
          ]),
    );
  }
}
