import 'package:json_annotation/json_annotation.dart';
part 'graph_hostgroup_result_model.g.dart';


@JsonSerializable()
class GraphHostgroupResultModel {
  @JsonKey(name: 'groupid')
  String groupid;
  @JsonKey(name: 'name')
  String name;


  GraphHostgroupResultModel({
    required this.groupid,
    required this.name,
  });

  factory GraphHostgroupResultModel.fromJson(Map<String, dynamic> json) => _$GraphHostgroupResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GraphHostgroupResultModelToJson(this);

}
