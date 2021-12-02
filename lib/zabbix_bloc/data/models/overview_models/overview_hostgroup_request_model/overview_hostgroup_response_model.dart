import 'package:json_annotation/json_annotation.dart';

import 'overview_hostgroup_result_model.dart';

part 'overview_hostgroup_response_model.g.dart';


@JsonSerializable()
class OverviewHostgroupResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<OverviewHostgroupResultModel> overviewHostgroupResult;

  OverviewHostgroupResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.overviewHostgroupResult,
  });

  factory OverviewHostgroupResponseModel.fromJson(Map<String, dynamic> json) => _$OverviewHostgroupResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverviewHostgroupResponseModelToJson(this);

}
