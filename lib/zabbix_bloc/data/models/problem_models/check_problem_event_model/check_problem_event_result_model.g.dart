// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_problem_event_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckProblemEventResultModel _$CheckProblemEventResultModelFromJson(
    Map<String, dynamic> json) {
  return CheckProblemEventResultModel(
    eventid: json['eventid'] as String,
    checkProblemAcknowledges: (json['acknowledges'] as List<dynamic>)
        .map((e) => CheckProblemEventAcknowledgesModel.fromJson(
            e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CheckProblemEventResultModelToJson(
        CheckProblemEventResultModel instance) =>
    <String, dynamic>{
      'eventid': instance.eventid,
      'acknowledges': instance.checkProblemAcknowledges,
    };
