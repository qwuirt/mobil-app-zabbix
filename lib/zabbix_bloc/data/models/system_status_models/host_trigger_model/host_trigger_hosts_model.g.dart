// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'host_trigger_hosts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HostTriggerHostsModel _$HostTriggerHostsModelFromJson(
    Map<String, dynamic> json) {
  return HostTriggerHostsModel(
    hostid: json['hostid'] as String,
    name: json['name'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$HostTriggerHostsModelToJson(
        HostTriggerHostsModel instance) =>
    <String, dynamic>{
      'hostid': instance.hostid,
      'name': instance.name,
      'status': instance.status,
    };
