import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Zabbix/l10n/l10n.dart';
import 'package:Zabbix/provider/locale_provider.dart';

class LanguageWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final flag = L10n.getFlag(locale.languageCode);
    return Center(
      child: Text(
        flag, style: TextStyle(color: Colors.red,fontSize: 50),
      ),
    );
  }

}



class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Container(
      width: 120,
      child: DropdownButton(
        iconSize: 30.0,
        isExpanded: true,
        dropdownColor: Colors.black87,
        value: locale,
        icon: Container(width: 12,),
        items: L10n.all.map((locale) {
          final flag = L10n.getFlag(locale.languageCode);
          return DropdownMenuItem(
            child: Center(
              child: Text(flag, style: TextStyle(color: Colors.white, fontSize: 20),),
            ),
            value: locale,
            onTap: () {
              final provider = Provider.of<LocaleProvider>(context, listen:  false);

              provider.setLocale(locale);
            },
          );
        },).toList(),
        onChanged: (_) {},
      ),
    );
  }
}