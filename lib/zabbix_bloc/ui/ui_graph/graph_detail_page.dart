
import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_model/graph_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'graph_image_page.dart';

class GraphDetailPage extends StatelessWidget {
  String title;
  GraphDetailPage({
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
                } else if (state is ZabbixGraphLoadedState) {
                  return buildGraphList(state.graphResult);
                } else if (state is ZabbixGraphErrorState) {
                  return buildErrorUi(context, state.message);
                }
                return Container();
              },
            ),
          ),
        ),
    );
  }

  Widget buildGraphList(List<GraphResultModel> graphResult) {
    return ListView.builder(
        itemCount: graphResult.length,
        itemBuilder: (ctx, pos) {
          return BlocBuilder<ZabbixBloc, ZabbixState>(
              builder: (context, state) {

                return Container(
                  margin: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                  color: Colors.black54,
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${graphResult[pos].name}',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    onPressed: () {
                      navigateToGraphImage(context, graphResult[pos]);
                    },
                  ),
                );
              });
        });
  }

  void navigateToGraphImage(
      BuildContext context, GraphResultModel graphResult) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    Navigator.push(context, MaterialPageRoute(builder: (context)  {
      return GraphsImagePage(
        graphid: graphResult.graphid,
        urlApi: '${UrlApiPreferences.getUrlApi()}',
        authImage: '${localStorage.getString('auth')}',
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
