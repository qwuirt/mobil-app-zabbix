import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/item_history_model/item_history_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ItemHistoryPage extends StatelessWidget {
  String title;
  String units;

  ItemHistoryPage({
    required this.title,
    required this.units,
  });

  @override
  Widget build(context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);

    fiveMinutes() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('time_from',
          (DateTime.now().millisecondsSinceEpoch - 300000) ~/ 1000);
    }

    fifteenMinutes() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('time_from',
          (DateTime.now().millisecondsSinceEpoch - 900000) ~/ 1000);
    }

    thirtyMinutes() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('time_from',
          (DateTime.now().millisecondsSinceEpoch - 1800000) ~/ 1000);
    }

    oneHour() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('time_from',
          (DateTime.now().millisecondsSinceEpoch - 3600000) ~/ 1000);
    }

    twoHour() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('time_from',
          (DateTime.now().millisecondsSinceEpoch - 7200000) ~/ 1000);
    }

    threeHour() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('time_from',
          (DateTime.now().millisecondsSinceEpoch - 10800000) ~/ 1000);
    }

    sexHour() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('time_from',
          (DateTime.now().millisecondsSinceEpoch - 21600000) ~/ 1000);
    }

    twelveHour() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setInt('time_from',
          (DateTime.now().millisecondsSinceEpoch - 43200000) ~/ 1000);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            flex: 2,
            child: Text('$title'),
          ),
          Center(
            child: IconButton(
              icon: Icon(
                Icons.view_list,
                color: Colors.white,
                size: 30.0,
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      color: Colors.black,
                      height: 400,
                      child: DropdownMenuItem(
                        child: Container(
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    fiveMinutes();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                  },
                                  child: Text('5 ${AppLocalizations.of(context)!.minutes}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    fifteenMinutes();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                  },
                                  child: Text('15 ${AppLocalizations.of(context)!.minutes}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    thirtyMinutes();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                  },
                                  child: Text('30 ${AppLocalizations.of(context)!.minutes}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    oneHour();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                  },
                                  child: Text('1 ${AppLocalizations.of(context)!.hour}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    twoHour();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                  },
                                  child: Text('2 ${AppLocalizations.of(context)!.hours}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    threeHour();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                  },
                                  child: Text('3 ${AppLocalizations.of(context)!.hours}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    sexHour();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                  },
                                  child: Text('6 ${AppLocalizations.of(context)!.hours}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                                TextButton(
                                  onPressed: () {
                                    twelveHour();
                                    zabbixBloc
                                        .add(ZabbixHistoryOverviewLoadEvent());
                                  },
                                  child: Text('12 ${AppLocalizations.of(context)!.hours}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ]),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(Duration(seconds: 1), () {
            zabbixBloc.add(ZabbixHistoryOverviewLoadEvent());
          });
        },
        child: Container(
          color: Colors.black54,
          child: BlocListener<ZabbixBloc, ZabbixState>(
            listener: (context, state) {
              if (state is ZabbixHistoryOverviewErrorState) {
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
                } else if (state is ZabbixHistoryOverviewLoadingState) {
                  return buildLoading();
                } else if (state is ZabbixHistoryOverviewLoadedState) {
                  return buildHostDetailList(state.itemHistoryResult);
                } else if (state is ZabbixHistoryOverviewErrorState) {
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

  Widget buildHostDetailList(List<ItemHistoryResultModel> itemHistoryResult) {
    return ListView.builder(
        itemCount: itemHistoryResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {
            int dateFromJsonInt = int.parse(itemHistoryResult[pos].clock);
            var dateProblem = DateFormat.yMd().add_Hms().format(
                DateTime.fromMillisecondsSinceEpoch(dateFromJsonInt * 1000));
            return Container(
              color: Colors.black54,
              margin: EdgeInsets.all(1),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${dateProblem}:',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${itemHistoryResult[pos].value} $units',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ]),
            );
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
}
