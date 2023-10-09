import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/theme.dart';
import 'package:micro_news_tutorial/plugins/notification.dart';
import 'package:micro_news_tutorial/repositories/user.dart';
import 'package:micro_news_tutorial/views/screens/login_screen.dart';
import 'package:micro_news_tutorial/views/screens/tab_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:micro_news_tutorial/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Taipei'));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationPlugin().init();
  runApp(ChangeNotifierProvider(
      create: (context) => ThemeModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        theme: CupertinoThemeData(
          brightness: themeModel.isDark ? Brightness.dark : Brightness.light,
          textTheme: const CupertinoTextThemeData(
            navLargeTitleTextStyle: TextStyle(
                inherit: false,
                fontSize: 34,
                fontWeight: FontWeight.w700,
                fontFamily: 'GenSenRounded',
                color: CupertinoDynamicColor.withBrightness(
                    color: CupertinoColors.black,
                    darkColor: CupertinoColors.white),
                letterSpacing: 1.05),
            textStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              fontFamily: 'GenSenRounded',
              color: CupertinoDynamicColor.withBrightness(
                  color: CupertinoColors.black,
                  darkColor: CupertinoColors.white),
            ),
          ),
          primaryColor: const Color.fromRGBO(255, 30, 84, 1),
          barBackgroundColor: const CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.white, darkColor: CupertinoColors.black),
        ),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // 進入前先檢查 firestore 中是否有資料，若無則新增
                final user = FirebaseAuth.instance.currentUser;
                final userRepository = UserRepository();

                // 檢查 firestore 中是否有資料
                userRepository
                    .getUser(user!.uid)
                    .then((value) {})
                    .catchError((error) {
                  // 若無則新增
                  userRepository.createUser(user);
                });

                return const TabLayout();
              } else {
                return const LoginScreen();
              }
            }));
  }
}
