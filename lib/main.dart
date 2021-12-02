import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:Zabbix/provider/locale_provider.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_problem/problem_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:wakelock/wakelock.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:Zabbix/zabbix_bloc/data/repositories/zabbix_repository.dart';

import 'l10n/l10n.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await ListUserPreferences.init();
  await ListUrlApiPreferences.init();
  await ListPasswordPreferences.init();
  await ListServerZabbixPreferences.init();
  await ListPriorityProblemsPreferences.init();
  await ListPrioritySystemStatusPreferences.init();

  await UserPreferences.init();
  await UrlApiPreferences.init();
  await PasswordPreferences.init();
  await SelectPriorityProblemsPreferences.init();
  await SelectPrioritySystemStatusPreferences.init();
  await AutoRefreshPreferences.init();
  await IsCheckedAutoRefreshPreferences.init();
  await LanguagePreferences.init();

  runApp(MainZabbixApp());
}

class MainZabbixApp extends StatelessWidget {
  final ZabbixRepository zabbixRepository = ZabbixRepository();
  late ZabbixBloc problemBloc = ZabbixBloc(zabbixRepository: zabbixRepository);

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return BlocProvider<ZabbixBloc>(
      create: (context) => ZabbixBloc(zabbixRepository: zabbixRepository),
      child: ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final provider = Provider.of<LocaleProvider>(context);
            return MaterialApp(
              title: 'zabbix',
              debugShowCheckedModeBanner: false,
              locale: provider.locale,
              supportedLocales: L10n.all,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              home: ProblemPage()
            );
          }),
    );
  }
}
