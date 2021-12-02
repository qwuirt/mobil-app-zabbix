// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemHistoryResponseModel _$ItemHistoryResponseModelFromJson(
    Map<String, dynamic> json) {
  return ItemHistoryResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    itemHistoryResult: (json['result'] as List<dynamic>)
        .map((e) => ItemHistoryResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ItemHistoryResponseModelToJson(
        ItemHistoryResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.itemHistoryResult,
    };
