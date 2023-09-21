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
                    onPressed: () {},
                    child: const Text('前往登入',
                        style: TextStyle(
                            fontSize: 14,
                            color: Color.fromRGBO(255, 30, 84, 1)))),
              ]),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: CupertinoButton(
                    onPressed: () {},
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
