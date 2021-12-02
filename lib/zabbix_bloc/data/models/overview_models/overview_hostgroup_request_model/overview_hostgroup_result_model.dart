import 'package:json_annotation/json_annotation.dart';
part 'overview_hostgroup_result_model.g.dart';


@JsonSerializable()
class OverviewHostgroupResultModel {
  @JsonKey(name: 'groupid')
  String groupid;
  @JsonKey(name: 'name')
  String name;


  OverviewHostgroupResultModel({
    required this.groupid,
    required this.name,
  });

  factory OverviewHostgroupResultModel.fromJson(Map<String, dynamic> json) => _$OverviewHostgroupResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverviewHostgroupResultModelToJson(this);

}
