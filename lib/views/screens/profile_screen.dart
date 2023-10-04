import 'package:flutter/cupertino.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
          largeTitle: Text(
            '個人資料',
          ),
          backgroundColor: CupertinoColors.white),
      SliverToBoxAdapter(child: Text('Profile Screen'))
    ]));
  }
}
