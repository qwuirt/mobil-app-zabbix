// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script_execute_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScriptExecuteResponseModel _$ScriptExecuteResponseModelFromJson(
    Map<String, dynamic> json) {
  return ScriptExecuteResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    scriptExecuteResult: (json['result'] as List<dynamic>)
        .map(
            (e) => ScriptExecuteResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ScriptExecuteResponseModelToJson(
        ScriptExecuteResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.scriptExecuteResult,
    };
