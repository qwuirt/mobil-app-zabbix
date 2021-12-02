import 'package:Zabbix/zabbix_bloc/res/zabbix_servers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_zabbix/save_intut_data.dart';

typedef OnDelete();

class UserForm extends StatefulWidget {
  final ZabbixServers zabbixServers;
  final state = _UserFormState();
  final OnDelete onDelete;
  String title;
  int index;

  UserForm(
      {required this.index,
      required this.title,
      required this.zabbixServers,
      required this.onDelete});

  @override
  _UserFormState createState() => state;

  bool isValid() => state.validate();
}

class _UserFormState extends State<UserForm> {
  final _sizeTextBlack = const TextStyle(fontSize: 15.0, color: Colors.white);
  final form = GlobalKey<FormState>();
  bool hidePassword = true;

  urlApi() {
    if (ListUrlApiPreferences.getListUrlApi() != null) {
      List list = ListUrlApiPreferences.getListUrlApi()!.split(', ');
      if (list.length >= widget.index) {
        if (list[widget.index] != '') {
          widget.zabbixServers.urlApi = list[widget.index];
          return list[widget.index];
        }
      }
    }
    return '';
  }

  username() {
    if (ListUserPreferences.getListUsername() != null) {
      List list = ListUserPreferences.getListUsername()!.split(', ');
      if (list.length >= widget.index) {
        if (list[widget.index] != '') {
          widget.zabbixServers.username = list[widget.index];
          return list[widget.index];
        }
      }
    }
    return '';
  }

  password() {
    if (ListPasswordPreferences.getListPassword() != null) {
      List list = ListPasswordPreferences.getListPassword()!.split(', ');
      if (list.length >= widget.index) {
        if (list[widget.index] != '') {
          widget.zabbixServers.password = list[widget.index];
          return list[widget.index];
        }
      }
    }
    return '';
  }

  menuPriorityProblem() {
      if (widget.zabbixServers.valueItemProblems != '') {
        return widget.zabbixServers.valueItemProblems.toString();
      } else if (ListPriorityProblemsPreferences.getListPriorityProblems() != null) {
      List list = ListPriorityProblemsPreferences.getListPriorityProblems()!.split(', ');
      if (list.length >= widget.index) {
        if (list[widget.index] != '') {
          widget.zabbixServers.selectPriorityProblems = list[widget.index];
          return list[widget.index];
        }
      }
    }
    return '0';
  }

  menuPrioritySystemStatus() {
    if (widget.zabbixServers.valueItemSystemStatus != '') {
      return widget.zabbixServers.valueItemSystemStatus.toString();
    } else if (ListPrioritySystemStatusPreferences.getListPrioritySystemStatus() != null) {
      List list = ListPrioritySystemStatusPreferences.getListPrioritySystemStatus()!.split(', ');
      if (list.length >= widget.index) {
        if (list[widget.index] != '') {
          widget.zabbixServers.selectPrioritySystemStatus = list[widget.index];
          return list[widget.index];
        }
      }
    }
    return '0';
  }

