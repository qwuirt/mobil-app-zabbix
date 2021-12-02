// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_last_event_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriggerLastEventModel _$TriggerLastEventModelFromJson(
    Map<String, dynamic> json) {
  return TriggerLastEventModel(
    eventid: json['eventid'] as String,
    source: json['source'] as String,
    object: json['object'] as String,
    objectid: json['objectid'] as String,
    clock: json['clock'] as String,
    value: json['value'] as String,
    acknowledged: json['acknowledged'] as String,
    ns: json['ns'] as String,
    name: json['name'] as String,
    severity: json['severity'] as String,
  );
}

Map<String, dynamic> _$TriggerLastEventModelToJson(
        TriggerLastEventModel instance) =>
    <String, dynamic>{
      'eventid': instance.eventid,
      'source': instance.source,
      'object': instance.object,
      'objectid': instance.objectid,
      'clock': instance.clock,
      'value': instance.value,
      'acknowledged': instance.acknowledged,
      'ns': instance.ns,
      'name': instance.name,
      'severity': instance.severity,
    };
