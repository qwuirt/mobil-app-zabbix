// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_trigger_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostTriggerResultModel _$HostTriggerResultModelFromJson(
    Map<String, dynamic> json) {
  return HostTriggerResultModel(
    triggerid: json['triggerid'] as String,
    description: json['description'] as String,
    value: json['value'] as String,
    priority: json['priority'] as String,
    manual_close: json['manual_close'] as String,
    triggerHosts: (json['hosts'] as List<dynamic>)
        .map((e) => HostTriggerHostsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    triggerLastEvent: HostTriggerLastEventModel.fromJson(
        json['lastEvent'] as Map<String, dynamic>),
    triggerGroups: (json['groups'] as List<dynamic>)
        .map((e) => HostTriggerGroupsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HostTriggerResultModelToJson(
        HostTriggerResultModel instance) =>
    <String, dynamic>{
      'triggerid': instance.triggerid,
      'description': instance.description,
      'priority': instance.priority,
      'value': instance.value,
      'manual_close': instance.manual_close,
      'hosts': instance.triggerHosts,
      'lastEvent': instance.triggerLastEvent,
      'groups': instance.triggerGroups,
    };
