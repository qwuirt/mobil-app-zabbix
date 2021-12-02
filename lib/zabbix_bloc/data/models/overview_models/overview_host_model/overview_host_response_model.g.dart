// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_host_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverviewHostResponseModel _$OverviewHostResponseModelFromJson(
    Map<String, dynamic> json) {
  return OverviewHostResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    overviewHostResult: (json['result'] as List<dynamic>)
        .map((e) => OverviewHostResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OverviewHostResponseModelToJson(
        OverviewHostResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.overviewHostResult,
    };
