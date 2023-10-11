import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/repositories/auth_repository.dart';
import 'package:micro_news_tutorial/views/screens/register_screen.dart';
import 'package:micro_news_tutorial/views/screens/forget_password_screen.dart';
import 'package:micro_news_tutorial/views/screens/tab_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 30, 84, 1),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child:
                        Image.asset('assets/images/padlock.png', height: 30)),
                const SizedBox(height: 16),
                const Text('Micro News ID',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
                const SizedBox(height: 8),
                const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                    child: Text('歡迎使用 Micro News App\n請登入您的帳號！',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            color: CupertinoColors.systemGrey))),
                const SizedBox(height: 32),
                CupertinoTextField(
                  controller: _emailController,
                  placeholder: '電子郵件',
                  keyboardType: TextInputType.emailAddress,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                      color: CupertinoDynamicColor.withBrightness(
                          color: CupertinoColors.systemGroupedBackground,
                          darkColor: Color.fromRGBO(50, 50, 50, 0.8)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                const SizedBox(height: 12),
                CupertinoTextField(
                  controller: _passwordController,
                  placeholder: '密碼',
                  obscureText: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: const BoxDecoration(
                      color: CupertinoDynamicColor.withBrightness(
                          color: CupertinoColors.systemGroupedBackground,
                          darkColor: Color.fromRGBO(50, 50, 50, 0.8)),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
                const SizedBox(height: 0),
                Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) {
                            return const ForgetPasswordScreen();
                          },
                        ));
                      },
                      child: const Text('忘記密碼？',
                          style: TextStyle(
                              fontSize: 14,
                              color: Color.fromRGBO(255, 30, 84, 1)))),
                ]),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                      onPressed: () {
                        AuthRepository().signInWithEmailAndPassword(
                            context: context,
                            email: _emailController.text,
                            password: _passwordController.text);
                      },
                      color: const Color.fromRGBO(255, 30, 84, 1),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      borderRadius: BorderRadius.circular(10),
                      child: const Text('登入',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w700))),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CupertinoButton(
                      onPressed: () {
                        Navigator.push(context, CupertinoPageRoute(
                          builder: (context) {
                            return const RegisterScreen();
                          },
                        ));
                      },
                      color: const CupertinoDynamicColor.withBrightness(
                          color: CupertinoColors.systemGroupedBackground,
                          darkColor: Color.fromRGBO(50, 50, 50, 0.8)),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      borderRadius: BorderRadius.circular(10),
                      child: const Text('註冊帳號',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color.fromRGBO(255, 30, 84, 1)))),
                ),
                const SizedBox(height: 32),
                Row(children: [
                  Expanded(
                      child: SizedBox(
                          height: 0.5,
                          child: Container(color: CupertinoColors.systemGrey))),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('或使用以下方式登入',
                        style: TextStyle(
                            fontSize: 14, color: CupertinoColors.systemGrey)),
                  ),
                  Expanded(
                      child: SizedBox(
                          height: 0.5,
                          child: Container(color: CupertinoColors.systemGrey)))
                ]),
                const SizedBox(height: 32),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  CupertinoButton(
                    onPressed: () {},
                    padding: const EdgeInsets.all(0),
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                            color: CupertinoColors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            border: Border.fromBorderSide(BorderSide(
                                color: CupertinoColors.systemGrey5))),
                        child:
                            Image.asset('assets/images/apple.png', height: 30)),
                  ),
                  const SizedBox(width: 24),
                  CupertinoButton(
                    onPressed: () {
                      AuthRepository()
                          .signInWithGoogle(context: context)
                          .then((value) {
                        if (value == true) {
                          Navigator.of(context).pushReplacement(
                              CupertinoPageRoute(builder: (context) {
                            return const TabLayout();
                          }));
                        }
                      });
                    },
                    padding: const EdgeInsets.all(0),
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: CupertinoColors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          border: Border.fromBorderSide(
                              BorderSide(color: CupertinoColors.systemGrey5)),
                        ),
                        child: Image.asset('assets/images/google.png',
                            height: 30)),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
