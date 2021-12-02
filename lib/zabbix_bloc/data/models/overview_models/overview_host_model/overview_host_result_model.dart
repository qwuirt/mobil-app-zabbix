import 'package:json_annotation/json_annotation.dart';
part 'overview_host_result_model.g.dart';


@JsonSerializable()
class OverviewHostResultModel {
  @JsonKey(name: 'hostid')
  String hostid;
  @JsonKey(name: 'name')
  String name;


  OverviewHostResultModel({
    required this.hostid,
    required this.name,
  });

  factory OverviewHostResultModel.fromJson(Map<String, dynamic> json) => _$OverviewHostResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverviewHostResultModelToJson(this);

}
