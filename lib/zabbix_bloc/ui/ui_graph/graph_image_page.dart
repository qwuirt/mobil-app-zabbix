import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class GraphsImagePage extends StatefulWidget {
  String graphid;
  String urlApi;
  String authImage;


  GraphsImagePage({
    required this.graphid,
    required this.urlApi,
    required this.authImage,
  });

  @override
  _GraphsImagePageState createState() => _GraphsImagePageState();
}

class _GraphsImagePageState extends State<GraphsImagePage> {
  dynamic timeFrom = '1d';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: BlocListener<ZabbixBloc, ZabbixState>(
        listener: (context, state) {
          if (state is ZabbixGraphErrorState) {
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
            } else if (state is ZabbixGraphLoadingState) {
              return buildLoading();
            } else if (state is ZabbixAllLoadedState) {
              return buildGraphImage(context);
            }  else if (state is ZabbixGraphLoadedState) {
              return buildGraphImage(context);
            } else if (state is ZabbixGraphErrorState) {
              return buildErrorUi(context, state.message);
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget buildGraphImage(BuildContext context) {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    return BlocBuilder<ZabbixBloc, ZabbixState>(builder: (context, state) {
      return InteractiveViewer(
        panEnabled: true,
        child: TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onLongPress: () {
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => SingleChildScrollView(
                    child: AlertDialog(
                    backgroundColor: Colors.black,
                    content: Container(
                      color: Colors.black54,
                      child: Column(children: [
                        TextButton(
                          onPressed: () async {
                            timeFrom = '5m';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('5 ${AppLocalizations.of(context)!.minutes}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '15m';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('15 ${AppLocalizations.of(context)!.minutes}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '30m';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('30 ${AppLocalizations.of(context)!.minutes}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '1h';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('1 ${AppLocalizations.of(context)!.hour}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '3h';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('3 ${AppLocalizations.of(context)!.hours}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '6h';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('6 ${AppLocalizations.of(context)!.hours}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '12h';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('12 ${AppLocalizations.of(context)!.hours}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '1d';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('1 ${AppLocalizations.of(context)!.day}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '2d';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('2 ${AppLocalizations.of(context)!.days}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '3d';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('3 ${AppLocalizations.of(context)!.days}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '7d';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('7 ${AppLocalizations.of(context)!.days}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '30d';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('30 ${AppLocalizations.of(context)!.days}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '6M';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('6 ${AppLocalizations.of(context)!.month}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '1y';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('1 ${AppLocalizations.of(context)!.year}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                        TextButton(
                          onPressed: () async {
                            timeFrom = '2y';
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            zabbixBloc.add(ZabbixGraphLoadEvent());
                            Navigator.pop(context);
                          },
                          child: Text('2 ${AppLocalizations.of(context)!.years}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              )),
                        ),
                      ]),
                    ))));
          },
          onPressed: () {},
          child: Image(
              image: NetworkImage(
            widget.urlApi.replaceAll("api_jsonrpc.php",
                "chart2.php?graphid=${widget.graphid}&from=now-$timeFrom&to=now&width=1100&height=350&profileIdx=web.graphs.filter"),
            headers: {'Cookie': 'zbx_sessionid=${widget.authImage}'},
          )),
        ),
      );
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
