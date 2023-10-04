import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/views/screens/browse_screen.dart';
import 'package:micro_news_tutorial/views/screens/home_screen.dart';
import 'package:micro_news_tutorial/views/screens/profile_screen.dart';
import 'package:micro_news_tutorial/views/screens/search_screen.dart';

class TabLayout extends StatelessWidget {
  const TabLayout({super.key});

  static List<String> tabTitle = <String>['焦點新聞', '探索', '搜尋', '個人檔案'];

  Widget getTabScreen(int index) {
    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const BrowseScreen();
      case 2:
        return const SearchScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const HomeScreen();
    }
  }

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
      tabBuilder: (BuildContext context, int index) => getTabScreen(index),
    );
  }
}
