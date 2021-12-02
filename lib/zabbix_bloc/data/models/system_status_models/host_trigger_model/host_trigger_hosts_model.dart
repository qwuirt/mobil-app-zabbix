import 'package:json_annotation/json_annotation.dart';
part 'host_trigger_hosts_model.g.dart';


@JsonSerializable()
class HostTriggerHostsModel {
  @JsonKey(name: 'hostid')
  final String hostid;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'status')
  final String status;

  HostTriggerHostsModel({
    required this.hostid,
    required this.name,
    required this.status,
  });

  factory HostTriggerHostsModel.fromJson(Map<String, dynamic> json) => _$HostTriggerHostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HostTriggerHostsModelToJson(this);

}