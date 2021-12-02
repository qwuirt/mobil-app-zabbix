// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_event_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemEventResultModel _$ProblemEventResultModelFromJson(
    Map<String, dynamic> json) {
  return ProblemEventResultModel(
    eventid: json['eventid'] as String,
    acknowledged: json['acknowledged'] as String,
    clock: json['clock'] as String,
    value: json['value'] as String,
    acknowledges: json['acknowledges'] as List<dynamic>,
  );
}

Map<String, dynamic> _$ProblemEventResultModelToJson(
        ProblemEventResultModel instance) =>
    <String, dynamic>{
      'eventid': instance.eventid,
      'acknowledged': instance.acknowledged,
      'clock': instance.clock,
      'value': instance.value,
      'acknowledges': instance.acknowledges,
    };
