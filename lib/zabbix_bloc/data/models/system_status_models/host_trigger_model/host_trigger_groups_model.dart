import 'package:json_annotation/json_annotation.dart';
part 'host_trigger_groups_model.g.dart';


@JsonSerializable()
class HostTriggerGroupsModel {
  @JsonKey(name: 'groupid')
  final String groupid;
  @JsonKey(name: 'name')
  final String name;


  HostTriggerGroupsModel({
    required this.groupid,
    required this.name,
  });

  factory HostTriggerGroupsModel.fromJson(Map<String, dynamic> json) => _$HostTriggerGroupsModelFromJson(json);

  Map<String, dynamic> toJson() => _$HostTriggerGroupsModelToJson(this);

}