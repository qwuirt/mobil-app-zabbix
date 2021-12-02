
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/ui/setting/about_the_program/about_the_program_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_graph/graphs_hostgroup_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_event/resolved_problem_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_scripts/scripts_hostgroup_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_overview/overview_hostgroup_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/setting/setting_page.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IconMenu extends StatefulWidget {
  @override
  _IconMenu createState() => _IconMenu();
}

class _IconMenu extends State<IconMenu> {

  @override
  Widget build(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return Builder(
      builder: (context) {
        return Center(
          child: IconButton(
            icon: Icon(
              Icons.view_list,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    color: Colors.black,
                    height: 240,
                    child: DropdownMenuItem(
                      child: Container(
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                height: 40,
                                width: 150,
                                child: ListTile(
                                  title: TextButton(
                                    child: Text(
                                      AppLocalizations.of(context)!.overview,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      zabbixBloc.add(ZabbixOverviewLoadEvent());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OverviewHostgroupPage()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 200,
                                child: ListTile(
                                  title: TextButton(
                                    child: Text(
                                      AppLocalizations.of(context)!.resolvedProblem,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      zabbixBloc.add(ZabbixResolvedProblemLoadEvent());
                                      saveDateTime();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ResolvedProblemsPage()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 150,
                                child: ListTile(
                                  title: TextButton(
                                    child: Text(
                                      AppLocalizations.of(context)!.graphs,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      zabbixBloc.add(ZabbixGraphLoadEvent());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => GraphsHostgroupPage()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 150,
                                child: ListTile(
                                  title: TextButton(
                                    child: Text(
                                      AppLocalizations.of(context)!.scripts,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      zabbixBloc.add(ZabbixScriptsLoadEvent());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ScriptsHostgroupPage()),
                                      );
                                    },
                                  ),
                                ),
                              ),                    
                              Container(
                                height: 40,
                                width: 150,
                                child: ListTile(
                                  title: TextButton(
                                    child: Text(
                                      AppLocalizations.of(context)!.configurations,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      zabbixBloc.add(ZabbixSettingLoadEvent());
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SettingPage()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 150,
                                child: ListTile(
                                  title: TextButton(
                                    child: Text(
                                      AppLocalizations.of(context)!.about,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AboutProgramPage()),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        );
      },
    );
  }

  void saveDateTime() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setInt('dateTimeTo', DateTime.now().millisecondsSinceEpoch);
    localStorage.setInt('dateTimeFrom', DateTime.now().millisecondsSinceEpoch - 21600000);
  }
}
