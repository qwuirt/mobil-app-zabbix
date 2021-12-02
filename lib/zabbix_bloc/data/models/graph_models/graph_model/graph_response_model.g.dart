// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'graph_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraphResponseModel _$GraphResponseModelFromJson(Map<String, dynamic> json) {
  return GraphResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    graphResult: (json['result'] as List<dynamic>)
        .map((e) => GraphResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$GraphResponseModelToJson(GraphResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.graphResult,
    };
