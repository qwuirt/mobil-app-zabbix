import 'package:bloc/bloc.dart';

import 'package:Zabbix/zabbix_bloc/bloc/zabbix_event.dart';
import 'package:Zabbix/zabbix_bloc/bloc/zabbix_state.dart';
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
import 'package:Zabbix/zabbix_bloc/data/repositories/zabbix_repository.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_result_model.dart';

class ZabbixBloc extends Bloc<ZabbixEvent, ZabbixState> {
  late ZabbixRepository zabbixRepository;

  ZabbixBloc({required this.zabbixRepository}) : super(ZabbixInitialState());

  @override
  ZabbixState get initialState => ZabbixInitialState();

  @override
  Stream<ZabbixState> mapEventToState(ZabbixEvent event) async* {
    if (event is ZabbixLoginLoadEvent) {
      yield* _loginLoadEvent(event);
    } else if (event is ZabbixSettingLoadEvent) {
      yield* _settingLoadEvent(event);
    } else if (event is ZabbixLoadEvent) {
      yield* _zabbixLoadEvent(event);
    } else if (event is ZabbixProblemLoadEvent) {
      yield* _problemLoadEvent(event);
    } else if (event is ZabbixResolvedProblemLoadEvent) {
      yield* _resolvedProblemLoadEvent(event);
    } else if (event is ZabbixSystemStatusLoadEvent) {
      yield* _systemStatusLoadEvent(event);
    } else if (event is ZabbixGraphLoadEvent) {
      yield* _graphLoadEvent(event);
    } else if (event is ZabbixOverviewLoadEvent) {
      yield* _overviewLoadEvent(event);
    } else if (event is ZabbixHistoryOverviewLoadEvent) {
      yield* _overviewHistoryLoadEvent(event);
    } else if (event is ZabbixScriptsLoadEvent) {
      yield* _scriptLoadEvent(event);
    } else if (event is ZabbixScriptDetailLoadEvent) {
      yield* _scriptDetailLoadEvent(event);
    } else if (event is ZabbixScriptExecuteLoadEvent) {
      yield* _scriptExecuteLoadEvent(event);
    } else if (event is ZabbixCheckProblemLoadEvent) {
      yield* _checkProblemLoadEvent(event);
    } else if (event is ZabbixConfirmationProblemLoadEvent) {
      yield* _confirmationProblemLoadEvent(event);
    } else if (event is ZabbixAllLoadEvent) {
      yield* _allLoadEvent(event);
    }
  }

