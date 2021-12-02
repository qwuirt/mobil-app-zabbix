import 'dart:convert';

import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/check_problem_event_model/check_problem_event_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/check_problem_event_model/check_problem_event_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/check_problem_event_model/check_problem_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/problem_event_model/problem_event_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProblemEventPage extends StatelessWidget {
  String title;

  ProblemEventPage({
    required this.title,
  });

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title),
      ),
      body: Container(
        color: Colors.black54,
        child: BlocListener<ZabbixBloc, ZabbixState>(
          listener: (context, state) {
            if (state is ZabbixProblemErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ZabbixBloc, ZabbixState>(
            builder: (context, state) {
              if (state is ZabbixInitialState) {
                return buildLoading();
              } else if (state is ZabbixProblemLoadingState) {
                return buildLoading();
              } else if (state is ZabbixProblemLoadedState) {
                return buildProblemEventList(state.problemEventResult);
              } else if (state is ZabbixAllLoadedState) {
                return buildProblemEventList(state.problemEventResult);
              } else if (state is ZabbixCheckProblemLoadedState) {
                return buildProblemEventList(state.problemEventResult);
              } else if (state is ZabbixProblemErrorState) {
                return buildErrorUi(context, state.message);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildProblemEventList(
      List<ProblemEventResultModel> problemEventResult) {
    return ListView.builder(
        itemCount: problemEventResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
            int dateFromJsonInt = int.parse(problemEventResult[pos].clock);
            var dateProblem = DateFormat.yMd().add_Hms().format(
                DateTime.fromMillisecondsSinceEpoch(dateFromJsonInt * 1000));
            saveData() async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString(
                  'eventid', problemEventResult[pos].eventid);
            }

            problemAcknowledged() {
              if (problemEventResult[pos].acknowledged == '1') {
                return Text('[A]', style: TextStyle(color: Colors.white),);
              } else {
                return Text('');
              }
            }

            problemAcknowledges() {
              if (problemEventResult[pos].acknowledges.isNotEmpty) {
                return Text('[C]', style: TextStyle(color: Colors.white),);
              } else {
                return Text('');
              }
            }

            if (problemEventResult[pos].value == '1') {
              return FlatButton(
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                onPressed: () {
                  saveData();
                  zabbixBloc.add(ZabbixCheckProblemLoadEvent());
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        CheckProblemEventDialog(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.problem,
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$dateProblem',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            alignment:  Alignment.topCenter,
                            child: Row(children: [
                              problemAcknowledged(),
                              problemAcknowledges(),
                            ]),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
              );
            } else if (problemEventResult[pos].value == '0') {
              return FlatButton(
                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                onPressed: () {
                  saveData();
                  zabbixBloc.add(ZabbixCheckProblemLoadEvent());
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) =>
                        CheckProblemEventDialog(),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, bottom: 5, top: 5),
                  color: Colors.green,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.ok,
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    '$dateProblem',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                alignment:  Alignment.topCenter,
                                child: Row(children: [
                                  problemAcknowledged(),
                                  problemAcknowledges(),
                                ]),
                              ),
                            ]),
                      ),
                    ],
                  ),
                ),
              );
            }
            return Container();
          });
        });
  }

  Future<List<CheckProblemEventResultModel>> checkProblemEvent(
      checkProblemEventRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? eventid = localStorage.getString('eventid');
    CheckProblemEventRequestModel checkProblemEventRequestModel =
        CheckProblemEventRequestModel(
            eventids: '$eventid', auth_problem: '$auth');
    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(checkProblemEventRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<CheckProblemEventResultModel> checkProblemEventResult =
          (CheckProblemEventResponseModel.fromJson(data)
              .checkProblemEventResult);
      return checkProblemEventResult;
    } else {
      throw Exception('');
    }
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

class CheckProblemEventDialog extends StatelessWidget {
  @override
  Widget build(context) {
    return AlertDialog(
      backgroundColor: Colors.black54,
      content: Container(
        width: 240,
        height: 100,
        child: BlocListener<ZabbixBloc, ZabbixState>(
          listener: (context, state) {
            if (state is ZabbixCheckProblemErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          child: BlocBuilder<ZabbixBloc, ZabbixState>(
            builder: (context, state) {
              if (state is ZabbixInitialState) {
                return buildLoading();
              } else if (state is ZabbixCheckProblemLoadingState) {
                return buildLoading();
              } else if (state is ZabbixAllLoadedState) {
                return buildProblemEventList(state.checkProblemEventResult);
              } else if (state is ZabbixCheckProblemLoadedState) {
                return buildProblemEventList(state.checkProblemEventResult);
              } else if (state is ZabbixCheckProblemErrorState) {
                return buildErrorUi(context, state.message);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildProblemEventList(
      List<CheckProblemEventResultModel> checkProblemEventResult) {
    return ListView.builder(
        itemCount: checkProblemEventResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            if (checkProblemEventResult[pos].checkProblemAcknowledges.isEmpty) {
              return TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                },
                child: Text(AppLocalizations.of(context)!.ok,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              );
            } else {
              int dateFromJsonInt = int.parse(checkProblemEventResult[pos]
                  .checkProblemAcknowledges[0]
                  .clock);
              var dateProblem = DateFormat.yMd().add_Hms().format(
                  DateTime.fromMillisecondsSinceEpoch(dateFromJsonInt * 1000));
              return Column(children: [
                Text(
                  '${checkProblemEventResult[pos].checkProblemAcknowledges[0].alias}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '${checkProblemEventResult[pos].checkProblemAcknowledges[0].message}',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  '$dateProblem',
                  style: TextStyle(color: Colors.white),
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Text(AppLocalizations.of(context)!.ok,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        )),
                  ),
                ),
              ]);
            }
          });
        });
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(color: Colors.green),
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
