import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:micro_news_tutorial/views/screens/dummy_screen.dart';
import 'package:micro_news_tutorial/views/screens/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context)
          .pushReplacement(CupertinoPageRoute(builder: (context) {
        return FutureBuilder(
            future: _prefs,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final prefs = snapshot.data as SharedPreferences;
                final isFirstTime = prefs.getBool('isFirstTime') ?? true;
                if (isFirstTime) {
                  prefs.setBool('isFirstTime', false);
                  return const WelcomeScreen();
                } else {
                  return const DummyScreen();
                }
              } else {
                return const DummyScreen();
              }
            });
      }));
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
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
                  style: TextStyle(
                      fontSize: 28, color: CupertinoColors.systemGrey)),
              const SizedBox(height: 64)
            ]),
      ),
    );
  }
}
