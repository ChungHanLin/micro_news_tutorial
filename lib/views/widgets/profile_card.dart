import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/user.dart';
import 'package:micro_news_tutorial/repositories/user.dart';
import 'package:micro_news_tutorial/views/screens/account_screen.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late Future<UserModel> _user;

  @override
  void initState() {
    super.initState();
    _user = UserRepository().getUser(FirebaseAuth.instance.currentUser!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _user,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return CupertinoListSection.insetGrouped(
                children: [
                  CupertinoListTile(
                      title: Text('Micro Jordan',
                          style: const TextStyle(
                              fontSize: 20,
                              height: 1.2,
                              fontWeight: FontWeight.w500)),
                      subtitle: Text(snapshot.data!.description,
                          style: const TextStyle(fontSize: 14)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      leadingSize: 60,
                      leadingToTitle: 12,
                      leading: snapshot.data!.avatar == ''
                          ? Container(
                              width: 50,
                              height: 50,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: CupertinoColors.systemGrey4),
                            )
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image:
                                          NetworkImage(snapshot.data!.avatar),
                                      fit: BoxFit.cover)),
                            ),
                      trailing: const Icon(CupertinoIcons.right_chevron,
                          size: 20, color: CupertinoColors.systemGrey),
                      onTap: () async {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => const AccountScreen()));
                      }),
                ],
              );
            } else {
              return const Center(child: Text('使用者不存在'));
            }
          } else {
            return const Center(child: CupertinoActivityIndicator());
          }
        }));
  }
}
