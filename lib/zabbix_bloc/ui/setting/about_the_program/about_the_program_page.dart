
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(AboutProgramPage());

class AboutProgramPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(AppLocalizations.of(context)!.about),
        ),
        body: Container(
          color: Colors.black54,
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '"Zabbix client for phone"',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Version 0.0.15',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Author:',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  'Ihor Hrymut',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                Text(
                  ' Uzhorod, Ukraine',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }
}
