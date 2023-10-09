import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/models/user.dart';
import 'package:micro_news_tutorial/repositories/user.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  bool _isChanged = false;
  late Future<UserModel> _user;
  late TextEditingController _nameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _descriptionTextController;

  @override
  void initState() {
    super.initState();
    _nameTextController = TextEditingController();
    _emailTextController = TextEditingController();
    _descriptionTextController = TextEditingController();
    _user = UserRepository()
        .getUser(FirebaseAuth.instance.currentUser!.uid)
        .then((value) {
      setState(() {
        _nameTextController.text = value.name;
        _emailTextController.text = value.email;
        _descriptionTextController.text = value.description;
      });
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          previousPageTitle: '個人資料',
          backgroundColor: CupertinoColors.systemGroupedBackground,
          border: null,
          trailing: _isChanged
              ? CupertinoButton(
                  onPressed: () async {},
                  padding: EdgeInsets.zero,
                  child: const Text(
                    '儲存',
                  ),
                )
              : null,
        ),
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: FutureBuilder(
            future: _user,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text('發生${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Container(
                              height: 120,
                              width: 120,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(60)),
                                color: CupertinoColors.systemGrey2,
                              ),
                              child: Center(
                                child: Text(snapshot.data!.name.substring(0, 1),
                                    style: const TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.w500,
                                        color: CupertinoColors.white)),
                              )),
                        ),
                        const SizedBox(height: 16),
                        CupertinoListSection.insetGrouped(children: [
                          CupertinoTextField(
                            controller: _nameTextController,
                            placeholder: '姓名',
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: const BoxDecoration(
                                border: null,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            prefix: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: CupertinoColors.systemBlue),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(CupertinoIcons.person_solid,
                                        color: CupertinoColors.white, size: 20),
                                  )),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isChanged = true;
                              });
                            },
                          ),
                          CupertinoTextField(
                            readOnly: true,
                            controller: _emailTextController,
                            placeholder: '電子郵件',
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: const BoxDecoration(
                                border: null,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            prefix: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: CupertinoColors.systemPink),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(CupertinoIcons.mail_solid,
                                        color: CupertinoColors.white, size: 20),
                                  )),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isChanged = true;
                              });
                            },
                          ),
                          CupertinoTextField(
                            controller: _descriptionTextController,
                            placeholder: '自我介紹',
                            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                            decoration: const BoxDecoration(
                                border: null,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            prefix: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: CupertinoColors.systemOrange),
                                  child: const Padding(
                                    padding: EdgeInsets.all(4),
                                    child: Icon(CupertinoIcons.pencil,
                                        color: CupertinoColors.white, size: 20),
                                  )),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _isChanged = true;
                              });
                            },
                          ),
                        ]),
                      ]);
                } else {
                  return const Center(child: Text('沒有資料'));
                }
              } else {
                return const Center(child: CupertinoActivityIndicator());
              }
            }));
  }
}
