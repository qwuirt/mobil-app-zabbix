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
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/garaph_hostgroup_model/graph_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_host_model/graph_host_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_host_model/graph_host_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_host_model/graph_host_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'graph_host_page.dart';

void main() => runApp(GraphsHostgroupPage());

class GraphsHostgroupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(AppLocalizations.of(context)!.graphs),
        ),
        body: Container(
          color: Colors.black54,
          child: BlocConsumer(
            bloc: BlocProvider.of<ZabbixBloc>(context),
            listener: (context, state) {
              if (state is ZabbixGraphErrorState) {
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text(''),
                  ),
                );
              } 
            },
            builder: (context, state) {
              if (state is ZabbixInitialState) {
                return buildLoading();
              } else if (state is ZabbixGraphLoadingState) {
                return buildLoading();
              } else if (state is ZabbixAllLoadedState) {
                return buildGraphList(state.graphHostgroupResult);
              } else if (state is ZabbixGraphLoadedState) {
                return buildGraphList(state.graphHostgroupResult);
              } else if (state is ZabbixGraphErrorState) {
                return buildErrorUi(context, state.message);
              }
              return Container();
            },
          ),
        ),
    );
  }

  Widget buildGraphList(List<GraphHostgroupResultModel> graphHostgroupResult) {
    return ListView.builder(
        itemCount: graphHostgroupResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
            saveData() async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString(
                  'groupid', graphHostgroupResult[pos].groupid);
            }

            return Container(
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              color: Colors.black54,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${graphHostgroupResult[pos].name}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                onPressed: () {
                  saveData();
                  zabbixBloc.add(ZabbixGraphLoadEvent());
                  navigateToHost(context, graphHostgroupResult[pos]);
                },
              ),
            );
          });
        });
  }

  Future<List<GraphHostResultModel>> graphHost(graphHostRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? groupid = localStorage.getString('groupid');

    GraphHostRequestModel graphHostRequestModel = GraphHostRequestModel(
        groupids: '$groupid', auth_host_graph: '$auth');

    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(graphHostRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<GraphHostResultModel> graphHostResult =
          (GraphHostResponseModel.fromJson(data).graphHostResult);
      return graphHostResult;
    } else {
      throw Exception('');
    }
  }

  void navigateToHost(
      BuildContext context, GraphHostgroupResultModel graphHostgroupResult) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return GraphHostPage(
        title: graphHostgroupResult.name,
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