  dropdownMenuItem(String n) {
    if (n == '1') {
      return Container(
        color: const Color.fromRGBO(66, 135, 245, 1),
        width: 150,
        height: 30,
        alignment: Alignment.center,
        child: Text(AppLocalizations.of(context)!.information),
      );
    } else if (n == '2') {
      return Container(
        color: const Color.fromRGBO(255, 200, 89, 1),
        width: 150,
        height: 30,
        alignment: Alignment.center,
        child: Text(AppLocalizations.of(context)!.warning),
      );
    } else if (n == '3') {
      return Container(
        color: const Color.fromRGBO(255, 160, 89, 1),
        width: 150,
        height: 30,
        alignment: Alignment.center,
        child: Text(AppLocalizations.of(context)!.average),
      );
    } else if (n == '4') {
      return Container(
        color: const Color.fromRGBO(233, 118, 89, 1),
        width: 150,
        height: 30,
        alignment: Alignment.center,
        child: Text(AppLocalizations.of(context)!.high),
      );
    } else if (n == '5') {
      return Container(
        color: const Color.fromRGBO(255, 0, 0, 1),
        width: 150,
        height: 30,
        alignment: Alignment.center,
        child: Text(AppLocalizations.of(context)!.emergency),
      );
    } else {
      return Container(
          color: const Color.fromRGBO(151, 170, 179, 1),
          width: 150,
          height: 30,
          alignment: Alignment.center,
          child: Text(AppLocalizations.of(context)!.notClassified));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
            child: Column(children: [
              AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  icon: Icon(Icons.people),
                  onPressed: () {},
                ),
                title: Text('${widget.title}'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
            Container(
                padding: const EdgeInsets.all(5),
                color: const Color.fromRGBO(60, 60, 60, 1),
                child: Column(children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.apiUrlInput,
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.lightBlueAccent,
                    child: TextFormField(
                      keyboardType: TextInputType.url,
                      style: _sizeTextBlack,
                      initialValue: urlApi(),
                      decoration: InputDecoration(
                        labelText: 'Url:',
                      ),
                      validator: (input) => input!.length < 5 ? '' : null,
                      onChanged: (urlApi) =>
                          setState(() => this.widget.zabbixServers.urlApi = urlApi),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.userLogin,
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.lightBlueAccent,
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      style: _sizeTextBlack,
                      initialValue: username(),
                      decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)!.userLogin,
                      ),
                      validator: (input) => input!.length < 5 ? '' : null,
                      onChanged: (user) =>
                          setState(() => this.widget.zabbixServers.username = user),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      AppLocalizations.of(context)!.userPassword,
                      style: TextStyle(
                        color: Colors.lightBlueAccent,
                      ),
                    ),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    style: _sizeTextBlack,
                    initialValue: password(),
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        color: Colors.black54,
                        icon: Icon(
                            hidePassword ? Icons.visibility_off : Icons.visibility),
                      ),
                      labelText: AppLocalizations.of(context)!.userPassword,
                    ),
                    validator: (input) => input!.length < 5 ? '' : null,
                    onChanged: (password) =>
                        setState(() => this.widget.zabbixServers.password = password),
                    obscureText: hidePassword,
                  )
                ])
            ),
              Container(
                color: const Color.fromRGBO(60, 60, 60, 1),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!
                            .selectPriorityProblems,
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.black54,
                      width: 150,
                      child: DropdownButton(
                          dropdownColor: Colors.white10,
                          hint: dropdownMenuItem(menuPriorityProblem()),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: [
                            DropdownMenuItem(
                              child: Container(
                                  color: const Color.fromRGBO(
                                      151, 170, 179, 1),
                                  width: 160,
                                  height: 50,
                                  alignment: Alignment.center,
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .notClassified,
                                    style: TextStyle(fontSize: 18),
                                  )),
                              value: 0,
                            ),
                            DropdownMenuItem(
                              child: Container(
                                color:
                                const Color.fromRGBO(66, 135, 245, 1),
                                width: 160,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.information,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              value: 1,
                            ),
                            DropdownMenuItem(
                              child: Container(
                                color:
                                const Color.fromRGBO(255, 200, 89, 1),
                                width: 160,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.warning,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              value: 2,
                            ),
                            DropdownMenuItem(
                              child: Container(
                                color:
                                const Color.fromRGBO(255, 160, 89, 1),
                                width: 160,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.average,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              value: 3,
                            ),
                            DropdownMenuItem(
                              child: Container(
                                color:
                                const Color.fromRGBO(233, 118, 89, 1),
                                width: 160,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.high,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              value: 4,
                            ),
                            DropdownMenuItem(
                              child: Container(
                                color: const Color.fromRGBO(255, 0, 0, 1),
                                width: 160,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!.emergency,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ),
                              value: 5,
                            ),
                          ],
                          onChanged: (value) {
                            setState(() => this.widget.zabbixServers.valueItemProblems = value);
                            this.widget.zabbixServers.selectPriorityProblems =
                                widget.zabbixServers.valueItemProblems.toString();
                          }),
                    ),
                  ]),
              ),
            Container(
              color: const Color.fromRGBO(60, 60, 60, 1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppLocalizations.of(context)!
                            .selectPrioritySystemStatus,
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                    Container(
                      // color: Colors.white70,
                      width: 150,
                      child: DropdownButton(
                          dropdownColor: Colors.white10,
                          hint: dropdownMenuItem(menuPrioritySystemStatus()),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(color: Colors.black),
                          items: [
                            DropdownMenuItem(
                            child: Container(
                                color: const Color.fromRGBO(
                                    151, 170, 179, 1),
                                width: 160,
                                height: 50,
                                alignment: Alignment.center,
                                child: Text(
                                  AppLocalizations.of(context)!
                                      .notClassified,
                                  style: TextStyle(fontSize: 18),
                                )),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Container(
                              color:
                              const Color.fromRGBO(66, 135, 245, 1),
                              width: 160,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.information,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Container(
                              color:
                              const Color.fromRGBO(255, 200, 89, 1),
                              width: 160,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.warning,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            value: 2,
                          ),
                          DropdownMenuItem(
                            child: Container(
                              color:
                              const Color.fromRGBO(255, 160, 89, 1),
                              width: 160,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.average,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            value: 3,
                          ),
                          DropdownMenuItem(
                            child: Container(
                              color:
                              const Color.fromRGBO(233, 118, 89, 1),
                              width: 160,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.high,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            value: 4,
                          ),
                          DropdownMenuItem(
                            child: Container(
                              color: const Color.fromRGBO(255, 0, 0, 1),
                              width: 160,
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                AppLocalizations.of(context)!.emergency,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            value: 5,
                          ),
                          ],
                          onChanged: (value) {
                            setState(
                                    () => this.widget.zabbixServers.valueItemSystemStatus = value);
                            this.widget.zabbixServers.selectPrioritySystemStatus =
                                widget.zabbixServers.valueItemSystemStatus.toString();
                          }),
                    ),
                  ]),
            ),
          ]),
        ),
    );
  }

  bool validate() {
    var valid = form.currentState!.validate();
    if (valid) form.currentState!.save();
    return valid;
  }
}
