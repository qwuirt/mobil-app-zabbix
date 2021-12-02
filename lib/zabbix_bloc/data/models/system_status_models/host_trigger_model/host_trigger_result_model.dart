import 'package:json_annotation/json_annotation.dart';

import 'host_trigger_groups_model.dart';
import 'host_trigger_hosts_model.dart';
import 'host_trigger_last_event_model.dart';

part 'host_trigger_result_model.g.dart';

@JsonSerializable()
class HostTriggerResultModel {
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
  final List<HostTriggerHostsModel> triggerHosts;
  @JsonKey(name: 'lastEvent')
  final HostTriggerLastEventModel triggerLastEvent;
  @JsonKey(name: 'groups')
  final List<HostTriggerGroupsModel> triggerGroups;



  HostTriggerResultModel({
    required this.triggerid,
    required this.description,
    required this.value,
    required this.priority,
    required this.manual_close,
    required this.triggerHosts,
    required this.triggerLastEvent,
    required this.triggerGroups,
  });

  factory HostTriggerResultModel.fromJson(Map<String, dynamic> json) => _$HostTriggerResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$HostTriggerResultModelToJson(this);

}