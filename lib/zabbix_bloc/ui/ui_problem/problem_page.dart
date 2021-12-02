import 'dart:async';
import 'dart:convert';

import 'package:Zabbix/zabbix_bloc/ui/setting/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/problem_event_model/problem_event_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/problem_event_model/problem_event_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/problem_event_model/problem_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_graph/graph_detail_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_overview/overview_last_value_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_scripts/script_execute_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_system_status/system_status_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:Zabbix/zabbix_bloc/ui/setting/icon_menu.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_problem/problem_event.dart';

import 'confirmation_problem_page.dart';
import 'main_problems.dart';

class ProblemPage extends StatefulWidget {
  Future<List<ProblemEventResultModel>> problemEvent(
      problemEventRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? triggerid = localStorage.getString('triggerid');

    ProblemEventRequestModel problemEventRequestModel =
        ProblemEventRequestModel(auth_problem: '$auth', trigger: '$triggerid');

    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(problemEventRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ProblemEventResultModel> problemEventResult =
          (ProblemEventResponseModel.fromJson(data).problemEventResult);
      return problemEventResult;
    } else {
      throw Exception('');
    }
  }

  @override
  _ProblemPageState createState() => _ProblemPageState();
}

class _ProblemPageState extends State<ProblemPage> {
  bool isCheckedAutoRefresh = false;
  String autoRefresh = '';
  int _autoRefresh = 10;

  @override
  void initState() {
    super.initState();
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    autoRefresh = AutoRefreshPreferences.getAutoRefresh() ?? '10';
    isCheckedAutoRefresh =
        IsCheckedAutoRefreshPreferences.getIsCheckedAutoRefresh() ?? false;
    _autoRefresh = int.parse(autoRefresh);
    if (isCheckedAutoRefresh == true) {
      startTimer();
      Timer.periodic(Duration(seconds: int.parse(autoRefresh) + 1), (Timer t) {
        if (isCheckedAutoRefresh == true) {
          startTimer();
          zabbixBloc.add(ZabbixAllLoadEvent());
        } else {
          t.cancel();
        }
      });
    } else if (isCheckedAutoRefresh == false) {
      Timer.periodic(Duration(microseconds: 1), (Timer t) {
        t.cancel();
      });
    }
  }

