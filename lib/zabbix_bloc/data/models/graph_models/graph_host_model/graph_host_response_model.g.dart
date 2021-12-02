// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_host_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphHostResponseModel _$GraphHostResponseModelFromJson(
    Map<String, dynamic> json) {
  return GraphHostResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    graphHostResult: (json['result'] as List<dynamic>)
        .map((e) => GraphHostResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GraphHostResponseModelToJson(
        GraphHostResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.graphHostResult,
    };
