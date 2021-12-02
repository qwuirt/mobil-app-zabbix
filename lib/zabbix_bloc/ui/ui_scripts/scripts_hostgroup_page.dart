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
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_host_model/scripts_host_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_host_model/scripts_host_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_host_model/scripts_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_hostgroup_request_model.dart/scripts_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_scripts/scripts_host_page.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() => runApp(ScriptsHostgroupPage());

class ScriptsHostgroupPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(AppLocalizations.of(context)!.scripts),
        ),
        body: Container(
          color: Colors.black54,
          child: BlocListener<ZabbixBloc, ZabbixState>(
            listener: (context, state) {
              if (state is ZabbixScriptsErrorState) {
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
                } else if (state is ZabbixScriptsLoadedState) {
                  return buildScriptList(state.scriptsHostgroupResult);
                } else if (state is ZabbixAllLoadedState) {
                  return buildScriptList(state.scriptsHostgroupResult);
                } else if (state is ZabbixScriptDetailLoadedState) {
                  return buildScriptList(state.scriptsHostgroupResult);
                } else if (state is ZabbixScriptExecuteLoadedState) {
                  return buildScriptList(state.scriptsHostgroupResult);
                } else if (state is ZabbixScriptsErrorState) {
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

  Widget buildScriptList(
      List<ScriptsHostgroupResultModel> scriptsHostgroupResult) {
    return ListView.builder(
        itemCount: scriptsHostgroupResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
                final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
                saveData() async {
                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                  localStorage.setString('groupid', scriptsHostgroupResult[pos].groupid);
                }
                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                  color: Colors.black54,
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${scriptsHostgroupResult[pos].name}',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    onPressed: () {
                      saveData();
                      zabbixBloc.add(ZabbixScriptsLoadEvent());
                      navigateToHost(context, scriptsHostgroupResult[pos]);
                    },
                  ),
                );
              });
        });
  }

  Future<List<ScriptsHostResultModel>> scriptsHost(
      scriptsHostRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? groupid = localStorage.getString('groupid');

    ScriptsHostRequestModel scriptsHostRequestModel =
    ScriptsHostRequestModel(
        groupids: '${groupid}', auth_host: '${auth}');
    Uri url = Uri.parse('${apiUrl}');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(scriptsHostRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ScriptsHostResultModel> scriptsHostResult =
      (ScriptsHostResponseModel.fromJson(data).scriptsHostResult);
      return scriptsHostResult;
    } else {
      throw Exception('');
    }
  }

  void navigateToHost(
      BuildContext context, ScriptsHostgroupResultModel scriptsHostgroupResult) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ScriptsHostPage(
        title: scriptsHostgroupResult.name,
      );
    }));
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