  startTimer() {
    _autoRefresh = int.parse(autoRefresh);
    Timer.periodic(
        Duration(seconds: 1),
        (Timer t) => setState(() {
              if (_autoRefresh < 2) {
                t.cancel();
              } else {
                _autoRefresh -= 1;
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              alignment: Alignment.centerLeft,
              icon: Icon(Icons.people),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: Colors.black,
                        title: Container(
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.zabbixServers,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          color: Colors.black,
                        ),
                        content: setupAlertDialogContainer(context),
                      );
                    });
              },
            ),
            Container(
              alignment: Alignment.bottomLeft,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return MainProblemPage();
                  }));
                },
                child: Text(
                  AppLocalizations.of(context)!.problems,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            NavigationToSystemStatus(),
            IconMenu(),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            zabbixBloc.add(ZabbixProblemLoadEvent());
          });
        },
        child: Container(
            color: Colors.black,
            child: BlocConsumer(
              bloc: BlocProvider.of<ZabbixBloc>(context),
              listener: (context, state) {
                if (state is ZabbixLoginErrorState) {
                  Text(AppLocalizations.of(context)!.incorrectInputData);
                }
              },
              builder: (context, state) {
                if (state is ZabbixInitialState) {
                  zabbixBloc.add(ZabbixLoadEvent());
                } else if (state is ZabbixProblemLoadingState) {
                  return buildLoading();
                } else if (state is ZabbixAllLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixProblemLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixLoginLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixSettingLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixResolvedProblemLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixGraphLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixOverviewLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixSystemStatusLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixCheckProblemLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixScriptsLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixScriptDetailLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixHistoryOverviewLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixAllLoadedState) {
                  return buildProblemList(state.triggerResult);
                } else if (state is ZabbixProblemErrorState) {
                  return buildErrorUi(context, state.message);
                } else if (state is ZabbixLoginErrorState) {
                  return buildErrorUi(context, state.message);
                }
                return countServers() == 0
                    ? Container(
                        color: Colors.black,
                        child: Center(
                          child: Container(
                            color: Colors.blue,
                            height: 50,
                            width: 260,
                            margin: const EdgeInsets.all(10),
                            child: TextButton(
                              child: Column(children: [
                                Text(
                                  AppLocalizations.of(context)!
                                      .noAnyConfigurations,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  AppLocalizations.of(context)!.pleaseAddServer,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                              onPressed: () {
                                zabbixBloc.add(ZabbixSettingLoadEvent());
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SettingPage()),
                                );
                              },
                            ),
                          )))
                    : Container();
              },
            )),
      ),
      floatingActionButton: isCheckedAutoRefresh == false
          ? Container()
          : Container(
              height: 50,
              width: 50,
              child: Center(
                child: Text('$_autoRefresh'),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
            ),
    );
  }

  Widget setupAlertDialogContainer(context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    String listUrlApi = ListUrlApiPreferences.getListUrlApi() ?? '';
    int itemCounter = listUrlApi.split(', ').length;
    return Container(
      color: Colors.black,
      height: (50.0 * itemCounter),
      width: 50,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: itemCounter,
        itemBuilder: (ctx, pos) {
          title(int index) {
            String urlApi = ListUrlApiPreferences.getListUrlApi() ?? '';
            List urlList = urlApi.split(', ');
            if (urlList[index] != '') {
              String server = urlList[index]
                  .replaceAll('https://', '')
                  .replaceAll('/zabbix/api_jsonrpc.php', '');
              return '$server #${index + 1}';
            }
            return '';
          }

          active(int index) {
            int server = ListServerZabbixPreferences.getListServer() ?? 0;
            if (index == server) {
              return Container(
                width: 20,
                height: 20,
                color: Colors.green,
              );
            } else {
              return Container(
                width: 20,
                height: 20,
                color: Colors.red,
              );
            }
          }

          return TextButton(
            onPressed: () async {
              await ListServerZabbixPreferences.setListServer(pos);
              String listUrlApi = ListUrlApiPreferences.getListUrlApi() ?? '';
              String listUsername = ListUserPreferences.getListUsername() ?? '';
              String listPassword =
                  ListPasswordPreferences.getListPassword() ?? '';
              String selectPriorityProblem =
                  ListPriorityProblemsPreferences.getListPriorityProblems() ??
                      '';
              String selectPrioritySystemStatus =
                  ListPrioritySystemStatusPreferences
                          .getListPrioritySystemStatus() ??
                      '';
              int index = ListServerZabbixPreferences.getListServer() ?? 0;

              await UserPreferences.setUsername(
                  listUsername.split(', ')[index]);
              await UrlApiPreferences.setUrlApi(listUrlApi.split(', ')[index]);
              await PasswordPreferences.setPassword(
                  listPassword.split(', ')[index]);
              await SelectPriorityProblemsPreferences.setSelectPriorityProblems(
                  selectPriorityProblem.split(', ')[index]);
              await SelectPrioritySystemStatusPreferences
                  .setSelectPrioritySystemStatus(
                      selectPrioritySystemStatus.split(', ')[index]);

              zabbixBloc.add(ZabbixLoginLoadEvent());
              Navigator.pop(context);
            },
            child: Row(children: [
              active(pos),
              SizedBox(width: 5),
              Text(title(pos),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  )),
            ]),
          );
        },
      ),
    );
  }

  countServers() {
    String listUrlApi = ListUrlApiPreferences.getListUrlApi() ?? '';
    if (listUrlApi == '') {
      return 0;
    } else {
      return 1;
    }
  }


  Widget buildProblemList(List<TriggerResultModel> triggerResult) {
    var countNullProblem = 0;
    var checkNullProblem = 0;
    notFoundProblem(String str) {
      if (checkNullProblem == 0) {
        countNullProblem++;
        if (countNullProblem == triggerResult.length) {
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

    return ListView.builder(
        itemCount: triggerResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            // print(mainProblems.length);

            final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
            int problemPriority = int.parse(triggerResult[pos].priority);
            String selectPriority =
                SelectPriorityProblemsPreferences.getSelectPriorityProblems() ??
                    '0';
            int priorityThreshold = 0;
            if (selectPriority != '') {
              priorityThreshold = int.parse(selectPriority);
            }
            int server = ListServerZabbixPreferences.getListServer() ?? 0;

            saveData() async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString(
                  'hostid', triggerResult[pos].triggerHosts[0].hostid);
              localStorage.setString('triggerid', triggerResult[pos].triggerid);
            }

            problemManualClose() {
              if (triggerResult[pos].manual_close == '1') {
                return Text(
                  '[M]',
                  style: TextStyle(color: Colors.white),
                );
              } else {
                return Text('');
              }
            }

            problemAcknowledged() {
              if (triggerResult[pos].triggerLastEvent.acknowledged == '1') {
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
                int.parse(triggerResult[pos].triggerLastEvent.clock);
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
                int mouns = sec ~/ (86400 * 31);
                sec %= (86400 * 31);
                int day = sec ~/ (24 * 3600);
                sec %= (24 * 3600);
                int hour = sec ~/ 3600;
                sec %= 3600;
                int minutes = sec ~/ 60;
                sec %= 60;
                int second = sec;
                return Text(
                  '${mouns}m ${day}d ${hour}h',
                  style: TextStyle(color: Colors.white),
                );
              }
            }

            showAlertDialog() {
              return showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                      title: Text('${triggerResult[pos].triggerHosts[0].name}',
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.black,
                      content: Container(
                        color: Colors.black54,
                        height: 240,
                        child: Column(children: [
                          TextButton(
                            onPressed: () {
                              navigateToConfirmationProblem(
                                  context, triggerResult[pos]);
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
                                        title: triggerResult[pos].description)),
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
                                        title: triggerResult[pos]
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
                                        title: triggerResult[pos]
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
                                        title: triggerResult[pos]
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
              checkNullProblem = 1;
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
                              '${triggerResult[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${triggerResult[pos].description}',
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
                          Text('#${server + 1}',
                              style: TextStyle(color: Colors.white)),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            }
            if (problemPriority == 4 && problemPriority >= priorityThreshold) {
              checkNullProblem = 1;
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
                              '${triggerResult[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${triggerResult[pos].description}',
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
                          Text('#${server + 1}',
                              style: TextStyle(color: Colors.white)),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            }
            if (problemPriority == 3 && problemPriority >= priorityThreshold) {
              checkNullProblem = 1;
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
                              '${triggerResult[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${triggerResult[pos].description}',
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
                          Text('#${server + 1}',
                              style: TextStyle(color: Colors.white)),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (problemPriority == 2 &&
                problemPriority >= priorityThreshold) {
              checkNullProblem = 1;
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
                              '${triggerResult[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${triggerResult[pos].description}',
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
                          Text('#${server + 1}',
                              style: TextStyle(color: Colors.white)),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (problemPriority == 1 &&
                problemPriority >= priorityThreshold) {
              checkNullProblem = 1;
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
                              '${triggerResult[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${triggerResult[pos].description}',
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
                          Text('#${server + 1}',
                              style: TextStyle(color: Colors.white)),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            } else if (problemPriority == 0 &&
                problemPriority >= priorityThreshold) {
              checkNullProblem = 1;
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
                              '${triggerResult[pos].triggerHosts[0].name}',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '${triggerResult[pos].description}',
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
                          Text('#${server + 1}',
                              style: TextStyle(color: Colors.white)),
                        ]),
                      ]),
                    ],
                  ),
                ),
              );
            }
            return notFoundProblem(AppLocalizations.of(context)!.noProblem);
          });
        });
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(BuildContext context, String message) {
    errorMessage() {
      if (message == 'failed') {
        return AppLocalizations.of(context)!.incorrectUrl;
      } else if (message ==
          "type 'Null' is not a subtype of type 'String' in type cast") {
        return AppLocalizations.of(context)!.incorrectLogin;
      } else {
        return AppLocalizations.of(context)!.noConnection;
      }
    }

    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            errorMessage(),
            style: TextStyle(color: Colors.red),
          ),
        ),
      ),
    );
  }

  void navigateToProblemEvent(
      BuildContext context, TriggerResultModel triggerResult) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ProblemEventPage(
        title: triggerResult.description,
      );
    }));
  }

  void navigateToConfirmationProblem(
      BuildContext context, TriggerResultModel triggerResult) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ConfirmationProblemPage(
        title: triggerResult.description,
        manual_close: triggerResult.manual_close,
        eventid: triggerResult.triggerLastEvent.eventid,
      );
    }));
  }
}

class NavigationToSystemStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return Container(
      child: FlatButton(
        child: Text(
          AppLocalizations.of(context)!.systemStatus,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        onPressed: () {
          zabbixBloc.add(ZabbixSystemStatusLoadEvent());
          navigateToSystemStatus(context);
        },
      ),
    );
  }

  void navigateToSystemStatus(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return SystemStatusPage();
    }));
  }
}
