// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_event_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirstEventResultModel _$FirstEventResultModelFromJson(
    Map<String, dynamic> json) {
  return FirstEventResultModel(
    eventid: json['eventid'] as String,
    clock: json['clock'] as String,
    acknowledged: json['acknowledged'] as String,
    name: json['name'] as String,
    severity: json['severity'] as String,
    r_eventid: json['r_eventid'] as String,
    firstEventHosts: (json['hosts'] as List<dynamic>)
        .map((e) => FirstEventHostsModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FirstEventResultModelToJson(
        FirstEventResultModel instance) =>
    <String, dynamic>{
      'eventid': instance.eventid,
      'clock': instance.clock,
      'acknowledged': instance.acknowledged,
      'name': instance.name,
      'severity': instance.severity,
      'r_eventid': instance.r_eventid,
      'hosts': instance.firstEventHosts,
    };
