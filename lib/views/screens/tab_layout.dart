import 'package:flutter/cupertino.dart';

class TabLayout extends StatelessWidget {
  const TabLayout({super.key});

  static List<String> tabTitle = <String>['主頁', '探索', '搜尋', '個人檔案'];

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill, size: 24), label: '主頁'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.square_grid_2x2_fill, size: 24),
              label: '探索'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.search, size: 24), label: '搜尋'),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_crop_circle, size: 24),
              label: '個人檔案'),
        ]),
        tabBuilder: (BuildContext context, int index) => CupertinoPageScaffold(
                child: CustomScrollView(slivers: <Widget>[
              CupertinoSliverNavigationBar(
                  largeTitle: Text(
                    tabTitle[index],
                  ),
                  backgroundColor: CupertinoColors.white),
            ])));
  }
}
