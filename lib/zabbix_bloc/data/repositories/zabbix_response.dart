import 'dart:convert';
import 'package:Zabbix/zabbix_bloc/ui/setting/login_zabbix/save_intut_data.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/garaph_hostgroup_model/graph_hostgroup_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/garaph_hostgroup_model/graph_hostgroup_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/garaph_hostgroup_model/graph_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_hostgroup_request_model/overview_hostgroup_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_hostgroup_request_model/overview_hostgroup_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_hostgroup_request_model/overview_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_hostgroup_request_model.dart/scripts_hostgroup_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_hostgroup_request_model.dart/scripts_hostgroup_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_hostgroup_request_model.dart/scripts_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/first_event_model/first_event_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/first_event_model/first_event_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/first_event_model/first_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/login_model/login_request_model.dart';

import 'package:Zabbix/zabbix_bloc/data/models/login_model/login_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/second_event_model/second_event_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/second_event_model/second_event_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/second_event_model/second_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_request.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/host_trigger_model/host_trigger_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/host_trigger_model/host_trigger_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/host_trigger_model/host_trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_response_model.dart';

class ZabbixApiService {
  List eventids = [];

  Future<LoginResponseModel> login(loginRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? apiUrl = UrlApiPreferences.getUrlApi();
    String? login = UserPreferences.getUsername();
    String password = PasswordPreferences.getPassword() ?? '';
    LoginRequestModel loginRequestModel =
        LoginRequestModel(password: '$password', login: '$login');

    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(loginRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['result'];
      localStorage.setString('auth', data.toString());
      return LoginResponseModel.fromJson(json.decode(response.body));
    } else {
      throw 'failed';
    }
  }

  Future<List<TriggerResultModel>> trigger(triggerRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    TriggerRequestModel triggerRequestModel =
        TriggerRequestModel(auth_triger: '$auth');

    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(triggerRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<TriggerResultModel> triggerResult =
          (TriggerResponseModel.fromJson(data).triggerResult);
      return triggerResult;
    } else {
      throw Exception('');
    }
  }

  Future<List<FirstEventResultModel>> firstEvents(
      firstEventRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    dateTimeTo() {
      if (localStorage.getInt('dateTimeTo') == null) {
        DateTime.now().millisecondsSinceEpoch ~/ 1000;
      } else {
        int? dateTimeToResolved = localStorage.getInt('dateTimeTo') as int?;
        int dateTimeTo = dateTimeToResolved! ~/ 1000;
        return dateTimeTo;
      }
    }

    dateTimeFrom() {
      if (localStorage.getInt('dateTimeFrom') == null) {
        (DateTime.now().millisecondsSinceEpoch - 21600000) ~/ 1000;
      } else {
        int? dateTimeFromResolved = localStorage.getInt('dateTimeFrom') as int?;
        int dateTimeFrom = dateTimeFromResolved! ~/ 1000;
        return dateTimeFrom;
      }
    }

    FirstEventRequestModel firstEventRequestModel = FirstEventRequestModel(
        first_auth_event: '$auth',
        time_till: '${dateTimeTo()}',
        time_from: '${dateTimeFrom()}');

    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(firstEventRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<FirstEventResultModel> firstEventResult =
          (FirstEventResponseModel.fromJson(data).firstEventResult);
      List listData = data['result'];
      for (int i = 0; i <= listData.length - 1; ++i)
        eventids.add(listData[i]['r_eventid']);
      return firstEventResult;
    } else {
      throw Exception('');
    }
  }

  Future<List<SecondEventResultModel>> secondEvents(
      secondEventRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();

    SecondEventRequestModel secondEventRequestModel =
        SecondEventRequestModel(second_auth_event: '$auth', eventids: eventids);
    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(secondEventRequestModel.toJson()),
    );
    eventids.clear();
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<SecondEventResultModel> secondEventResult =
          (SecondEventResponseModel.fromJson(data).secondEventResult);
      return secondEventResult;
    } else {
      throw Exception('');
    }
  }

  Future<List<HostgroupResultModel>> hostgroup(hostgroupRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    HostgroupRequestModel hostgroupRequestModel =
        HostgroupRequestModel(auth_hostgroup: '$auth');
    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(hostgroupRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<HostgroupResultModel> hostgroupResult =
          (HostgroupResponseModel.fromJson(data).hostgroupResult);
      return hostgroupResult;
    } else {
      throw Exception('');
    }
  }

  Future<List<HostTriggerResultModel>> hostTrigger(
      hostTriggerRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    HostTriggerRequestModel hostTriggerRequestModel =
        HostTriggerRequestModel(host_trigger_auth: '$auth');
    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(hostTriggerRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<HostTriggerResultModel> hostTriggerResult =
          (HostTriggerResponseModel.fromJson(data).hostTriggerResult);
      return hostTriggerResult;
    } else {
      throw Exception('');
    }
  }

  Future<List<GraphHostgroupResultModel>> graphHostgroup(
      graphHostgroupRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    GraphHostgroupRequestModel graphHostgroupRequestModel =
        GraphHostgroupRequestModel(auth_hostgroup_graph: '$auth');
    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(graphHostgroupRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<GraphHostgroupResultModel> graphHostgroupResult =
          (GraphHostgroupResponseModel.fromJson(data).graphHostgroupResult);

      return graphHostgroupResult;
    } else {
      throw Exception('');
    }
  }

  Future<List<OverviewHostgroupResultModel>> overviewHostgroup(
      overviewHostgroupRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    OverviewHostgroupRequestModel overviewHostgroupRequestModel =
        OverviewHostgroupRequestModel(auth_hostgroup_overview: '$auth');
    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(overviewHostgroupRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<OverviewHostgroupResultModel> overviewHostgroupResult =
          (OverviewHostgroupResponseModel.fromJson(data)
              .overviewHostgroupResult);
      return overviewHostgroupResult;
    } else {
      throw Exception('');
    }
  }

  Future<List<ScriptsHostgroupResultModel>> scriptsHostgroup(
      scriptsHostgroupRequestModel) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    String? auth = localStorage.getString('auth');
    String? apiUrl = UrlApiPreferences.getUrlApi();
    ScriptsHostgroupRequestModel scriptsHostgroupRequestModel =
        ScriptsHostgroupRequestModel(auth_hostgroup: '$auth');
    Uri url = Uri.parse('$apiUrl');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json-rpc"},
      body: jsonEncode(scriptsHostgroupRequestModel.toJson()),
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      List<ScriptsHostgroupResultModel> scriptsHostgroupResult =
          (ScriptsHostgroupResponseModel.fromJson(data).scriptsHostgroupResult);
      return scriptsHostgroupResult;
    } else {
      throw Exception('');
    }
  }
}
