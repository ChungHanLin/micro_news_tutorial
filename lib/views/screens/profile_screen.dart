import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:micro_news_tutorial/l10n/l10n.dart';
import 'package:micro_news_tutorial/models/locale.dart';
import 'package:micro_news_tutorial/models/theme.dart';
import 'package:micro_news_tutorial/plugins/notification.dart';
import 'package:micro_news_tutorial/views/screens/dummy_screen.dart';
import 'package:micro_news_tutorial/views/widgets/profile_card.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDailyReport = false;
  int _selectedLocale = 0;

  void _showPicker(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeModel themeModel = Provider.of<ThemeModel>(context);
    final LocaleModel localeModel = Provider.of<LocaleModel>(context);
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGroupedBackground,
        child: CustomScrollView(slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text(
              AppLocalizations.of(context)!.profile_title,
            ),
            backgroundColor: CupertinoColors.systemGroupedBackground,
            border: null,
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              const ProfileCard(),
              CupertinoListSection.insetGrouped(
                header: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                  child: Text(AppLocalizations.of(context)!.general_setting,
                      style: const TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemGrey,
                          fontWeight: FontWeight.w500)),
                ),
                children: [
                  CupertinoListTile.notched(
                      title: Text(AppLocalizations.of(context)!.notification),
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
                            if (value == true) {
                              NotificationPlugin().showPeriodicNotification(
                                  title: '每日一報',
                                  body: '我們為您準備好了專屬於您的新聞，歡迎您來看看！',
                                  interval: RepeatInterval.daily);
                            }
                            setState(() {
                              _isDailyReport = value!;
                            });
                          })),
                  CupertinoListTile.notched(
                      title: Text(AppLocalizations.of(context)!.dark_mode),
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
                          value: themeModel.isDark,
                          onChanged: (bool? value) {
                            themeModel.toggleTheme();
                          })),
                  CupertinoListTile.notched(
                      onTap: () {
                        _showPicker(CupertinoPicker(
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32.0,
                            scrollController: FixedExtentScrollController(
                              initialItem: _selectedLocale,
                            ),
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                _selectedLocale = selectedItem;
                              });
                              localeModel.setLocale(L10n.all[selectedItem]);
                              // print(_sclectedLocale)
                            },
                            children: List<Widget>.generate(
                                L10n.languages.length, (int index) {
                              return Center(child: Text(L10n.languages[index]));
                            })));
                      },
                      title: Text(AppLocalizations.of(context)!.language),
                      leading: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: CupertinoColors.systemGreen),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(CupertinoIcons.t_bubble_fill,
                                color: CupertinoColors.white, size: 20),
                          )),
                      trailing: Text(L10n.languages[_selectedLocale])),
                  CupertinoListTile.notched(
                      title: Text(AppLocalizations.of(context)!.sign_out),
                      leading: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              color: CupertinoColors.systemGrey),
                          child: const Padding(
                            padding: EdgeInsets.all(4),
                            child: Icon(CupertinoIcons.arrow_right_to_line,
                                color: CupertinoColors.white, size: 20),
                          )),
                      onTap: () {
                        FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushReplacement(
                            CupertinoPageRoute(builder: (context) {
                          return const DummyScreen();
                        }));
                      }),
                ],
              ),
            ],
          )),
        ]));
  }
}
