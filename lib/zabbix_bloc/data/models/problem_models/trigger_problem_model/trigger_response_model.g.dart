// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriggerResponseModel _$TriggerResponseModelFromJson(Map<String, dynamic> json) {
  return TriggerResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    triggerResult: (json['result'] as List<dynamic>)
        .map((e) => TriggerResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TriggerResponseModelToJson(
        TriggerResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.triggerResult,
    };
