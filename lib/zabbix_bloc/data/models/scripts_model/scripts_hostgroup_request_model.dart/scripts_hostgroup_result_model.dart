import 'package:json_annotation/json_annotation.dart';
part 'scripts_hostgroup_result_model.g.dart';


@JsonSerializable()
class ScriptsHostgroupResultModel {
  @JsonKey(name: 'groupid')
  String groupid;
  @JsonKey(name: 'name')
  String name;


  ScriptsHostgroupResultModel({
    required this.groupid,
    required this.name,
  });

  factory ScriptsHostgroupResultModel.fromJson(Map<String, dynamic> json) => _$ScriptsHostgroupResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptsHostgroupResultModelToJson(this);

}
