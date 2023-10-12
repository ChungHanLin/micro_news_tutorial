import 'package:flutter/cupertino.dart';
import 'package:micro_news_tutorial/l10n/l10n.dart';

class LocaleModel with ChangeNotifier {
  Locale _locale = L10n.all.first;
  Locale get locale => _locale;

  void setLocale(Locale l) {
    if (!L10n.all.contains(l)) {
      return;
    }
    _locale = l;
    notifyListeners();
  }
}
