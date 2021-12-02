
import 'package:Zabbix/zabbix_bloc/data/models/first_event_model/first_event_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/first_event_model/first_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/garaph_hostgroup_model/graph_hostgroup_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/garaph_hostgroup_model/graph_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_host_model/graph_host_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_host_model/graph_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_model/graph_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_model/graph_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/login_model/login_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/login_model/login_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/item_history_model/item_history_request.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/item_history_model/item_history_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_host_model/overview_host_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_host_model/overview_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_hostgroup_request_model/overview_hostgroup_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_hostgroup_request_model/overview_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_item_model/overview_item_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_item_model/overview_item_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/check_problem_event_model/check_problem_event_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/check_problem_event_model/check_problem_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/confirmation_problem_model/confirmation_problem_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/confirmation_problem_model/confirmation_problem_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/problem_event_model/problem_event_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/problem_event_model/problem_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_execute_model/script_execute_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_execute_model/script_execute_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_model/script_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_model/script_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_host_model/scripts_host_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_host_model/scripts_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_hostgroup_request_model.dart/scripts_hostgroup_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_hostgroup_request_model.dart/scripts_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/second_event_model/second_event_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/second_event_model/second_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_request.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/host_trigger_model/host_trigger_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/host_trigger_model/host_trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/repositories/zabbix_response.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_request_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_graph/graph_host_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_graph/graphs_hostgroup_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_overview/overview_host_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_overview/overview_hostgroup_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_overview/overview_last_value_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_problem/confirmation_problem_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_problem/problem_event.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_problem/problem_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_scripts/script_execute_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_scripts/scripts_host_page.dart';
import 'package:Zabbix/zabbix_bloc/ui/ui_scripts/scripts_hostgroup_page.dart';

class ZabbixRepository {
  ZabbixApiService zabbixApiService = ZabbixApiService();

  LoginRequestModel loginRequestModel = LoginRequestModel(password: '', login: '');
  TriggerRequestModel triggerRequestModel = TriggerRequestModel(auth_triger: '');
  ProblemEventRequestModel problemEventRequestModel = ProblemEventRequestModel(auth_problem: '', trigger: '');
  CheckProblemEventRequestModel checkProblemEventRequestModel = CheckProblemEventRequestModel(auth_problem: '', eventids: '');
  ConfirmationProblemRequestModel confirmationProblemRequestModel = ConfirmationProblemRequestModel(auth_problem: '', message: '', action: '', eventid: '');
  FirstEventRequestModel firstEventRequestModel = FirstEventRequestModel(first_auth_event: '', time_from: '', time_till: '');
  SecondEventRequestModel secondEventRequestModel = SecondEventRequestModel(second_auth_event: '', eventids: [],);
  HostgroupRequestModel hostgroupRequestModel = HostgroupRequestModel(auth_hostgroup: '');
  HostTriggerRequestModel hostTriggerRequestModel = HostTriggerRequestModel(host_trigger_auth: '');
  GraphHostgroupRequestModel graphHostgroupRequestModel = GraphHostgroupRequestModel(auth_hostgroup_graph: '');
  GraphHostRequestModel graphHostRequestModel = GraphHostRequestModel(auth_host_graph: '', groupids: '');
  GraphRequestModel graphRequestModel = GraphRequestModel(auth_graph: '', hostids: '');
  OverviewHostgroupRequestModel overviewHostgroupRequestModel = OverviewHostgroupRequestModel(auth_hostgroup_overview: '');
  OverviewHostRequestModel overviewHostRequestModel = OverviewHostRequestModel(auth_host_overview: '', groupids: '');
  ItemHistoryRequestModel itemHistoryRequestModel = ItemHistoryRequestModel(auth: '', itemid: '', history: '', time_from: '');
  OverviewItemRequestModel overviewItemRequestModel = OverviewItemRequestModel(auth_overview: '', hostids: '');
  ScriptsHostgroupRequestModel scriptsHostgroupRequestModel = ScriptsHostgroupRequestModel(auth_hostgroup: '');
  ScriptsHostRequestModel scriptsHostRequestModel = ScriptsHostRequestModel(auth_host: '', groupids: '');
  ScriptRequestModel scriptRequestModel = ScriptRequestModel(auth_script: '', hostids: '');
  ScriptExecuteRequestModel scriptExecuteRequestModel = ScriptExecuteRequestModel(auth_script: '', hostids: '', scriptid: '');

