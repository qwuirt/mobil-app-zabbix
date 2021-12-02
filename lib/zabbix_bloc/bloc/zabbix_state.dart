import 'package:equatable/equatable.dart';
import 'package:Zabbix/zabbix_bloc/data/models/first_event_model/first_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/garaph_hostgroup_model/graph_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_host_model/graph_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/graph_models/graph_model/graph_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/login_model/login_response_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/item_history_model/item_history_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_host_model/overview_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_hostgroup_request_model/overview_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/overview_models/overview_item_model/overview_item_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/check_problem_event_model/check_problem_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/confirmation_problem_model/confirmation_problem_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/problem_event_model/problem_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_execute_model/script_execute_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/script_model/script_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_host_model/scripts_host_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_hostgroup_request_model.dart/scripts_hostgroup_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/second_event_model/second_event_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/host_trigger_model/host_trigger_result_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_result_model.dart';

abstract class ZabbixState extends Equatable {}

class ZabbixInitialState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixLoginLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixLoginLoadedState extends ZabbixState {
  LoginResponseModel loginResponse;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixLoginLoadedState({
    required this.loginResponse,
    required this.triggerResult,
    required this.hostgroupResult,
    required this.hostTriggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixLoginErrorState extends ZabbixState {
  String message;

  ZabbixLoginErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixLoadedState extends ZabbixState {
  List<TriggerResultModel> triggerResult;

  ZabbixLoadedState({
    required this.triggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixErrorState extends ZabbixState {
  String message;

  ZabbixErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixSettingLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixSettingLoadedState extends ZabbixState {
  LoginResponseModel loginResponse;
  List<TriggerResultModel> triggerResult;

  ZabbixSettingLoadedState({
    required this.loginResponse,
    required this.triggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixSettingErrorState extends ZabbixState {
  String message;

  ZabbixSettingErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixProblemLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixProblemLoadedState extends ZabbixState {
  List<TriggerResultModel> triggerResult;
  List<ProblemEventResultModel> problemEventResult;

  ZabbixProblemLoadedState({
    required this.triggerResult,
    required this.problemEventResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixProblemErrorState extends ZabbixState {
  String message;

  ZabbixProblemErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixCheckProblemLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixCheckProblemLoadedState extends ZabbixState {
  List<ProblemEventResultModel> problemEventResult;
  List<CheckProblemEventResultModel> checkProblemEventResult;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixCheckProblemLoadedState({
    required this.problemEventResult,
    required this.checkProblemEventResult,
    required this.triggerResult,
    required this.hostgroupResult,
    required this.hostTriggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixCheckProblemErrorState extends ZabbixState {
  String message;

  ZabbixCheckProblemErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixConfirmationProblemLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixConfirmationProblemLoadedState extends ZabbixState {
  List<ConfirmationProblemResultModel> confirmationProblemResult;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixConfirmationProblemLoadedState({
    required this.confirmationProblemResult,
    required this.triggerResult,
    required this.hostTriggerResult,
    required this.hostgroupResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixConfirmationProblemErrorState extends ZabbixState {
  String message;

  ZabbixConfirmationProblemErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixResolvedProblemLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixResolvedProblemLoadedState extends ZabbixState {
  List<FirstEventResultModel> firstEventResult;
  List<SecondEventResultModel> secondEventResult;
  List<TriggerResultModel> triggerResult;

  ZabbixResolvedProblemLoadedState({
    required this.firstEventResult,
    required this.secondEventResult,
    required this.triggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixResolvedProblemErrorState extends ZabbixState {
  String message;

  ZabbixResolvedProblemErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixSystemStatusLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixSystemStatusLoadedState extends ZabbixState {
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;
  List<TriggerResultModel> triggerResult;

  ZabbixSystemStatusLoadedState({
    required this.hostgroupResult,
    required this.hostTriggerResult,
    required this.triggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixSystemStatusErrorState extends ZabbixState {
  String message;

  ZabbixSystemStatusErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixGraphLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixGraphLoadedState extends ZabbixState {
  List<GraphHostgroupResultModel> graphHostgroupResult;
  List<GraphHostResultModel> graphHostResult;
  List<GraphResultModel> graphResult;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixGraphLoadedState({
    required this.graphHostgroupResult,
    required this.graphHostResult,
    required this.graphResult,
    required this.triggerResult,
    required this.hostgroupResult,
    required this.hostTriggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixGraphErrorState extends ZabbixState {
  String message;

  ZabbixGraphErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixOverviewLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixOverviewLoadedState extends ZabbixState {
  List<OverviewHostgroupResultModel> overviewHostgroupResult;
  List<OverviewHostResultModel> overviewHostResult;
  List<OverviewItemResultModel> overviewItemResult;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixOverviewLoadedState({
    required this.overviewHostgroupResult,
    required this.overviewHostResult,
    required this.overviewItemResult,
    required this.triggerResult,
    required this.hostgroupResult,
    required this.hostTriggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixOverviewErrorState extends ZabbixState {
  String message;

  ZabbixOverviewErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixHistoryOverviewLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixHistoryOverviewLoadedState extends ZabbixState {
  List<ItemHistoryResultModel> itemHistoryResult;
  List<OverviewHostgroupResultModel> overviewHostgroupResult;
  List<OverviewHostResultModel> overviewHostResult;
  List<OverviewItemResultModel> overviewItemResult;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixHistoryOverviewLoadedState({
    required this.itemHistoryResult,
    required this.overviewHostgroupResult,
    required this.overviewHostResult,
    required this.overviewItemResult,
    required this.triggerResult,
    required this.hostgroupResult,
    required this.hostTriggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixHistoryOverviewErrorState extends ZabbixState {
  String message;

  ZabbixHistoryOverviewErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixScriptsLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixScriptsLoadedState extends ZabbixState {
  List<ScriptsHostgroupResultModel> scriptsHostgroupResult;
  List<ScriptsHostResultModel> scriptsHostResult;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixScriptsLoadedState({
    required this.scriptsHostgroupResult,
    required this.scriptsHostResult,
    required this.triggerResult,
    required this.hostTriggerResult,
    required this.hostgroupResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixScriptsErrorState extends ZabbixState {
  String message;

  ZabbixScriptsErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixScriptDetailLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixScriptDetailLoadedState extends ZabbixState {
  List<ScriptResultModel> scriptResult;
  List<ScriptsHostgroupResultModel> scriptsHostgroupResult;
  List<ScriptsHostResultModel> scriptsHostResult;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixScriptDetailLoadedState({
    required this.scriptResult,
    required this.scriptsHostgroupResult,
    required this.scriptsHostResult,
    required this.triggerResult,
    required this.hostgroupResult,
    required this.hostTriggerResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixScriptDetailErrorState extends ZabbixState {
  String message;

  ZabbixScriptDetailErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixScriptExecuteLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixScriptExecuteLoadedState extends ZabbixState {
  List<ScriptExecuteResultModel> scriptExecuteResult;
  List<ScriptsHostgroupResultModel> scriptsHostgroupResult;
  List<ScriptsHostResultModel> scriptsHostResult;
  List<ScriptResultModel> scriptResult;
  List<TriggerResultModel> triggerResult;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;

  ZabbixScriptExecuteLoadedState({
    required this.scriptExecuteResult,
    required this.scriptResult,
    required this.scriptsHostgroupResult,
    required this.scriptsHostResult,
    required this.triggerResult,
    required this.hostTriggerResult,
    required this.hostgroupResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixScriptExecuteErrorState extends ZabbixState {
  String message;

  ZabbixScriptExecuteErrorState({required this.message});

  @override
  List<Object> get props => [message];
}

class ZabbixAllLoadingState extends ZabbixState {
  @override
  List<Object> get props => [];
}

class ZabbixAllLoadedState extends ZabbixState {
  List<TriggerResultModel> triggerResult;
  LoginResponseModel loginResponse;
  List<HostgroupResultModel> hostgroupResult;
  List<HostTriggerResultModel> hostTriggerResult;
  List<ProblemEventResultModel> problemEventResult;
  List<FirstEventResultModel> firstEventResult;
  List<SecondEventResultModel> secondEventResult;
  List<GraphHostgroupResultModel> graphHostgroupResult;
  List<GraphHostResultModel> graphHostResult;
  List<OverviewHostgroupResultModel> overviewHostgroupResult;
  List<OverviewHostResultModel> overviewHostResult;
  List<ScriptsHostgroupResultModel> scriptsHostgroupResult;
  List<ScriptsHostResultModel> scriptsHostResult;
  List<CheckProblemEventResultModel> checkProblemEventResult;

  ZabbixAllLoadedState({
    required this.triggerResult,
    required this.firstEventResult,
    required this.hostgroupResult,
    required this.hostTriggerResult,
    required this.secondEventResult,
    required this.graphHostgroupResult,
    required this.graphHostResult,
    required this.loginResponse,
    required this.overviewHostgroupResult,
    required this.overviewHostResult,
    required this.problemEventResult,
    required this.scriptsHostgroupResult,
    required this.scriptsHostResult,
    required this.checkProblemEventResult,
  });

  @override
  List<Object> get props => [];
}

class ZabbixAllErrorState extends ZabbixState {
  String message;

  ZabbixAllErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
