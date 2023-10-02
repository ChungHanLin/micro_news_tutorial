import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/views/screens/login_screen.dart';
import 'package:micro_news_tutorial/views/screens/tab_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:micro_news_tutorial/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            navLargeTitleTextStyle: TextStyle(
                inherit: false,
                fontSize: 34,
                fontWeight: FontWeight.w700,
                fontFamily: 'GenSenRounded',
                color: CupertinoColors.black,
                letterSpacing: 1.05),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'GenSenRounded',
              color: CupertinoColors.black,
            ),
          ),
          primaryColor: Color.fromRGBO(255, 30, 84, 1),
          barBackgroundColor: CupertinoColors.white,
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const TabLayout();
              } else {
                return const LoginScreen();
              }
            }));
  }
}
