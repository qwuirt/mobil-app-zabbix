import 'package:json_annotation/json_annotation.dart';
part 'hostgroup_result_model.g.dart';


@JsonSerializable()
class HostgroupResultModel {
  @JsonKey(name: 'groupid')
  String groupid;
  @JsonKey(name: 'name')
  String name;


  HostgroupResultModel({
    required this.groupid,
    required this.name,
  });

  factory HostgroupResultModel.fromJson(Map<String, dynamic> json) => _$HostgroupResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$HostgroupResultModelToJson(this);

}
