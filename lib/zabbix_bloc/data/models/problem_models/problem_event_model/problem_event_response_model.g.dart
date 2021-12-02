// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_event_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProblemEventResponseModel _$ProblemEventResponseModelFromJson(
    Map<String, dynamic> json) {
  return ProblemEventResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    problemEventResult: (json['result'] as List<dynamic>)
        .map((e) => ProblemEventResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ProblemEventResponseModelToJson(
        ProblemEventResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.problemEventResult,
    };
