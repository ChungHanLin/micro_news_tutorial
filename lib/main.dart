import 'package:flutter/cupertino.dart';
import 'views/screens/login_screen.dart';
import 'views/screens/register_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
        debugShowCheckedModeBanner: false, home: LoginScreen());
  }
}
