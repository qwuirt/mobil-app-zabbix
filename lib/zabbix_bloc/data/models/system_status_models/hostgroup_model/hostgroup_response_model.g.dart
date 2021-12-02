// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hostgroup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostgroupResponseModel _$HostgroupResponseModelFromJson(
    Map<String, dynamic> json) {
  return HostgroupResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    hostgroupResult: (json['result'] as List<dynamic>)
        .map((e) => HostgroupResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HostgroupResponseModelToJson(
        HostgroupResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.hostgroupResult,
    };
