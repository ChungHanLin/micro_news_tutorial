import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:micro_news_tutorial/models/user.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<UserModel> getUser(String userId) async {
    try {
      final response = await _db.collection("Users").doc(userId).get();
      if (response.exists) {
        return UserModel.fromJson(response.data()!);
      } else {
        return Future.error('使用者不存在');
      }
    } catch (e) {
      return Future.error('連線錯誤');
    }
  }

  void createUser(User user) async {
    await _db.collection("Users").doc(user.uid).set({
      'name': user.displayName ?? '',
      'email': user.email,
      'avatar': user.photoURL ?? '',
      'description': '這是我的自我介紹',
      'createdAt': DateTime.now(),
    }).whenComplete(() => print('使用者建立資料庫成功'));
  }

  void updateUser(
      {required String userId,
      String name = '',
      String description = '',
      String avatar = ''}) async {
    await _db.collection("Users").doc(userId).update({
      'name': name,
      'description': description,
      'avatar': avatar,
    }).whenComplete(() => print('使用者更新資料庫成功'));
  }
}
