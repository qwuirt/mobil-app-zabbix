// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_trigger_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostTriggerResponseModel _$HostTriggerResponseModelFromJson(
    Map<String, dynamic> json) {
  return HostTriggerResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    hostTriggerResult: (json['result'] as List<dynamic>)
        .map((e) => HostTriggerResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HostTriggerResponseModelToJson(
        HostTriggerResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.hostTriggerResult,
    };
