import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/l10n/l10n.dart';
import 'package:micro_news_tutorial/models/locale.dart';
import 'package:micro_news_tutorial/models/theme.dart';
import 'package:micro_news_tutorial/plugins/notification.dart';
import 'package:micro_news_tutorial/views/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:micro_news_tutorial/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation('Asia/Taipei'));
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await NotificationPlugin().init();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ThemeModel()),
    ChangeNotifierProvider(create: (_) => LocaleModel()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final themeModel = Provider.of<ThemeModel>(context);
    final localeModel = Provider.of<LocaleModel>(context);
    return CupertinoApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: L10n.all,
        locale: localeModel.locale,
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
        home: const SplashScreen());
  }
}
