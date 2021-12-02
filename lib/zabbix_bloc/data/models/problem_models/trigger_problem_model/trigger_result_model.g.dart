// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriggerResultModel _$TriggerResultModelFromJson(Map<String, dynamic> json) {
  return TriggerResultModel(
    triggerid: json['triggerid'] as String,
    description: json['description'] as String,
    value: json['value'] as String,
    priority: json['priority'] as String,
    manual_close: json['manual_close'] as String,
    triggerHosts: (json['hosts'] as List<dynamic>)
        .map((e) => TriggerHostsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    triggerLastEvent: TriggerLastEventModel.fromJson(
        json['lastEvent'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$TriggerResultModelToJson(TriggerResultModel instance) =>
    <String, dynamic>{
      'triggerid': instance.triggerid,
      'description': instance.description,
      'priority': instance.priority,
      'value': instance.value,
      'manual_close': instance.manual_close,
      'hosts': instance.triggerHosts,
      'lastEvent': instance.triggerLastEvent,
    };
