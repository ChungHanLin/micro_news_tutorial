import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/repositories/user.dart';
import 'package:micro_news_tutorial/views/screens/login_screen.dart';
import 'package:micro_news_tutorial/views/screens/tab_layout.dart';

class DummyScreen extends StatelessWidget {
  const DummyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
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
            print('snapshot.hasData');
            return const TabLayout();
          } else {
            print('snapshot.hasNoData');
            return const LoginScreen();
          }
        });
  }
}
