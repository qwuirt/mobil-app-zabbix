// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverviewItemResponseModel _$OverviewItemResponseModelFromJson(
    Map<String, dynamic> json) {
  return OverviewItemResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    overviewItemResult: (json['result'] as List<dynamic>)
        .map((e) => OverviewItemResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OverviewItemResponseModelToJson(
        OverviewItemResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.overviewItemResult,
    };
