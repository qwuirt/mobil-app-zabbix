// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_hostgroup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphHostgroupResponseModel _$GraphHostgroupResponseModelFromJson(
    Map<String, dynamic> json) {
  return GraphHostgroupResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    graphHostgroupResult: (json['result'] as List<dynamic>)
        .map((e) =>
            GraphHostgroupResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GraphHostgroupResponseModelToJson(
        GraphHostgroupResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.graphHostgroupResult,
    };
