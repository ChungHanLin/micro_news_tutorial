import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/views/screens/login_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:micro_news_tutorial/views/screens/welcome_screen_page_1.dart';
import 'package:micro_news_tutorial/views/screens/welcome_screen_page_2.dart';
import 'package:micro_news_tutorial/views/screens/welcome_screen_page_3.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _onLastPage = false;
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Stack(children: [
      PageView(
        controller: _controller,
        onPageChanged: (value) {
          setState(() {
            _onLastPage = value == 2;
          });
        },
        children: const [
          WelcomePage1(),
          WelcomePage2(),
          WelcomePage3(),
        ],
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 32),
        child: Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CupertinoButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                          CupertinoPageRoute(builder: (context) {
                        return const LoginScreen();
                      }));
                    },
                    child: const Text('跳過')),
                SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: const WormEffect(
                      dotHeight: 12,
                      dotWidth: 12,
                      activeDotColor: Color.fromRGBO(255, 30, 84, 1),
                      dotColor: CupertinoColors.systemGrey4,
                    )),
                _onLastPage
                    ? CupertinoButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(builder: (context) {
                            return const LoginScreen();
                          }));
                        },
                        child: const Text('完成'),
                      )
                    : CupertinoButton(
                        onPressed: () {
                          _controller.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        child: const Text('下一頁'),
                      ),
              ],
            )),
      )
    ]));
  }
}
