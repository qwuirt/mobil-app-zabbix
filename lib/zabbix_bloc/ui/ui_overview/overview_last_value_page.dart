import 'dart:convert';
import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/item_history_model/item_history_request.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/item_history_model/item_history_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/item_history_model/item_history_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_item_model/overview_item_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'overview_history_page.dart';
import 'overview_image_page.dart';

class OverviewLastValuePage extends StatelessWidget {
  String title;

  OverviewLastValuePage({
    required this.title,
  });

  @override
  Widget build(context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('$title'),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            zabbixBloc.add(ZabbixOverviewLoadEvent());
          });
        },
        child: Container(
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
                } else if (state is ZabbixOverviewLoadedState) {
                  return buildHostDetailList(state.overviewItemResult);
                } else if (state is ZabbixHistoryOverviewLoadedState) {
                  return buildHostDetailList(state.overviewItemResult);
                } else if (state is ZabbixOverviewErrorState) {
                  return buildErrorUi(context, state.message);
                }
                ;
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHostDetailList(List<OverviewItemResultModel> overviewItemResult) {
    return ListView.builder(
        itemCount: overviewItemResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
            saveData() async {
              SharedPreferences localStorage =
                  await SharedPreferences.getInstance();
              localStorage.setString('itemid', overviewItemResult[pos].itemid);
              localStorage.setString(
                  'value_type', overviewItemResult[pos].value_type);
              localStorage.setInt('time_from',
                  (DateTime.now().millisecondsSinceEpoch - 3600000) ~/ 1000);
            }

            if (overviewItemResult[pos].value_type == '0') {
              var lastvalue = num.parse(overviewItemResult[pos].lastvalue);
              var output = num.parse(lastvalue.toStringAsFixed(2));
              return SizedBox(
                height: 20,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                  child: FlatButton(
                    color: Colors.black54,
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                            title: Text('${overviewItemResult[pos].name}',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.black,
                            content: Container(
                              color: Colors.black54,
                              height: 100,
                              child: Column(children: [
                                TextButton(
                                  onPressed: () {
                                    navigateToOverviewImage(
                                        context, overviewItemResult[pos]);
                                  },
                                  child: Text(AppLocalizations.of(context)!.graph,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    saveData();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                    navigateToItemHistory(
                                        context, overviewItemResult[pos]);
                                  },
                                  child: Text(AppLocalizations.of(context)!.history,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                              ]),
                            ))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${overviewItemResult[pos].name}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          Row(children: [
                            Text(
                              '${output}',
                              maxLines: 3,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              '${overviewItemResult[pos].units}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ]),
                        ]),
                  ),
                ),
              );
            } else if (overviewItemResult[pos].value_type == '3') {
              return SizedBox(
                height: 20,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                  child: FlatButton(
                    color: Colors.black54,
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                            title: Text('${overviewItemResult[pos].name}',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.black,
                            content: Container(
                              color: Colors.black54,
                              height: 100,
                              child: Column(children: [
                                TextButton(
                                  onPressed: () {
                                    navigateToOverviewImage(
                                        context, overviewItemResult[pos]);
                                  },
                                  child: Text(AppLocalizations.of(context)!.graph,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    saveData();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                    navigateToItemHistory(
                                        context, overviewItemResult[pos]);
                                  },
                                  child: Text(AppLocalizations.of(context)!.history,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                              ]),
                            ))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${overviewItemResult[pos].name}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          Row(children: [
                            Text(
                              '${overviewItemResult[pos].lastvalue}',
                              maxLines: 3,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Text(
                              '${overviewItemResult[pos].units}',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ]),
                        ]),
                  ),
                ),
              );
            } else {
              return  Container(
                color: Colors.black54,
                  margin: const EdgeInsets.fromLTRB(0, 1, 0, 1),
                  child:  TextButton(
                    style: TextButton.styleFrom(
                        padding: EdgeInsets.zero),
                    onPressed: () => showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                            title: Text('${overviewItemResult[pos].name}',
                                style: TextStyle(color: Colors.white)),
                            backgroundColor: Colors.black,
                            content: Container(
                              color: Colors.black54,
                              height: 100,
                              child: Column(children: [
                                TextButton(
                                  onPressed: () {
                                    navigateToOverviewImage(
                                        context, overviewItemResult[pos]);
                                  },
                                  child:  Text(AppLocalizations.of(context)!.graph,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    saveData();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                    navigateToItemHistory(
                                        context, overviewItemResult[pos]);
                                  },
                                  child: Text(AppLocalizations.of(context)!.history,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                              ]),
                            ))),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${overviewItemResult[pos].name}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Row(children: [
                              Expanded(
                                child: Container(
                                  child: Text(
                                    '${overviewItemResult[pos].lastvalue}',
                                    maxLines: 3,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                              Text(
                                '${overviewItemResult[pos].units}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ]),
                          ),
                        ]),
                  ),
              );
            }
          });
        });
  }

  Future<List<ItemHistoryResultModel>> overviewItemHistory(
      itemHistoryRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? history = localStorage.getString('value_type');
    String? itemid = localStorage.getString('itemid');
    int? time_from = localStorage.getInt('time_from');

    ItemHistoryRequestModel itemHistoryRequestModel = ItemHistoryRequestModel(
        history: '$history',
        auth: '$auth',
        itemid: '$itemid',
        time_from: '$time_from');
    Uri url = Uri.parse('${apiUrl}');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(itemHistoryRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ItemHistoryResultModel> itemHistoryResult =
          (ItemHistoryResponseModel.fromJson(data).itemHistoryResult);
      return itemHistoryResult;
    } else {
      throw Exception('');
    }
  }

  void navigateToOverviewImage(
      BuildContext context, OverviewItemResultModel overviewItemResult) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return OverviewImagePage(
        itemid: overviewItemResult.itemid,
        urlApi: '${UrlApiPreferences.getUrlApi()}',
        authImage: '${localStorage.getString('auth')}',
      );
    }));
  }

  void navigateToItemHistory(
      BuildContext context, OverviewItemResultModel overviewItemResult) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ItemHistoryPage(
        title: overviewItemResult.name,
        units: overviewItemResult.units,
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
