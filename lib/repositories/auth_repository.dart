import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

class AuthRepository {
  // final FirebaseAuth _firebaseAuth;
  // final GoogleSignIn _googleSignIn;

  // AuthRepository()
  //     : _firebaseAuth = FirebaseAuth.instance,
  //       _googleSignIn = GoogleSignIn();

  Future<bool> signInWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          // 夾帶 email 文字框輸入文字
          email: email,
          // 夾帶 password 文字框輸入文字
          password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _showAlertDialog(context, '登入失敗', '電子郵件格式錯誤');
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        _showAlertDialog(context, '登入失敗', '帳號或密碼錯誤');
      } else {
        _showAlertDialog(context, '登入失敗', '發生錯誤');
      }
      return false;
    }
  }

  Future<bool> signUpWithEmailAndPassword(
      {required BuildContext context,
      required String email,
      required String password,
      required String confirmPassword}) async {
    if (password != confirmPassword) {
      _showAlertDialog(context, '密碼不一致', '請檢查您的密碼與驗證密碼欄位內容是否正確');
      return true;
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showAlertDialog(context, '密碼強度不足', '為了您帳號的安全性，請使用強度較高的密碼');
      } else if (e.code == 'email-already-in-use') {
        _showAlertDialog(context, '信箱已被註冊', '該信箱已被註冊，您可以使用該信箱登入或使用其他信箱進行註冊');
      } else if (e.code == 'invalid-email') {
        _showAlertDialog(context, '信箱格式錯誤', '請檢查您的信箱格式是否正確');
      } else {
        _showAlertDialog(context, '註冊失敗', '請稍後再試');
      }
      return false;
    }
  }

  Future<bool> signInWithGoogle({required BuildContext context}) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

        await FirebaseAuth.instance.signInWithCredential(credential);
        return true;
      }
      throw Exception("登錄失敗");
    } catch (e) {
      _showAlertDialog(context, "登入失敗", "請稍後再試");
      return false;
    }
  }

  Future<bool> sendPasswordResetEmail(
      {required BuildContext context, required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        _showAlertDialog(context, '電子郵件格式錯誤', '請檢查您的電子郵件格式是否正確');
      } else if (e.code == 'user-not-found') {
        _showAlertDialog(context, '找不到使用者', '請檢查您的電子郵件是否正確');
      } else {
        _showAlertDialog(context, '發生錯誤', '請稍後再試');
      }
      return false;
    }
  }
}
