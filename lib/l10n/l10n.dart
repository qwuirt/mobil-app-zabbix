

import 'dart:ui';


class L10n {
  static final all = [
     Locale('en', ''),
     Locale('uk', ''),
     Locale('ru', ''),
     Locale('de', ''),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'uk':
        return 'Українська';
      case 'ru':
        return 'Русский';
      case 'de':
        return 'German';
      case 'en' :
        default:
          return 'English';
    }
  }
}