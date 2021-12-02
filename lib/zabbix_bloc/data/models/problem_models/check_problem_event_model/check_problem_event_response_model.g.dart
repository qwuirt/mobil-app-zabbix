// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_problem_event_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckProblemEventResponseModel _$CheckProblemEventResponseModelFromJson(
    Map<String, dynamic> json) {
  return CheckProblemEventResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    checkProblemEventResult: (json['result'] as List<dynamic>)
        .map((e) =>
            CheckProblemEventResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CheckProblemEventResponseModelToJson(
        CheckProblemEventResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.checkProblemEventResult,
    };
