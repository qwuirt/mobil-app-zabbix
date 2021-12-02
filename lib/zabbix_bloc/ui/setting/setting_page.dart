import 'dart:async';

import 'package:Zabbix/zabbix_bloc/res/zabbix_servers.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Zabbix/l10n/l10n.dart';
import 'package:Zabbix/provider/locale_provider.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_bloc.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'login_form.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> globalFormKey = new GlobalKey<FormState>();
  final _sizeTextBlack = const TextStyle(fontSize: 15.0, color: Colors.white);

  Color getColorConfirmationProblem(Set<MaterialState> states) {
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

  List<ZabbixServers> users = [];
  bool isCheckedAutoRefresh = false;
  bool hidePassword = true;
  String autoRefresh = '';
  String language = '';
  int indexServerZabbix = 0;

  @override
  void initState() {
    super.initState();
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);
    indexServerZabbix = ListServerZabbixPreferences.getListServer() ?? 0;
    autoRefresh = AutoRefreshPreferences.getAutoRefresh() ?? '10';
    isCheckedAutoRefresh =
        IsCheckedAutoRefreshPreferences.getIsCheckedAutoRefresh() ?? false;
    language = LanguagePreferences.getLanguage() ?? '';
    if (ListUrlApiPreferences.getListUrlApi() != null) {
      if (ListUrlApiPreferences.getListUrlApi()!.split(', ')[0] != '') {
        int countUrlApi =
            ListUrlApiPreferences.getListUrlApi()!.split(', ').length;
        for (int i = 1; i <= countUrlApi; i++) {
          users.add(ZabbixServers());
        }
      }
    }

  }

  dropDownMenuItem(String n) {
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

  defaultAutoRefreshValue() {
    if (autoRefresh.isEmpty) {
      autoRefresh = '10';
      return '10';
    } else {
      return autoRefresh;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(AppLocalizations.of(context)!.configurations),
      ),
      key: scaffoldKey,
      body: Container(
        color: Colors.black,
        child: BlocListener<ZabbixBloc, ZabbixState>(
          listener: (context, state) {
            if (state is ZabbixLoginErrorState) {
              errorMessage() {
                if (state.message == 'failed') {
                  return AppLocalizations.of(context)!.incorrectUrl;
                } else if (state.message ==
                    "type 'Null' is not a subtype of type 'String' in type cast") {
                  return AppLocalizations.of(context)!.incorrectLogin;
                } else {
                  return AppLocalizations.of(context)!.noConnection;
                }
              }

              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(errorMessage()),
                ),
              );
            }
          },
          child: BlocBuilder<ZabbixBloc, ZabbixState>(
            builder: (context, state) {
              if (state is ZabbixInitialState) {
                return buildLoading();
              } else if (state is ZabbixLoginLoadingState) {
                return buildLoading();
              } else if (state is ZabbixLoginLoadedState) {
                return buildSetting(context);
              } else if (state is ZabbixSettingLoadedState) {
                return buildSetting(context);
              } else if (state is ZabbixAllLoadedState) {
                return buildSetting(context);
              } else if (state is ZabbixSettingErrorState) {
                return buildSetting(context);
              } else if (state is ZabbixLoginErrorState) {
                return buildErrorUi(state.message);
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  Widget buildSetting(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return BlocBuilder<ZabbixBloc, ZabbixState>(builder: (context, state) {
      return Container(
        padding: const EdgeInsets.all(10),
        color: const Color.fromRGBO(60, 60, 60, 1),
        child: ListView(
          children: [
            Form(
              key: globalFormKey,
              child: Column(
                children: [
                  Container(
                      child: users.length <= 0
                          ? Center(
                              child: Container(
                              color: Colors.blue,
                              height: 30,
                              margin: const EdgeInsets.all(10),
                              child: TextButton(
                                onPressed: onAddForm,
                                child: Text(
                                    AppLocalizations.of(context)!
                                        .addZabbixServer,
                                    style: TextStyle(
                                      color: Colors.black,
                                    )),
                              ),
                            ))
                          : SingleChildScrollView(
                              physics: ScrollPhysics(),
                              child: Column(children: [
                                ListView.builder(
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: users.length,
                                    itemBuilder: (ctx, pos) {
                                      return Column(children: [
                                        UserForm(
                                          zabbixServers: users[pos],
                                          onDelete: () => onDelete(pos),
                                          title: title(pos),
                                          index: pos,
                                        ),
                                      ]);
                                    }),
                                FloatingActionButton(
                                  child: Icon(Icons.add),
                                  onPressed: onAddForm,
                                ),
                                SizedBox(
                                  height: 20,
                                )
                              ]))),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(children: [
                      Row(
                        children: [
                          Checkbox(
                            checkColor: Colors.white,
                            fillColor: MaterialStateProperty.resolveWith(
                                getColorConfirmationProblem),
                            value: isCheckedAutoRefresh,
                            onChanged: (bool? value) {
                              setState(() {
                                isCheckedAutoRefresh = value!;
                              });
                            },
                          ),
                          Text(
                            AppLocalizations.of(context)!.checkRefreshTrigger,
                            style: TextStyle(color: Colors.white70),
                          )
                        ],
                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        style: _sizeTextBlack,
                        initialValue: defaultAutoRefreshValue(),
                        decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context)!.inputRefreshTrigger,
                        ),
                        onChanged: (value) =>
                            setState(() => autoRefresh = value),
                      ),
                    ]),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 140,
                      child: DropdownButton(
                        isExpanded: true,
                        iconSize: 30.0,
                        dropdownColor: Colors.black87,
                        value: locale,
                        items: L10n.all.map(
                          (locale) {
                            final flag = L10n.getFlag(locale.languageCode);
                            return DropdownMenuItem(
                              child: Container(
                                child: Center(
                                  child: Text(
                                    flag,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                              value: locale,
                              onTap: () {
                                final provider = Provider.of<LocaleProvider>(
                                    context,
                                    listen: false);

                                provider.setLocale(locale);
                              },
                            );
                          },
                        ).toList(),
                        onChanged: (value) =>
                            setState(() => language = '$value'),
                      ),
                    ),
                  ),
                  TextButton(
                    child: Container(
                      child: Text(
                        AppLocalizations.of(context)!.save,
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
                        saveData(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
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

    final provider = Provider.of<LocaleProvider>(context);
    final locale = provider.locale;
    return Container(
      padding: const EdgeInsets.all(10),
      color: const Color.fromRGBO(60, 60, 60, 1),
      child: ListView(
        children: [
          Form(
            key: globalFormKey,
            child: Column(
              children: [
                Container(
                    child: users.length <= 0
                        ? Center(
                            child: Container(
                            color: Colors.blue,
                            height: 30,
                            margin: const EdgeInsets.all(10),
                            child: TextButton(
                              onPressed: onAddForm,
                              child: Text(
                                  AppLocalizations.of(context)!.addZabbixServer,
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                            ),
                          ))
                        : SingleChildScrollView(
                            physics: ScrollPhysics(),
                            child: Column(children: [
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: users.length,
                                  itemBuilder: (ctx, pos) {
                                    return Column(children: [
                                      UserForm(
                                        zabbixServers: users[pos],
                                        onDelete: () => onDelete(pos),
                                        title: title(pos),
                                        index: pos,
                                      ),
                                    ]);
                                  }),
                              FloatingActionButton(
                                child: Icon(Icons.add),
                                onPressed: onAddForm,
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ]))),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          fillColor: MaterialStateProperty.resolveWith(
                              getColorConfirmationProblem),
                          value: isCheckedAutoRefresh,
                          onChanged: (bool? value) {
                            setState(() {
                              isCheckedAutoRefresh = value!;
                            });
                          },
                        ),
                        Text(
                          AppLocalizations.of(context)!.checkRefreshTrigger,
                          style: TextStyle(color: Colors.white70),
                        )
                      ],
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      style: _sizeTextBlack,
                      initialValue: defaultAutoRefreshValue(),
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.inputRefreshTrigger,
                      ),
                      onChanged: (value) => setState(() => autoRefresh = value),
                    ),
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: 140,
                    child: DropdownButton(
                      isExpanded: true,
                      iconSize: 30.0,
                      dropdownColor: Colors.black87,
                      value: locale,
                      items: L10n.all.map(
                        (locale) {
                          final flag = L10n.getFlag(locale.languageCode);
                          return DropdownMenuItem(
                            child: Container(
                              child: Center(
                                child: Text(
                                  flag,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                            value: locale,
                            onTap: () {
                              final provider = Provider.of<LocaleProvider>(
                                  context,
                                  listen: false);

                              provider.setLocale(locale);
                            },
                          );
                        },
                      ).toList(),
                      onChanged: (value) => setState(() => language = '$value'),
                    ),
                  ),
                ),
                TextButton(
                  child: Container(
                    child: Text(
                      AppLocalizations.of(context)!.save,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.blue,
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 80),
                  ),
                  onPressed: () {
                    if (save()) {
                      saveData(context);
                    }
                  },
                ),
                Container(
                    child: Text(
                  errorMessage(),
                  style: TextStyle(color: Colors.red),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void saveData(context) async {
    final ZabbixBloc zabbixBloc = BlocProvider.of<ZabbixBloc>(context);

    await ListUrlApiPreferences.setListUrlApi(
        users.map((e) => e.urlApi).toList().join(', '));
    await ListUserPreferences.setListUsername(
        users.map((e) => e.username).toList().join(', '));
    await ListPasswordPreferences.setListPassword(
        users.map((e) => e.password).toList().join(', '));

    await UserPreferences.setUsername(
        ListUserPreferences.getListUsername()!.split(', ')[indexServerZabbix]);
    await PasswordPreferences.setPassword(
        ListPasswordPreferences.getListPassword()!
            .split(', ')[indexServerZabbix]);
    await UrlApiPreferences.setUrlApi(
        ListUrlApiPreferences.getListUrlApi()!.split(', ')[indexServerZabbix]);

    await ListPriorityProblemsPreferences.setListPriorityProblems(
        users.map((e) => e.selectPriorityProblems).toList().join(', '));
    await ListPrioritySystemStatusPreferences.setListPrioritySystemStatus(
        users.map((e) => e.selectPrioritySystemStatus).toList().join(', '));

    if (ListPriorityProblemsPreferences.getListPriorityProblems()!
            .split(', ')[indexServerZabbix] !=
        '') {
      await SelectPriorityProblemsPreferences.setSelectPriorityProblems(
          ListPriorityProblemsPreferences.getListPriorityProblems()!
              .split(', ')[indexServerZabbix]);
    } else {
      await SelectPriorityProblemsPreferences.setSelectPriorityProblems('0');
    }

    if (ListPrioritySystemStatusPreferences.getListPrioritySystemStatus()!
            .split(', ')[indexServerZabbix] !=
        '') {
      await SelectPrioritySystemStatusPreferences.setSelectPrioritySystemStatus(
          ListPrioritySystemStatusPreferences.getListPrioritySystemStatus()!
              .split(', ')[indexServerZabbix]);
    } else {
      await SelectPrioritySystemStatusPreferences.setSelectPrioritySystemStatus(
          '0');
    }

    await LanguagePreferences.setLanguage(language);

    if (isCheckedAutoRefresh == true) {
      await AutoRefreshPreferences.setAutoRefresh(autoRefresh);
    }
    await IsCheckedAutoRefreshPreferences.setIsCheckedAutoRefresh(
        isCheckedAutoRefresh);

    setState(() {
      zabbixBloc.add(ZabbixLoginLoadEvent());
    });
  }

  void onDelete(int index) async {
    setState(() {
      users.removeAt(index);
    });
    List listUrl = (ListUrlApiPreferences.getListUrlApi() ?? '').split(', ');
    List listUser = (ListUserPreferences.getListUsername() ?? '').split(', ');
    List listPassword =
        (ListPasswordPreferences.getListPassword() ?? '').split(', ');
    List listPriorityProblem =
        (ListPriorityProblemsPreferences.getListPriorityProblems() ?? '')
            .split(', ');
    List listPrioritySystemStatus =
        (ListPrioritySystemStatusPreferences.getListPrioritySystemStatus() ??
                '')
            .split(', ');

    listUrl.removeAt(index);
    listUser.removeAt(index);
    listPassword.removeAt(index);
    listPriorityProblem.removeAt(index);
    listPrioritySystemStatus.removeAt(index);

    await ListUrlApiPreferences.setListUrlApi(listUrl.join(', '));
    await ListUserPreferences.setListUsername(listUser.join(', '));
    await ListPasswordPreferences.setListPassword(listPassword.join(', '));
    await ListPriorityProblemsPreferences.setListPriorityProblems(
        listPriorityProblem.join(', '));
    await ListPrioritySystemStatusPreferences.setListPrioritySystemStatus(
        listPrioritySystemStatus.join(', '));
  }

  void onAddForm() async {
    if (ListUrlApiPreferences.getListUrlApi() != null) {
      List listUrl = (ListUrlApiPreferences.getListUrlApi() ?? '').split(', ');
      List listUser = (ListUserPreferences.getListUsername() ?? '').split(', ');
      List listPassword =
          (ListPasswordPreferences.getListPassword() ?? '').split(', ');
      List listPriorityProblem =
          (ListPriorityProblemsPreferences.getListPriorityProblems() ?? '')
              .split(', ');
      List listPrioritySystemStatus =
          (ListPrioritySystemStatusPreferences.getListPrioritySystemStatus() ??
                  '')
              .split(', ');

      listUrl.add('');
      listUser.add('');
      listPassword.add('');
      listPriorityProblem.add('');
      listPrioritySystemStatus.add('');

      await ListUrlApiPreferences.setListUrlApi(listUrl.join(', '));
      await ListUserPreferences.setListUsername(listUser.join(', '));
      await ListPasswordPreferences.setListPassword(listPassword.join(', '));
      await ListPriorityProblemsPreferences.setListPriorityProblems(
          listPriorityProblem.join(', '));
      await ListPrioritySystemStatusPreferences.setListPrioritySystemStatus(
          listPrioritySystemStatus.join(', '));
    }
    setState(() {
      users.add(ZabbixServers());
    });
  }

  title(int index) {
    List urlList = users.map((e) => e.urlApi).toList();
    if (urlList[index] != '') {
      return urlList[index]
          .replaceAll('https://', '')
          .replaceAll('/zabbix/api_jsonrpc.php', '');
    } else if (ListUrlApiPreferences.getListUrlApi() != null) {
      List list = ListUrlApiPreferences.getListUrlApi()!.split(', ');
      if (list.length >= index) {
        if (list[index] != '') {
          return list[index]
              .replaceAll('https://', '')
              .replaceAll('/zabbix/api_jsonrpc.php', '');
        }
      }
    }
    return '';
  }

  bool save() {
    final form = globalFormKey.currentState;
    if (users.map((e) => e.urlApi).join(', ') != '') {
      if (form!.validate()) {
        form.save();
        return true;
      }
    }
    return false;
  }
}
