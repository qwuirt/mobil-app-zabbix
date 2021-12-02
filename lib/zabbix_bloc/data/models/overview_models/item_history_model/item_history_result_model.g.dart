// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_history_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemHistoryResultModel _$ItemHistoryResultModelFromJson(
    Map<String, dynamic> json) {
  return ItemHistoryResultModel(
    itemid: json['itemid'] as String,
    clock: json['clock'] as String,
    value: json['value'] as String,
    ns: json['ns'] as String,
  );
}

Map<String, dynamic> _$ItemHistoryResultModelToJson(
        ItemHistoryResultModel instance) =>
    <String, dynamic>{
      'itemid': instance.itemid,
      'clock': instance.clock,
      'value': instance.value,
      'ns': instance.ns,
    };
