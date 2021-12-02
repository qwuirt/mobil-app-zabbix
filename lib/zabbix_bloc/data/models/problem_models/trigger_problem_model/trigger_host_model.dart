import 'package:json_annotation/json_annotation.dart';
part 'trigger_host_model.g.dart';


@JsonSerializable()
class TriggerHostsModel {
  @JsonKey(name: 'hostid')
  final String hostid;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'status')
  final String status;

  TriggerHostsModel({
    required this.hostid,
    required this.name,
    required this.status,
  });

  factory TriggerHostsModel.fromJson(Map<String, dynamic> json) => _$TriggerHostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerHostsModelToJson(this);

}


