import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/host_trigger_model/host_trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'detail_problem_page.dart';

void main() => runApp(SystemStatusPage());

class SystemStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(AppLocalizations.of(context)!.systemStatus),
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
                } else if (state is ZabbixSystemStatusLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixLoginLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixCheckProblemLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixOverviewLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixHistoryOverviewLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixGraphLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixScriptsLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixScriptDetailLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixScriptExecuteLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
                } else if (state is ZabbixAllLoadedState) {
                  return buildSystemStatusList(
                      state.hostgroupResult, state.hostTriggerResult);
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

  Widget buildSystemStatusList(List<HostgroupResultModel> hostgroupResult,
      List<HostTriggerResultModel> hostTriggerResult) {
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(children: <Widget>[
        // Row(children: [
        //   Expanded(child: Container(child: Text('Групи Хостів')),),
        //   Expanded(child: Container(child: Text('Надзвичайна')),),
        //   Expanded(child: Container(child: Text('Висока')),),
        //   Expanded(child: Container(child: Text('Середня')),),
        //   Expanded(child: Container(child: Text('Попередження')),),
        //   Expanded(child: Container(child: Text('Інформація')),),
        //   Expanded(child: Container(child: Text('Не класифікована')),),
        // ]),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: hostgroupResult.length,
            itemBuilder: (ctx, pos) {
              return BlocBuilder<ZabbixBloc, ZabbixState>(
                  builder: (context, state) {
                final ZabbixBloc zabbixBloc =
                    BlocProvider.of<ZabbixBloc>(context);

                countNotClassifiedProblem(String str) {
                  List listProblem = hostTriggerResult
                      .where((item) => item.priority == '0')
                      .toList();
                  int count = 0;
                  for (var i in listProblem) {
                    for (var j in i.triggerGroups) {
                      if (j.groupid == str) {
                        count++;
                      }
                    }
                  }
                  return count;
                }

                Widget outputNotClassifiedProblem() {
                  int? countProblem =
                      countNotClassifiedProblem(hostgroupResult[pos].groupid);
                  if (countProblem == 0) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: const Color.fromRGBO(151, 170, 179, 1),
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '$countProblem',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }

                countInfoProblem(String str) {
                  List listProblem = hostTriggerResult
                      .where((item) => item.priority == '1')
                      .toList();
                  int count = 0;
                  for (var i in listProblem) {
                    for (var j in i.triggerGroups) {
                      if (j.groupid == str) {
                        count++;
                      }
                    }
                  }
                  return count;
                }

                Widget outputInfoProblem() {
                  int? countProblem =
                      countInfoProblem(hostgroupResult[pos].groupid);
                  if (countProblem == 0) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: const Color.fromRGBO(66, 135, 245, 1),
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '$countProblem',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }

                countWarningProblem(String str) {
                  List listProblem = hostTriggerResult
                      .where((item) => item.priority == '2')
                      .toList();
                  int count = 0;
                  for (var i in listProblem) {
                    for (var j in i.triggerGroups) {
                      if (j.groupid == str) {
                        count++;
                      }
                    }
                  }
                  return count;
                }

                Widget outputWarningProblem() {
                  int? countProblem =
                      countWarningProblem(hostgroupResult[pos].groupid);
                  if (countProblem == 0) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: const Color.fromRGBO(255, 200, 89, 1),
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '$countProblem',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }

                countAverageProblem(String str) {
                  List listProblem = hostTriggerResult
                      .where((item) => item.priority == '3')
                      .toList();
                  int count = 0;
                  for (var i in listProblem) {
                    for (var j in i.triggerGroups) {
                      if (j.groupid == str) {
                        count++;
                      }
                    }
                  }
                  return count;
                }

                Widget outputAverageProblem() {
                  int? countProblem =
                      countAverageProblem(hostgroupResult[pos].groupid);
                  if (countProblem == 0) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: Color.fromRGBO(255, 160, 89, 1.0),
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '$countProblem',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }

                countHighProblem(String str) {
                  List listProblem = hostTriggerResult
                      .where((item) => item.priority == '4')
                      .toList();
                  int count = 0;
                  for (var i in listProblem) {
                    for (var j in i.triggerGroups) {
                      if (j.groupid == str) {
                        count++;
                      }
                    }
                  }
                  return count;
                }

                Widget outputHighProblem() {
                  int? countProblem =
                      countHighProblem(hostgroupResult[pos].groupid);
                  if (countProblem == 0) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: const Color.fromRGBO(233, 118, 89, 1),
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '$countProblem',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }

                countEmergencyProblem(String str) {
                  List listProblem = hostTriggerResult
                      .where((item) => item.priority == '5')
                      .toList();
                  int count = 0;
                  for (var i in listProblem) {
                    for (var j in i.triggerGroups) {
                      if (j.groupid == str) {
                        count++;
                      }
                    }
                  }
                  return count;
                }

                Widget outputEmergencyProblem() {
                  int? countProblem =
                      countEmergencyProblem(hostgroupResult[pos].groupid);
                  if (countProblem == 0) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '0',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  } else {
                    return Container(
                      color: const Color.fromRGBO(255, 0, 0, 1),
                      padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                      margin: EdgeInsets.all(1),
                      child: Text(
                        '${countEmergencyProblem(hostgroupResult[pos].groupid)}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                }

                navigateToDetailProblem(String str) {
                  List listProblem = hostTriggerResult
                      .where((item) => item.triggerGroups.isNotEmpty)
                      .toList();
                  List listGroup = [];
                  listGroup.clear();
                  for (var i in listProblem) {
                    for (var j in i.triggerGroups) {
                      if (j.groupid == str) {
                        listGroup.add(i);
                      }
                    }
                  }
                  return Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return SystemDetailProblemPage(
                      title: hostgroupResult[pos].name,
                      systemProblems: listGroup,
                    );
                  }));
                }

                return SizedBox(
                  height: 30,
                  child: FlatButton(
                    color: Colors.black54,
                    onPressed: () {
                      zabbixBloc.add(ZabbixSystemStatusLoadEvent());
                      navigateToDetailProblem(hostgroupResult[pos].groupid);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${hostgroupResult[pos].name}',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              outputEmergencyProblem(),
                              outputHighProblem(),
                              outputAverageProblem(),
                              outputWarningProblem(),
                              outputInfoProblem(),
                              outputNotClassifiedProblem(),
                            ]),
                      ],
                    ),
                  ),
                );
              });
            }),
      ]),
    );
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
}
