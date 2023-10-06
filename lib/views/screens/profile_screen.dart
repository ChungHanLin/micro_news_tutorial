import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/views/widgets/profile_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDailyReport = false;
  bool _isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CustomScrollView(slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text(
              '個人資料',
            ),
            backgroundColor: CupertinoColors.systemGroupedBackground,
            border: null,
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              const ProfileCard(),
              CupertinoListSection.insetGrouped(
                header: const Padding(
                  padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text('一般設定',
                      style: TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.w500)),
                ),
                children: [
                  CupertinoListTile.notched(
                      title: const Text('每日一報'),
                      leading: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: CupertinoColors.systemRed),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(CupertinoIcons.doc_text_fill,
                                color: CupertinoColors.white, size: 20),
                          )),
                      trailing: CupertinoSwitch(
                          value: _isDailyReport,
                          onChanged: (bool? value) {
                            setState(() {
                              _isDailyReport = value!;
                            });
                          })),
                  CupertinoListTile.notched(
                      title: const Text('夜間模式'),
                      leading: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: CupertinoColors.systemIndigo),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(CupertinoIcons.moon_fill,
                                color: CupertinoColors.white, size: 20),
                          )),
                      trailing: CupertinoSwitch(
                          value: _isDarkMode,
                          onChanged: (bool? value) {
                            setState(() {
                              _isDarkMode = value!;
                            });
                          })),
                ],
              ),
            ],
          )),
        ]));
  }
}
