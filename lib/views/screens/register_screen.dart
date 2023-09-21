import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('關閉'),
          ),
        ],
      ),
    );
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
                  child: Image.asset('assets/images/padlock.png', height: 30)),
              const SizedBox(height: 16),
              const Text('Micro News ID',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                  child: Text('註冊一個新帳號',
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
                    color: CupertinoColors.systemGroupedBackground,
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
                    color: CupertinoColors.systemGroupedBackground,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              const SizedBox(height: 12),
              CupertinoTextField(
                controller: _confirmPasswordController,
                placeholder: '驗證密碼',
                obscureText: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: const BoxDecoration(
                    color: CupertinoColors.systemGroupedBackground,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                const Text('已有帳號？',
                    style: TextStyle(
                        fontSize: 14, color: CupertinoColors.systemGrey)),
                const SizedBox(width: 4),
                CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('前往登入',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(255, 30, 84, 1)))),
              ]),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                    onPressed: () async {
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        _showAlertDialog(
                            context, '密碼不一致', '請檢查您的密碼與驗證密碼欄位內容是否正確');
                        return;
                      }
                      try {
                        UserCredential newUser = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        print(newUser);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          _showAlertDialog(
                              context, '密碼強度不足', '為了您帳號的安全性，請使用強度較高的密碼');
                        } else if (e.code == 'email-already-in-use') {
                          _showAlertDialog(context, '信箱已被註冊',
                              '該信箱已被註冊，您可以使用該信箱登入或使用其他信箱進行註冊');
                        } else if (e.code == 'invalid-email') {
                          _showAlertDialog(context, '信箱格式錯誤', '請檢查您的信箱格式是否正確');
                        } else {
                          _showAlertDialog(context, '註冊失敗', '請稍後再試');
                        }
                      }
                    },
                    color: const Color.fromRGBO(255, 30, 84, 1),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    borderRadius: BorderRadius.circular(10),
                    child: const Text('註冊',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: CupertinoColors.white))),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
