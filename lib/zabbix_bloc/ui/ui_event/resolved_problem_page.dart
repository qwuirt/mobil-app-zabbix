import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/first_event_model/first_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/second_event_model/second_event_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ResolvedProblemsPage extends StatefulWidget {
  const ResolvedProblemsPage({Key? key}) : super(key: key);

  @override
  _ResolvedProblemsPageState createState() => _ResolvedProblemsPageState();
}

class _ResolvedProblemsPageState extends State<ResolvedProblemsPage> {
  var dateTimeTo = DateTime.now().millisecondsSinceEpoch;

  var dateTimeFrom = DateTime.now().millisecondsSinceEpoch - 21600000;

  void dateToJsonToBack() {
    setState(() {
      dateTimeTo -= 21600000;
    });
  }

  void dateToJsonFromBack() {
    setState(() {
      dateTimeFrom -= 21600000;
    });
  }

  void dateToJsonToForward() {
    setState(() {
      if (dateTimeFrom >= (DateTime.now().millisecondsSinceEpoch - 43200000)) {
        (DateTime.now().millisecondsSinceEpoch - 21600000);
      } else {
        dateTimeFrom += 21600000;
      }
    });
  }

  void dateToJsonFromForward() {
    setState(() {
      if (dateTimeTo >= DateTime.now().millisecondsSinceEpoch - 21600000) {
        (DateTime.now().millisecondsSinceEpoch);
      } else {
        dateTimeTo += 21600000;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(
          Duration(seconds: 1),
          () {
            return zabbixBloc.add(ZabbixResolvedProblemLoadEvent());
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(AppLocalizations.of(context)!.resolvedProblem),
        ),
        body: Container(
          color: Colors.black,
          child: BlocListener<ZabbixBloc, ZabbixState>(
            listener: (context, state) {
              if (state is ZabbixResolvedProblemErrorState) {
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
                } else if (state is ZabbixAllLoadedState) {
                  return buildFirstEventList(
                      state.firstEventResult, state.secondEventResult);
                } else if (state is ZabbixResolvedProblemLoadingState) {
                  return buildLoading();
                } else if (state is ZabbixResolvedProblemLoadedState) {
                  return buildFirstEventList(
                      state.firstEventResult, state.secondEventResult);
                } else if (state is ZabbixResolvedProblemErrorState) {
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

  Widget buildFirstEventList(List<FirstEventResultModel> firstEventResult,
      List<SecondEventResultModel> secondEventResult) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Column(children: <Widget>[
        Container(
          color: Colors.black54,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    saveDateTime();
                    dateToJsonToBack();
                    dateToJsonFromBack();
                    zabbixBloc.add(ZabbixResolvedProblemLoadEvent());
                  },
                ),
                Column(
                  children: [
                    Text(
                      'From: ${DateFormat.MMMMd().add_Hms().format(DateTime.fromMillisecondsSinceEpoch(dateTimeFrom))}',
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                        'To: ${DateFormat.MMMMd().add_Hms().format(DateTime.fromMillisecondsSinceEpoch(dateTimeTo))}',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 30.0,
                  ),
                  onPressed: () {
                    saveDateTime();
                    dateToJsonToForward();
                    dateToJsonFromForward();
                    zabbixBloc.add(ZabbixResolvedProblemLoadEvent());
                  },
                ),
              ]),
        ),
        ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: secondEventResult.length,
            itemBuilder: (ctx, pos) {
              return BlocBuilder<ZabbixBloc, ZabbixState>(
                  builder: (context, state) {
                int problemPriority = int.parse(firstEventResult[pos].severity);

                var secondEventReversed = List.from(secondEventResult.reversed);

                int dateSecondFromJsonInt =
                    int.parse(secondEventReversed[pos].clock);
                int dateFirstFromJsonInt =
                    int.parse(firstEventResult[pos].clock);

                var _dateFirst = DateTime.fromMillisecondsSinceEpoch(
                    dateFirstFromJsonInt * 1000);
                var _dateSecond = DateTime.fromMillisecondsSinceEpoch(
                    dateSecondFromJsonInt * 1000);
                var dateFirstEvent =
                    DateFormat.yMd().add_Hms().format(_dateFirst);
                var dateSecondEvent =
                    DateFormat.yMd().add_Hms().format(_dateSecond);
                var secondDifference;
                if(dateSecondFromJsonInt >= dateFirstFromJsonInt) {
                  Duration difference = _dateSecond.difference(_dateFirst);
                  secondDifference = difference.inSeconds;
                }else {
                  Duration difference = _dateFirst.difference(_dateSecond);
                  secondDifference = difference.inSeconds;
                }

                outputDifferenceHour(var sec) {
                  if (sec <= 2678400 &&
                      sec <= 86400 &&
                      sec <= 3600 &&
                      sec <= 60) {
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
                    int month = sec ~/ (86400 * 31);
                    sec %= (86400 * 31);
                    int day = sec ~/ (24 * 3600);
                    sec %= (24 * 3600);
                    int hour = sec ~/ 3600;
                    sec %= 3600;
                    int minutes = sec ~/ 60;
                    sec %= 60;
                    int second = sec;
                    return Text(
                      '${month}m ${day}d ${hour}h',
                      style: TextStyle(color: Colors.white),
                    );
                  }
                }

                if (problemPriority == 5) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, bottom: 3, top: 3),
                      child: Column(children: [
                        Text(
                          '$dateFirstEvent - $dateSecondEvent',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
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
                                      '${firstEventResult[pos].firstEventHosts[0].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${firstEventResult[pos].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              outputDifferenceHour(secondDifference),
                            ],
                          ),
                        )
                      ]));
                } else if (problemPriority == 4) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, bottom: 3, top: 3),
                      child: Column(children: [
                        Text(
                          '$dateFirstEvent - $dateSecondEvent',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
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
                                      '${firstEventResult[pos].firstEventHosts[0].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${firstEventResult[pos].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              outputDifferenceHour(secondDifference),
                            ],
                          ),
                        )
                      ]));
                } else if (problemPriority == 3) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, bottom: 3, top: 3),
                      child: Column(children: [
                        Text(
                          '$dateFirstEvent - $dateSecondEvent',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
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
                                      '${firstEventResult[pos].firstEventHosts[0].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${firstEventResult[pos].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              outputDifferenceHour(secondDifference),
                            ],
                          ),
                        )
                      ]));
                } else if (problemPriority == 2) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, bottom: 3, top: 3),
                      child: Column(children: [
                        Text(
                          '$dateFirstEvent - $dateSecondEvent',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
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
                                      '${firstEventResult[pos].firstEventHosts[0].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${firstEventResult[pos].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              outputDifferenceHour(secondDifference),
                            ],
                          ),
                        )
                      ]));
                } else if (problemPriority == 1) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, bottom: 3, top: 3),
                      child: Column(children: [
                        Text(
                          '$dateFirstEvent - $dateSecondEvent',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
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
                                      '${firstEventResult[pos].firstEventHosts[0].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${firstEventResult[pos].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              outputDifferenceHour(secondDifference),
                            ],
                          ),
                        )
                      ]));
                } else if (problemPriority == 0) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 0, right: 0, bottom: 3, top: 3),
                      child: Column(children: [
                        Text(
                          '$dateFirstEvent - $dateSecondEvent',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
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
                                      '${firstEventResult[pos].firstEventHosts[0].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      '${firstEventResult[pos].name}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ]));
                }
                return Container();
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

  void saveDateTime() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setInt('dateTimeTo', dateTimeTo);
    localStorage.setInt('dateTimeFrom', dateTimeFrom);
  }
}
