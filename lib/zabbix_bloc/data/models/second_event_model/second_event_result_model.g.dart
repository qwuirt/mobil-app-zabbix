// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_event_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondEventResultModel _$SecondEventResultModelFromJson(
    Map<String, dynamic> json) {
  return SecondEventResultModel(
    eventid: json['eventid'] as String,
    clock: json['clock'] as String,
    r_eventid: json['r_eventid'] as String,
  );
}

Map<String, dynamic> _$SecondEventResultModelToJson(
        SecondEventResultModel instance) =>
    <String, dynamic>{
      'eventid': instance.eventid,
      'clock': instance.clock,
      'r_eventid': instance.r_eventid,
    };
