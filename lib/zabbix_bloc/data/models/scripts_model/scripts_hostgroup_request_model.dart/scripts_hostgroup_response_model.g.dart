// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scripts_hostgroup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScriptsHostgroupResponseModel _$ScriptsHostgroupResponseModelFromJson(
    Map<String, dynamic> json) {
  return ScriptsHostgroupResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    scriptsHostgroupResult: (json['result'] as List<dynamic>)
        .map((e) =>
            ScriptsHostgroupResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ScriptsHostgroupResponseModelToJson(
        ScriptsHostgroupResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.scriptsHostgroupResult,
    };