  OverviewHostgroupPage overviewHostgroupPage = OverviewHostgroupPage();
  OverviewHostPage overviewHostPage = OverviewHostPage(title: '',);
  OverviewLastValuePage overviewLastValuePage = OverviewLastValuePage(title: '',);
  GraphsHostgroupPage graphsHostgroupPage = GraphsHostgroupPage();
  GraphHostPage graphsHostPage = GraphHostPage(title: '',);
  ScriptsHostgroupPage scriptsHostgroupPage = ScriptsHostgroupPage();
  ScriptsHostPage scriptsHostPage = ScriptsHostPage(title: '',);
  ScriptsExecutePage scriptsExecutePage = ScriptsExecutePage(title: '',);
  ProblemPage problemPage = ProblemPage();
  ProblemEventPage problemEventPage = ProblemEventPage(title: '',);
  ConfirmationProblemPage confirmationProblemPage = ConfirmationProblemPage(title: '', manual_close: '', eventid: '',);


  Future<LoginResponseModel> getLogin() =>
      zabbixApiService.login(loginRequestModel);

  Future<List<TriggerResultModel>> getTriggerid() =>
      zabbixApiService.trigger(triggerRequestModel);

  Future<List<ProblemEventResultModel>> getProblemEvent() =>
      problemPage.problemEvent(problemEventRequestModel);

  Future<List<CheckProblemEventResultModel>> getCheckProblemEvent() =>
      problemEventPage.checkProblemEvent(checkProblemEventRequestModel);

  Future<List<ConfirmationProblemResultModel>> getConfirmationProblem() =>
      confirmationProblemPage.confirmationProblem(confirmationProblemRequestModel);

  Future<List<FirstEventResultModel>> getFirstEvents() =>
      zabbixApiService.firstEvents(firstEventRequestModel);

  Future<List<SecondEventResultModel>> getSecondEvents() =>
      zabbixApiService.secondEvents(secondEventRequestModel);

  Future<List<HostgroupResultModel>> getHostgroup() =>
      zabbixApiService.hostgroup(hostgroupRequestModel);

  Future<List<HostTriggerResultModel>> getHostTrigger() =>
      zabbixApiService.hostTrigger(hostTriggerRequestModel);

  Future<List<GraphHostgroupResultModel>> getGraphHostgroup() =>
      zabbixApiService.graphHostgroup(graphHostgroupRequestModel);

  Future<List<GraphHostResultModel>> getGraphHost() =>
      graphsHostgroupPage.graphHost(graphHostRequestModel);
  Future<List<GraphResultModel>> getGraph() =>
      graphsHostPage.graph(graphRequestModel);

  Future<List<OverviewHostgroupResultModel>> getOverviewHostgroup() =>
      zabbixApiService.overviewHostgroup(overviewHostgroupRequestModel);

  Future<List<OverviewHostResultModel>> getOverviewHost() =>
      overviewHostgroupPage.overviewHost(overviewHostRequestModel);

  Future<List<OverviewItemResultModel>> getOverviewItem() =>
      overviewHostPage.overviewItem(overviewItemRequestModel);

  Future<List<ItemHistoryResultModel>> getHistoryOverview() =>
      overviewLastValuePage.overviewItemHistory(itemHistoryRequestModel);


  Future<List<ScriptsHostgroupResultModel>> getScriptsHostgroup() =>
      zabbixApiService.scriptsHostgroup(scriptsHostgroupRequestModel);

  Future<List<ScriptsHostResultModel>> getScriptsHost() =>
      scriptsHostgroupPage.scriptsHost(scriptsHostRequestModel);

  Future<List<ScriptResultModel>> getScripts() =>
      scriptsHostPage.scripts(scriptRequestModel);

  Future<List<ScriptExecuteResultModel>> getScriptExecute() =>
      scriptsExecutePage.scriptExecute(scriptExecuteRequestModel);


}