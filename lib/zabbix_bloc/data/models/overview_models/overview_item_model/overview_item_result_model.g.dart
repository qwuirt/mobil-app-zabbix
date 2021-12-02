// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_item_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverviewItemResultModel _$OverviewItemResultModelFromJson(
    Map<String, dynamic> json) {
  return OverviewItemResultModel(
    itemid: json['itemid'] as String,
    name: json['name'] as String,
    units: json['units'] as String,
    value_type: json['value_type'] as String,
    lastvalue: json['lastvalue'] as String,
  );
}

Map<String, dynamic> _$OverviewItemResultModelToJson(
        OverviewItemResultModel instance) =>
    <String, dynamic>{
      'itemid': instance.itemid,
      'name': instance.name,
      'units': instance.units,
      'value_type': instance.value_type,
      'lastvalue': instance.lastvalue,
    };
