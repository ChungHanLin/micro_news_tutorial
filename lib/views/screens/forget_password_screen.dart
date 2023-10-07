import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/repositories/auth_repository.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
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
                  child: Image.asset('assets/images/email.png', height: 30)),
              const SizedBox(height: 16),
              const Text('Micro News ID',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Text('輸入您的電子郵件\n我們將寄送重設密碼驗證信',
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
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                    onPressed: () {
                      AuthRepository()
                          .sendPasswordResetEmail(
                              context: context, email: _emailController.text)
                          .then((state) => {
                                if (state) {Navigator.pop(context)}
                              });
                    },
                    color: const Color.fromRGBO(255, 30, 84, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    borderRadius: BorderRadius.circular(10),
                    child: const Text('送出',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w700))),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
