// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'first_event_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirstEventResponseModel _$FirstEventResponseModelFromJson(
    Map<String, dynamic> json) {
  return FirstEventResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    firstEventResult: (json['result'] as List<dynamic>)
        .map((e) => FirstEventResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$FirstEventResponseModelToJson(
        FirstEventResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.firstEventResult,
    };
