

import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:flutter/material.dart';
import 'package:Zabbix/l10n/l10n.dart';


class LocaleProvider extends ChangeNotifier{
  String language =  LanguagePreferences.getLanguage() ?? '';
  defaultLanguage() {
    if (language == '') {
      return 'en';
    } else {
      return language;
    }
  }


  late Locale _locale = Locale(defaultLanguage());

  Locale get locale => _locale;
  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }

  void clearLocale() {
    _locale == null;
    notifyListeners();
  }

}