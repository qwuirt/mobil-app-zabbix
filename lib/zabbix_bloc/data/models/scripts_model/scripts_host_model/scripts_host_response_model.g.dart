// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scripts_host_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScriptsHostResponseModel _$ScriptsHostResponseModelFromJson(
    Map<String, dynamic> json) {
  return ScriptsHostResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    scriptsHostResult: (json['result'] as List<dynamic>)
        .map((e) => ScriptsHostResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ScriptsHostResponseModelToJson(
        ScriptsHostResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.scriptsHostResult,
    };
