// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScriptResponseModel _$ScriptResponseModelFromJson(Map<String, dynamic> json) {
  return ScriptResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    scriptResult: (json['result'] as List<dynamic>)
        .map((e) => ScriptResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ScriptResponseModelToJson(
        ScriptResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.scriptResult,
    };
