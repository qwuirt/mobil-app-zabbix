import 'package:equatable/equatable.dart';

abstract class ZabbixEvent extends Equatable{}

class ZabbixLoginLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixSettingLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixProblemLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixCheckProblemLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixConfirmationProblemLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixResolvedProblemLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixSystemStatusLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixGraphLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => throw [];
}


class ZabbixOverviewLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixHistoryOverviewLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixScriptsLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixScriptDetailLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixScriptExecuteLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixScriptExecuteErrorLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}


class ZabbixAllLoadEvent extends ZabbixEvent {
  @override
  List<Object?> get props => [];
}
