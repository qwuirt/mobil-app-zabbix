// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_problem_event_acknowledges_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckProblemEventAcknowledgesModel _$CheckProblemEventAcknowledgesModelFromJson(
    Map<String, dynamic> json) {
  return CheckProblemEventAcknowledgesModel(
    message: json['message'] as String,
    alias: json['alias'] as String,
    clock: json['clock'] as String,
  );
}

Map<String, dynamic> _$CheckProblemEventAcknowledgesModelToJson(
        CheckProblemEventAcknowledgesModel instance) =>
    <String, dynamic>{
      'message': instance.message,
      'alias': instance.alias,
      'clock': instance.clock,
    };
