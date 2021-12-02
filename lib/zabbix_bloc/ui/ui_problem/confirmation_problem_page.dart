import 'dart:convert';

import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/confirmation_problem_model/confirmation_problem_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/confirmation_problem_model/confirmation_problem_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/confirmation_problem_model/confirmation_problem_result_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ConfirmationProblemPage extends StatefulWidget {
  String title;
  String manual_close;
  String eventid;

  ConfirmationProblemPage({
    Key? key,
    required this.title,
    required this.manual_close,
    required this.eventid,
  }) : super(key: key);

  Future<List<ConfirmationProblemResultModel>> confirmationProblem(
      confirmationProblemRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    int? closeProblem = localStorage.getInt('counterCloseProblem');
    int? confirmation = localStorage.getInt('counterConfirmation');
    int? counterMessage = localStorage.getInt('counterMessage');
    String? eventid = localStorage.getString('eventid');
    message() {
      String? message = localStorage.getString('message');
      if (message == null) {
        return message = '';
      } else {
        return message;
      }
    }

    ConfirmationProblemRequestModel confirmationProblemRequestModel =
        ConfirmationProblemRequestModel(
      auth_problem: '$auth',
      message: '${message()}',
      eventid: '$eventid',
      action: '${closeProblem! + confirmation! + counterMessage!}',
    );

    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(confirmationProblemRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ConfirmationProblemResultModel> confirmationProblemResult =
          (ConfirmationProblemResponseModel.fromJson(data)
              .confirmationProblemResult);
      return confirmationProblemResult;
    } else {
      throw Exception('');
    }
  }

  @override
  State<ConfirmationProblemPage> createState() =>
      _ConfirmationProblemPageState();
}

class _ConfirmationProblemPageState extends State<ConfirmationProblemPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final _sizeTextBlack = const TextStyle(fontSize: 15.0, color: Colors.black);
  TextEditingController _messageController = TextEditingController();
  bool isCheckedCloseProblem = false;
  int counterCloseProblem = 0;
  int counterConfirmation = 0;
  int counterMessage = 0;
  bool isCheckedConfirmation = false;

  @override
  Widget build(BuildContext context) {
    String manual_close = widget.manual_close;
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    Color getColorCloseProblem(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains) || manual_close == '1') {
        return Colors.blue;
      } else {
        return Colors.black12;
      }
    }

    Color getColorConfirmationProbler(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.blue;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      key: scaffoldKey,
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
        color: Colors.black54,
        child: Column(
          children: [
            Form(
              key: globalFormKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.message,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    style: _sizeTextBlack,
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.enterMessage,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(
                              getColorCloseProblem),
                          value: isCheckedCloseProblem,
                          onChanged: (bool? value) {
                            if (manual_close == '1') {
                              setState(() {
                                isCheckedCloseProblem = value!;
                              });
                            } else {
                              return null;
                            }
                          },
                        ),
                        Text(AppLocalizations.of(context)!.closProblem)
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(
                              getColorConfirmationProbler),
                          value: isCheckedConfirmation,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedConfirmation = value!;
                            });
                          },
                        ),
                        Text(AppLocalizations.of(context)!.confirm)
                      ],
                    ),
                  ),
                  TextButton(
                    child: Container(
                      child: Text(
                        AppLocalizations.of(context)!.confirm,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      color: Colors.blue,
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                    ),
                    onPressed: () {
                      if (save()) {
                        saveCounterCloseProblem();
                        saveCounterConfirmationProblem();
                        saveEventid();
                        saveCounterMessageProblem();
                        zabbixBloc.add(ZabbixConfirmationProblemLoadEvent());
                        zabbixBloc.add(ZabbixProblemLoadEvent());
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  saveEventid() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('eventid', widget.eventid);
  }

  saveCounterCloseProblem() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (isCheckedCloseProblem == true) {
      counterCloseProblem = 1;
      localStorage.setInt('counterCloseProblem', counterCloseProblem);
    } else {
      counterCloseProblem = 0;
      localStorage.setInt('counterCloseProblem', counterCloseProblem);
    }
  }

  saveCounterConfirmationProblem() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (isCheckedConfirmation == true) {
      counterConfirmation = 2;
      localStorage.setInt('counterConfirmation', counterConfirmation);
    } else {
      counterConfirmation = 0;
      localStorage.setInt('counterConfirmation', counterConfirmation);
    }
  }

  saveCounterMessageProblem() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    if (_messageController.text == '') {
      counterMessage = 0;
      localStorage.setInt('counterMessage', counterMessage);
    } else {
      counterMessage = 4;
      localStorage.setInt('counterMessage', counterMessage);
      localStorage.setString('message', _messageController.text);
    }
  }

  bool save() {
    final form = globalFormKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
