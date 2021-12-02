import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/ui/setting/icon_menu.dart';
import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/host_trigger_model/host_trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_graph/graph_detail_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_overview/overview_last_value_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_problem/confirmation_problem_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_problem/problem_event.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_scripts/script_execute_page.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SystemDetailProblemPage extends StatelessWidget {
  String title;
  List systemProblems;

  SystemDetailProblemPage({
    required this.systemProblems,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(
                '$title',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              alignment: Alignment.bottomLeft,
            ),
            IconMenu(),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            zabbixBloc.add(ZabbixSystemStatusLoadEvent());
          });
        },
        child: Container(
          color: Colors.black54,
          child: BlocListener<ZabbixBloc, ZabbixState>(
            listener: (context, state) {
              if (state is ZabbixSystemStatusErrorState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(''),
                  ),
                );
              }
            },
            child: BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
                if (state is ZabbixInitialState) {
                  return buildLoading();
                } else if (state is ZabbixSystemStatusLoadingState) {
                  return buildLoading();
                } else if (state is ZabbixLoginLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixSystemStatusLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixCheckProblemLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixOverviewLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixHistoryOverviewLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixGraphLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixAllLoadedState) {
                  return buildSystemStatusList(context);
                }  else if (state is ZabbixScriptsLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixScriptDetailLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixScriptExecuteLoadedState) {
                  return buildSystemStatusList(context);
                } else if (state is ZabbixSystemStatusErrorState) {
                  return buildErrorUi(context, state.message);
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSystemStatusList(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    var countNullProblem = 0;
    var checkNullProblem = 0;

    notFoundProblem(String str) {
      if (checkNullProblem == 0) {
        countNullProblem++;
        if (countNullProblem == systemProblems.length) {
          countNullProblem = 0;
          return Container(
            padding: const EdgeInsets.only(top: 100),
            child: Center(
              child: Text(
                str,
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 15,
                ),
              ),
            ),
          );
        }
      }
      return Container();
    }
    if (systemProblems.length == 0) {
      return Container(
        padding: const EdgeInsets.only(top: 100),
        color: Colors.black,
        child: Center(
          child: TextButton(
            child: Text(
              AppLocalizations.of(context)!.noProblem,
              style: TextStyle(color: Colors.green, fontSize: 15),
            ),
            onPressed: () {
              zabbixBloc.add(ZabbixSystemStatusLoadEvent());
            },
          ),
        ),
      );
    }
    return Container(
      color: Colors.black,
      child: ListView.builder(
          itemCount: systemProblems.length,
          itemBuilder: (ctx, pos) {
            final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
            int problemPriority = int.parse(systemProblems[pos].priority);
            String selectPriority =
                SelectPrioritySystemStatusPreferences.getSelectPrioritySystemStatus() ?? '';
            int priorityThreshold = int.parse(selectPriority);

            saveData() async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString(
                  'hostid', systemProblems[pos].triggerHosts[0].hostid);
              localStorage.setString(
                  'triggerid', systemProblems[pos].triggerid);
            }

            problemManualClose() {
              if (systemProblems[pos].manual_close == '1') {
                return Text(
                  '[M]',
                  style: TextStyle(color: Colors.white),
                );
              } else {
                return Text('');
              }
            }

            problemAcknowledged() {
              if (systemProblems[pos].triggerLastEvent.acknowledged == '1') {
                return Text(
                  '[A]',
                  style: TextStyle(color: Colors.white),
                );
              } else {
                return Text('');
              }
            }

            // problemAcknowledges() {
            //   if (triggerResult[pos].acknowledges.isNotEmpty) {
            //     return Text('[C]', style: TextStyle(color: Colors.white),);
            //   } else {
            //     return Text('');
            //   }
            // }

            DateTime dateNow = DateTime.now();
            int dateFromJsonInt =
                int.parse(systemProblems[pos].triggerLastEvent.clock);
            var dateIssues =
                DateTime.fromMillisecondsSinceEpoch(dateFromJsonInt * 1000);
            Duration difference = dateNow.difference(dateIssues);
            var secondDifference = difference.inSeconds;

            outputDifferenceHour(var sec) {
              if (sec <= 2678400 && sec <= 86400 && sec <= 3600 && sec <= 60) {
                int second = sec;
                return Text(
                  '${second}s',
                  style: TextStyle(color: Colors.white),
                );
              } else if (sec <= 2678400 && sec <= 86400 && sec <= 3600) {
                int minutes = sec ~/ 60;
                sec %= 60;
                int second = sec;
                return Text(
                  '${minutes}m ${second}s',
                  style: TextStyle(color: Colors.white),
                );
              } else if (sec <= 2678400 && sec <= 86400) {
                int hour = sec ~/ 3600;
                sec %= 3600;
                int minutes = sec ~/ 60;
                sec %= 60;
                int second = sec;
                return Text(
                  '${hour}h ${minutes}m ${second}s',
                  style: TextStyle(color: Colors.white),
                );
              } else if (sec <= 2678400) {
                int day = sec ~/ (24 * 3600);
                sec %= (24 * 3600);
                int hour = sec ~/ 3600;
                sec %= 3600;
                int minutes = sec ~/ 60;
                sec %= 60;
                int second = sec;
                return Text(
                  '${day}d ${hour}h ${minutes}m',
                  style: TextStyle(color: Colors.white),
                );
              } else {
                int month = sec ~/ (86400 * 31);
                sec %= (86400 * 31);
                int day = sec ~/ (24 * 3600);
                sec %= (24 * 3600);
                int hour = sec ~/ 3600;
                sec %= 3600;
                int minutes = sec ~/ 60;
                sec %= 60;
                int second = sec;
                return Text(
                  '${month}m ${day}d ${hour}h',
                  style: TextStyle(color: Colors.white),
                );
              }
            }

            showAlertDialog() {
              return showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                      title: Text('${systemProblems[pos].triggerHosts[0].name}',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black,
                      content: Container(
                        color: Colors.black54,
                        height: 240,
                        child: Column(children: [
                          TextButton(
                            onPressed: () {
                              navigateToConfirmationProblem(
                                  context, systemProblems[pos]);
                            },
                            child:
                                Text(AppLocalizations.of(context)!.acknowledge,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                    )),
                          ),
                          TextButton(
                            onPressed: () {
                              saveData();
                              zabbixBloc.add(ZabbixProblemLoadEvent());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProblemEventPage(
                                        title:
                                            systemProblems[pos].description)),
                              );
                            },
                            child: Text(AppLocalizations.of(context)!.events,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                          ),
                          TextButton(
                            onPressed: () {
                              saveData();
                              zabbixBloc.add(ZabbixGraphLoadEvent());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GraphDetailPage(
                                        title: systemProblems[pos]
                                            .triggerHosts[0]
                                            .name)),
                              );
                            },
                            child: Text(AppLocalizations.of(context)!.graphs,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                          ),
                          TextButton(
                            onPressed: () {
                              saveData();
                              zabbixBloc.add(ZabbixScriptsLoadEvent());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScriptsExecutePage(
                                        title: systemProblems[pos]
                                            .triggerHosts[0]
                                            .name)),
                              );
                            },
                            child: Text(AppLocalizations.of(context)!.scripts,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                          ),
                          TextButton(
                            onPressed: () {
                              saveData();
                              zabbixBloc.add(ZabbixOverviewLoadEvent());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OverviewLastValuePage(
                                        title: systemProblems[pos]
                                            .triggerHosts[0]
                                            .name)),
                              );
                            },
                            child: Text(AppLocalizations.of(context)!.overview,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                )),
                          ),
                        ]),
                      )));
            }
            if (problemPriority == 5 && problemPriority >= priorityThreshold) {
              checkNullProblem = 0;
              return FlatButton(
                padding: const EdgeInsets.all(1),
                onPressed: () => showAlertDialog(),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  color: const Color.fromRGBO(255, 0, 0, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${systemProblems[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${systemProblems[pos].description}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(children: [
                        outputDifferenceHour(secondDifference),
                        Row(children: [
                          problemManualClose(),
                          problemAcknowledged(),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (problemPriority == 4 &&
                problemPriority >= priorityThreshold) {
              checkNullProblem = 0;
              return FlatButton(
                padding: const EdgeInsets.all(1),
                onPressed: () => showAlertDialog(),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  color: const Color.fromRGBO(233, 118, 89, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${systemProblems[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${systemProblems[pos].description}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(children: [
                        outputDifferenceHour(secondDifference),
                        Row(children: [
                          problemManualClose(),
                          problemAcknowledged(),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (problemPriority == 3 &&
                problemPriority >= priorityThreshold) {
              checkNullProblem = 0;
              return FlatButton(
                padding: const EdgeInsets.all(1),
                onPressed: () => showAlertDialog(),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  color: const Color.fromRGBO(255, 160, 89, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${systemProblems[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${systemProblems[pos].description}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(children: [
                        outputDifferenceHour(secondDifference),
                        Row(children: [
                          problemManualClose(),
                          problemAcknowledged(),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (problemPriority == 2 &&
                problemPriority >= priorityThreshold) {
              checkNullProblem = 0;
              return FlatButton(
                padding: const EdgeInsets.all(1),
                onPressed: () => showAlertDialog(),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  color: const Color.fromRGBO(255, 200, 89, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${systemProblems[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${systemProblems[pos].description}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(children: [
                        outputDifferenceHour(secondDifference),
                        Row(children: [
                          problemManualClose(),
                          problemAcknowledged(),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (problemPriority == 1 &&
                problemPriority >= priorityThreshold) {
              checkNullProblem = 0;
              return FlatButton(
                padding: const EdgeInsets.all(1),
                onPressed: () => showAlertDialog(),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  color: const Color.fromRGBO(66, 135, 245, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${systemProblems[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${systemProblems[pos].description}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(children: [
                        outputDifferenceHour(secondDifference),
                        Row(children: [
                          problemManualClose(),
                          problemAcknowledged(),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (problemPriority == 0 &&
                problemPriority >= priorityThreshold) {
              checkNullProblem = 0;
              return FlatButton(
                padding: const EdgeInsets.all(1),
                onPressed: () => showAlertDialog(),
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  color: const Color.fromRGBO(151, 170, 179, 1),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${systemProblems[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${systemProblems[pos].description}',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Column(children: [
                        outputDifferenceHour(secondDifference),
                        Row(children: [
                          problemManualClose(),
                          problemAcknowledged(),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            }
            return notFoundProblem(AppLocalizations.of(context)!.noProblem);
          }),
    );
  }

  void navigateToConfirmationProblem(
      BuildContext context, HostTriggerResultModel hostTriggerResult) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConfirmationProblemPage(
        title: hostTriggerResult.description,
        manual_close: hostTriggerResult.manual_close,
        eventid: hostTriggerResult.triggerLastEvent.eventid,
      );
    }));
  }
}
