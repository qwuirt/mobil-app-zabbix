// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trigger_host_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TriggerHostsModel _$TriggerHostsModelFromJson(Map<String, dynamic> json) {
  return TriggerHostsModel(
    hostid: json['hostid'] as String,
    name: json['name'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$TriggerHostsModelToJson(TriggerHostsModel instance) =>
    <String, dynamic>{
      'hostid': instance.hostid,
      'name': instance.name,
      'status': instance.status,
    };
