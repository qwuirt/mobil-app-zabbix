import 'dart:convert';

import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_execute_model/script_execute_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_execute_model/script_execute_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_execute_model/script_execute_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_model/script_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScriptsExecutePage extends StatelessWidget {
  String title;

  ScriptsExecutePage({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(title),
      ),
      body: Container(
        color: Colors.black54,
        child: BlocListener<ZabbixBloc, ZabbixState>(
          listener: (context, state) {
            if (state is ZabbixScriptsErrorState) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      ''),
                ),
              );
            }
          },
          child: BlocBuilder<ZabbixBloc, ZabbixState>(
            builder: (context, state) {
              if (state is ZabbixInitialState) {
                return buildLoading();
              } else if (state is ZabbixScriptDetailLoadingState) {
                return buildLoading();
              } else if (state is ZabbixScriptDetailLoadedState) {
                return buildGraphList(state.scriptResult);
              } else if (state is ZabbixScriptExecuteLoadedState) {
                return buildGraphList(state.scriptResult);
              } else if (state is ZabbixScriptDetailErrorState) {
                return buildErrorUi(context, state.message);
              }
              ;
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildGraphList(List<ScriptResultModel> scriptResult) {
    return ListView.builder(
        itemCount: scriptResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
            saveData() async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString(
                  'scriptid_execute', scriptResult[pos].scriptid);
            }

            return Container(
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              color: Colors.black54,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${scriptResult[pos].name}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                onPressed: () => showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                        title: Text(
                            '${AppLocalizations.of(context)!.runScript}: \n${scriptResult[pos].name}',
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.black54,
                        content: Container(
                          color: Colors.black54,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.red,
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(AppLocalizations.of(context)!.cancel,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(2),
                                  color: Colors.green,
                                  child: TextButton(
                                    onPressed: () {
                                      saveData();
                                      zabbixBloc
                                          .add(ZabbixScriptExecuteLoadEvent());
                                      Navigator.pop(context);
                                      navigateToExecuteResponse(
                                          context, scriptResult[pos]);
                                    },
                                    child: Text(AppLocalizations.of(context)!.perform,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        )),
                                  ),
                                ),
                              ]),
                        ))),
              ),
            );
          });
        });
  }

  Future<List<ScriptExecuteResultModel>> scriptExecute(
      scriptExecuteRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? hostid = localStorage.getString('hostid');
    String? scriptid = localStorage.getString('scriptid_execute');

    ScriptExecuteRequestModel scriptExecuteRequestModel =
        ScriptExecuteRequestModel(
            hostids: '$hostid', auth_script: '$auth', scriptid: '$scriptid');
    Uri url = Uri.parse('${apiUrl}');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(scriptExecuteRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ScriptExecuteResultModel> scriptExecuteResult =
          (ScriptExecuteResponseModel.fromJson(data).scriptExecuteResult);
      return scriptExecuteResult;
    } else {
      throw Exception('');
    }
  }

  void navigateToExecuteResponse(
      BuildContext context, ScriptResultModel scriptResult) {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => ScriptsResponseExecute(
        title: scriptResult.name,
      ),
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
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
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

class ScriptsResponseExecute extends StatelessWidget {
  String title;

  ScriptsResponseExecute({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return AlertDialog(
      title: Text(title, style: TextStyle(color: Colors.white)),
      backgroundColor: Colors.black,
      content: Container(
        width: 240,
        height: 100,
        child: BlocListener<ZabbixBloc, ZabbixState>(
          listener: (context, state) {
            if (state is ZabbixScriptExecuteErrorState) {
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
              } else if (state is ZabbixScriptsLoadingState) {
                return buildLoading();
              } else if (state is ZabbixScriptExecuteLoadedState) {
                return buildGraphList(state.scriptExecuteResult);
              } else if (state is ZabbixScriptExecuteErrorState) {
                zabbixBloc
                    .add(ZabbixScriptExecuteErrorLoadEvent());
                return buildErrorUi(context, AppLocalizations.of(context)!.noConnection);
              }
              ;
              return Container();
            },
          ),
        ),
      ),
    );
  }
}

Widget buildGraphList(List<ScriptExecuteResultModel> scriptExecuteResult) {
  return ListView.builder(
      itemCount: scriptExecuteResult.length,
      itemBuilder: (ctx, pos) {
        return BlocBuilder<ZabbixBloc, ZabbixState>(builder: (context, state) {
          if (scriptExecuteResult[pos].response == 'success') {
            return  Column(
                children: [
                  Icon(
                    Icons.assignment_turned_in,
                    color: Colors.green,
                  ),
                  Text(AppLocalizations.of(context)!.scriptCompleted,
                      style: TextStyle(color: Colors.white)),
                ],
              );
          } else {
            return Column(
                children: [
                  Icon(
                    Icons.clear,
                    color: Colors.red,
                  ),
                  Text(AppLocalizations.of(context)!.scriptNotExecuted,
                      style: TextStyle(color: Colors.white)),
                ],
            );
          }
          return Container();
        });
      });
}

Widget buildLoading() {
  return Center(
    child: CircularProgressIndicator(),
  );
}

Widget buildErrorUi(BuildContext context, String message) {
  final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
  return Center(
      child: Column (
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
        TextButton(
          onPressed: () {
            zabbixBloc.add(ZabbixScriptDetailLoadEvent());
            Navigator.of(context).pop();
          },
          child: Text('OK', style: TextStyle(color: Colors.white70),),
        ),
    ]),
  );
}
