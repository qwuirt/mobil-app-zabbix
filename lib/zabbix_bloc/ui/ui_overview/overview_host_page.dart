import 'dart:convert';
import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_host_model/overview_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_item_model/overview_item_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_item_model/overview_item_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_item_model/overview_item_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'overview_last_value_page.dart';

class OverviewHostPage extends StatelessWidget {
  String title;
  OverviewHostPage({
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
            if (state is ZabbixOverviewErrorState) {
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
              } else if (state is ZabbixOverviewLoadingState) {
                return buildLoading();
              } else if (state is ZabbixAllLoadedState) {
                return buildHostDetailList(state.overviewHostResult);
              } else if (state is ZabbixOverviewLoadedState) {
                return buildHostDetailList(state.overviewHostResult);
              } else if (state is ZabbixHistoryOverviewLoadedState) {
                return buildHostDetailList(state.overviewHostResult);
              } else if (state is ZabbixOverviewErrorState) {
                return buildErrorUi(context, state.message);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildHostDetailList(List<OverviewHostResultModel> overviewHostResult) {
    return ListView.builder(
        itemCount: overviewHostResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
            saveDataItem() async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString(
                  'hostid', overviewHostResult[pos].hostid);
            }

            return Container(
              margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
              color: Colors.black54,
              alignment: Alignment.centerLeft,
              child: TextButton(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '${overviewHostResult[pos].name}',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
                onPressed: () {
                  saveDataItem();
                  zabbixBloc.add(ZabbixOverviewLoadEvent());
                  navigateToLastValue(context, overviewHostResult[pos]);
                },
              ),
            );
          });
        });
  }

  Future<List<OverviewItemResultModel>> overviewItem(
      overviewItemRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? hostid = localStorage.getString('hostid');

    OverviewItemRequestModel overviewItemRequestModel =
        OverviewItemRequestModel(
            hostids: '$hostid', auth_overview: '$auth');
    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(overviewItemRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<OverviewItemResultModel> overviewItemResult =
          (OverviewItemResponseModel.fromJson(data).overviewItemResult);
      return overviewItemResult;
    } else {
      throw Exception('');
    }
  }

  void navigateToLastValue(
      BuildContext context, OverviewHostResultModel overviewHostResult) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OverviewLastValuePage(
        title: overviewHostResult.name,
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
