// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'overview_hostgroup_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OverviewHostgroupResponseModel _$OverviewHostgroupResponseModelFromJson(
    Map<String, dynamic> json) {
  return OverviewHostgroupResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    overviewHostgroupResult: (json['result'] as List<dynamic>)
        .map((e) =>
            OverviewHostgroupResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$OverviewHostgroupResponseModelToJson(
        OverviewHostgroupResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.overviewHostgroupResult,
    };
