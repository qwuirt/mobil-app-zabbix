import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_host_model.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_last_event_model.dart';
part 'trigger_result_model.g.dart';


@JsonSerializable()
class TriggerResultModel {
  @JsonKey(name: 'triggerid')
  final String triggerid;
  @JsonKey(name: 'description')
  final String description;
  @JsonKey(name: 'priority')
  final String priority;
  @JsonKey(name: 'value')
  final String value;
  @JsonKey(name: 'manual_close')
  final String manual_close;
  @JsonKey(name: 'hosts')
  final List<TriggerHostsModel> triggerHosts;
  @JsonKey(name: 'lastEvent')
  final TriggerLastEventModel triggerLastEvent;

  TriggerResultModel({
    required this.triggerid,
    required this.description,
    required this.value,
    required this.priority,
    required this.manual_close,
    required this.triggerHosts,
    required this.triggerLastEvent,
  });

  factory TriggerResultModel.fromJson(Map<String, dynamic> json) => _$TriggerResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerResultModelToJson(this);

}