  Stream<ZabbixState> _loginLoadEvent(ZabbixLoginLoadEvent event) async* {
    yield ZabbixLoginLoadingState();
    try {
      final LoginResponseModel loginResponse =
          await zabbixRepository.getLogin();
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixLoginLoadedState(
          loginResponse: loginResponse,
          triggerResult: triggerResult,
          hostgroupResult: hostgroupResult,
          hostTriggerResult: hostTriggerResult);
    } catch (e) {
      yield ZabbixLoginErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _zabbixLoadEvent(ZabbixLoadEvent event) async* {
    yield ZabbixLoadingState();
    try {
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      yield ZabbixLoadedState(
        triggerResult: triggerResult,
      );
    } catch (e) {
      yield ZabbixErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _settingLoadEvent(ZabbixSettingLoadEvent event) async* {
    yield ZabbixSettingLoadingState();
    try {
      final LoginResponseModel loginResponse =
          await zabbixRepository.getLogin();
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      yield ZabbixSettingLoadedState(
        loginResponse: loginResponse,
        triggerResult: triggerResult,
      );
    } catch (e) {
      yield ZabbixSettingErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _problemLoadEvent(ZabbixProblemLoadEvent event) async* {
    yield ZabbixProblemLoadingState();
    try {
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<ProblemEventResultModel> problemEventResult =
          (await zabbixRepository.getProblemEvent());
      yield ZabbixProblemLoadedState(
        triggerResult: triggerResult,
        problemEventResult: problemEventResult,
      );
    } catch (e) {
      yield ZabbixProblemErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _checkProblemLoadEvent(
      ZabbixCheckProblemLoadEvent event) async* {
    yield ZabbixCheckProblemLoadingState();
    try {
      final List<ProblemEventResultModel> problemEventResult =
          (await zabbixRepository.getProblemEvent());
      final List<CheckProblemEventResultModel> checkProblemEventResult =
          (await zabbixRepository.getCheckProblemEvent());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixCheckProblemLoadedState(
        problemEventResult: problemEventResult,
        checkProblemEventResult: checkProblemEventResult,
        triggerResult: triggerResult,
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
      );
    } catch (e) {
      yield ZabbixCheckProblemErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _confirmationProblemLoadEvent(
      ZabbixConfirmationProblemLoadEvent event) async* {
    yield ZabbixConfirmationProblemLoadingState();
    try {
      final List<ConfirmationProblemResultModel> confirmationProblemResult =
          (await zabbixRepository.getConfirmationProblem());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixConfirmationProblemLoadedState(
        confirmationProblemResult: confirmationProblemResult,
        triggerResult: triggerResult,
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
      );
    } catch (e) {
      yield ZabbixConfirmationProblemErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _resolvedProblemLoadEvent(
      ZabbixResolvedProblemLoadEvent event) async* {
    yield ZabbixResolvedProblemLoadingState();
    try {
      final List<FirstEventResultModel> firstEventResult =
          (await zabbixRepository.getFirstEvents());
      final List<SecondEventResultModel> secondEventResult =
          (await zabbixRepository.getSecondEvents());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());

      yield ZabbixResolvedProblemLoadedState(
        firstEventResult: firstEventResult,
        secondEventResult: secondEventResult,
        triggerResult: triggerResult,
      );
    } catch (e) {
      yield ZabbixResolvedProblemErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _systemStatusLoadEvent(
      ZabbixSystemStatusLoadEvent event) async* {
    yield ZabbixSystemStatusLoadingState();
    try {
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      yield ZabbixSystemStatusLoadedState(
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
        triggerResult: triggerResult,
      );
    } catch (e) {
      yield ZabbixSystemStatusErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _graphLoadEvent(ZabbixGraphLoadEvent event) async* {
    yield ZabbixGraphLoadingState();
    try {
      final List<GraphHostgroupResultModel> graphHostgroupResult =
          (await zabbixRepository.getGraphHostgroup());
      final List<GraphHostResultModel> graphHostResult =
          (await zabbixRepository.getGraphHost());
      final List<GraphResultModel> graphResult =
          (await zabbixRepository.getGraph());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixGraphLoadedState(
        graphHostgroupResult: graphHostgroupResult,
        graphHostResult: graphHostResult,
        graphResult: graphResult,
        triggerResult: triggerResult,
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
      );
    } catch (e) {
      yield ZabbixGraphErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _overviewLoadEvent(ZabbixOverviewLoadEvent event) async* {
    yield ZabbixOverviewLoadingState();
    try {
      final List<OverviewHostgroupResultModel> overviewHostgroupResult =
          (await zabbixRepository.getOverviewHostgroup());
      final List<OverviewHostResultModel> overviewHostResult =
          (await zabbixRepository.getOverviewHost());
      final List<OverviewItemResultModel> overviewItemResult =
          (await zabbixRepository.getOverviewItem());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixOverviewLoadedState(
        overviewHostgroupResult: overviewHostgroupResult,
        overviewHostResult: overviewHostResult,
        overviewItemResult: overviewItemResult,
        triggerResult: triggerResult,
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
      );
    } catch (e) {
      yield ZabbixOverviewErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _overviewHistoryLoadEvent(
      ZabbixHistoryOverviewLoadEvent event) async* {
    yield ZabbixHistoryOverviewLoadingState();
    try {
      final List<ItemHistoryResultModel> itemHistoryResult =
          (await zabbixRepository.getHistoryOverview());
      final List<OverviewHostgroupResultModel> overviewHostgroupResult =
          (await zabbixRepository.getOverviewHostgroup());
      final List<OverviewHostResultModel> overviewHostResult =
          (await zabbixRepository.getOverviewHost());
      final List<OverviewItemResultModel> overviewItemResult =
          (await zabbixRepository.getOverviewItem());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixHistoryOverviewLoadedState(
        itemHistoryResult: itemHistoryResult,
        overviewHostgroupResult: overviewHostgroupResult,
        overviewHostResult: overviewHostResult,
        overviewItemResult: overviewItemResult,
        triggerResult: triggerResult,
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
      );
    } catch (e) {
      yield ZabbixHistoryOverviewErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _scriptLoadEvent(ZabbixScriptsLoadEvent event) async* {
    yield ZabbixScriptsLoadingState();
    try {
      final List<ScriptsHostgroupResultModel> scriptsHostgroupResult =
          (await zabbixRepository.getScriptsHostgroup());
      final List<ScriptsHostResultModel> scriptsHostResult =
          (await zabbixRepository.getScriptsHost());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixScriptsLoadedState(
        scriptsHostgroupResult: scriptsHostgroupResult,
        scriptsHostResult: scriptsHostResult,
        triggerResult: triggerResult,
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
      );
    } catch (e) {
      yield ZabbixScriptsErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _scriptDetailLoadEvent(
      ZabbixScriptDetailLoadEvent event) async* {
    yield ZabbixScriptDetailLoadingState();
    try {
      final List<ScriptResultModel> scriptResult =
          (await zabbixRepository.getScripts());
      final List<ScriptsHostgroupResultModel> scriptsHostgroupResult =
          (await zabbixRepository.getScriptsHostgroup());
      final List<ScriptsHostResultModel> scriptsHostResult =
          (await zabbixRepository.getScriptsHost());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixScriptDetailLoadedState(
        scriptResult: scriptResult,
        scriptsHostgroupResult: scriptsHostgroupResult,
        scriptsHostResult: scriptsHostResult,
        triggerResult: triggerResult,
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
      );
    } catch (e) {
      yield ZabbixScriptDetailErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _scriptExecuteLoadEvent(
      ZabbixScriptExecuteLoadEvent event) async* {
    yield ZabbixScriptExecuteLoadingState();
    try {
      final List<ScriptExecuteResultModel> scriptExecuteResult =
          (await zabbixRepository.getScriptExecute());
      final List<ScriptsHostgroupResultModel> scriptsHostgroupResult =
          (await zabbixRepository.getScriptsHostgroup());
      final List<ScriptsHostResultModel> scriptsHostResult =
          (await zabbixRepository.getScriptsHost());
      final List<ScriptResultModel> scriptResult =
          (await zabbixRepository.getScripts());
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      yield ZabbixScriptExecuteLoadedState(
        scriptExecuteResult: scriptExecuteResult,
        scriptsHostgroupResult: scriptsHostgroupResult,
        scriptsHostResult: scriptsHostResult,
        scriptResult: scriptResult,
        triggerResult: triggerResult,
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
      );
    } catch (e) {
      yield ZabbixScriptExecuteErrorState(message: e.toString());
    }
  }

  Stream<ZabbixState> _allLoadEvent(ZabbixAllLoadEvent event) async* {
    yield ZabbixAllLoadingState();
    try {
      final LoginResponseModel loginResponse =
          await zabbixRepository.getLogin();
      final List<TriggerResultModel> triggerResult =
          (await zabbixRepository.getTriggerid());
      final List<HostgroupResultModel> hostgroupResult =
          (await zabbixRepository.getHostgroup());
      final List<HostTriggerResultModel> hostTriggerResult =
          (await zabbixRepository.getHostTrigger());
      final List<ProblemEventResultModel> problemEventResult =
          (await zabbixRepository.getProblemEvent());
      final List<FirstEventResultModel> firstEventResult =
          (await zabbixRepository.getFirstEvents());
      final List<SecondEventResultModel> secondEventResult =
          (await zabbixRepository.getSecondEvents());
      final List<GraphHostgroupResultModel> graphHostgroupResult =
          (await zabbixRepository.getGraphHostgroup());
      final List<GraphHostResultModel> graphHostResult =
          (await zabbixRepository.getGraphHost());
      final List<OverviewHostgroupResultModel> overviewHostgroupResult =
          (await zabbixRepository.getOverviewHostgroup());
      final List<OverviewHostResultModel> overviewHostResult =
          (await zabbixRepository.getOverviewHost());
      final List<ScriptsHostgroupResultModel> scriptsHostgroupResult =
          (await zabbixRepository.getScriptsHostgroup());
      final List<ScriptsHostResultModel> scriptsHostResult =
          (await zabbixRepository.getScriptsHost());
      final List<CheckProblemEventResultModel> checkProblemEventResult =
          (await zabbixRepository.getCheckProblemEvent());

      yield ZabbixAllLoadedState(
        hostgroupResult: hostgroupResult,
        hostTriggerResult: hostTriggerResult,
        problemEventResult: problemEventResult,
        firstEventResult: firstEventResult,
        secondEventResult: secondEventResult,
        graphHostgroupResult: graphHostgroupResult,
        graphHostResult: graphHostResult,
        overviewHostgroupResult: overviewHostgroupResult,
        overviewHostResult: overviewHostResult,
        triggerResult: triggerResult,
        loginResponse: loginResponse,
        scriptsHostResult: scriptsHostResult,
        scriptsHostgroupResult: scriptsHostgroupResult,
        checkProblemEventResult: checkProblemEventResult,
      );
    } catch (e) {
      yield ZabbixAllErrorState(message: e.toString());
    }
  }
}
