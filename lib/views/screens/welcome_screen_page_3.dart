import 'package:flutter/cupertino.dart';

class WelcomePage3 extends StatelessWidget {
  const WelcomePage3({super.key});

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
                child: Image.asset('assets/images/calendar.png', height: 64)),
            const SizedBox(height: 32),
            const Text('進入',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 40)),
            const SizedBox(height: 6),
            const Text('最後衝刺',
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 40,
                    color: Color.fromRGBO(255, 30, 84, 1))),
            const SizedBox(height: 64),
            const Text('終於快結束了QQ',
                style:
                    TextStyle(fontSize: 28, color: CupertinoColors.systemGrey)),
            const SizedBox(height: 64)
          ]),
    );
  }
}
