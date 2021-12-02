// TODO Implement this library.import 'dart:convert';

import 'dart:convert';

import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_host_model/overview_host_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_host_model/overview_host_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_host_model/overview_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_hostgroup_request_model/overview_hostgroup_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'overview_host_page.dart';

void main() => runApp(OverviewHostgroupPage());

class OverviewHostgroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(AppLocalizations.of(context)!.overview),
        ),
        body: Container(
          color: Colors.black54,
          child: BlocListener<ZabbixBloc, ZabbixState>(
            listener: (context, state) {
              if (state is ZabbixOverviewErrorState) {
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
                } else if (state is ZabbixOverviewLoadingState) {
                  return buildLoading();
                } else if (state is ZabbixAllLoadedState) {
                  return buildGraphList(state.overviewHostgroupResult);
                } else if (state is ZabbixOverviewLoadedState) {
                  return buildGraphList(state.overviewHostgroupResult);
                } else if (state is ZabbixHistoryOverviewLoadedState) {
                  return buildGraphList(state.overviewHostgroupResult);
                } else if (state is ZabbixOverviewErrorState) {
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

  Widget buildGraphList(
      List<OverviewHostgroupResultModel> overviewHostgroupResult) {
    return ListView.builder(
        itemCount: overviewHostgroupResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
            saveDataHostid() async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString(
                  'groupid', overviewHostgroupResult[pos].groupid);
            }

            return Container(
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              color: Colors.black54,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  '${overviewHostgroupResult[pos].name}',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
                ),
                onPressed: () {
                  saveDataHostid();
                  zabbixBloc.add(ZabbixOverviewLoadEvent());
                  navigateToHost(context, overviewHostgroupResult[pos]);
                },
              ),
            );
          });
        });
  }

  Future<List<OverviewHostResultModel>> overviewHost(
      overviewHostRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? groupid = localStorage.getString('groupid');

    OverviewHostRequestModel overviewHostRequestModel =
        OverviewHostRequestModel(
            groupids: '${groupid}', auth_host_overview: '${auth}');
    Uri url = Uri.parse('${apiUrl}');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(overviewHostRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<OverviewHostResultModel> overviewHostResult =
          (OverviewHostResponseModel.fromJson(data).overviewHostResult);
      return overviewHostResult;
    } else {
      throw Exception('');
    }
  }

  void navigateToHost(BuildContext context,
      OverviewHostgroupResultModel overviewHostgroupResult) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OverviewHostPage(
        title: overviewHostgroupResult.name,
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
