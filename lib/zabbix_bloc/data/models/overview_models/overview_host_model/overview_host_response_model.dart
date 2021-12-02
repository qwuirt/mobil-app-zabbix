import 'package:json_annotation/json_annotation.dart';
import 'overview_host_result_model.dart';
import 'overview_hostgroup_result_model.dart';

part 'overview_host_response_model.g.dart';


@JsonSerializable()
class OverviewHostResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<OverviewHostResultModel> overviewHostResult;

  OverviewHostResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.overviewHostResult,
  });

  factory OverviewHostResponseModel.fromJson(Map<String, dynamic> json) => _$OverviewHostResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverviewHostResponseModelToJson(this);

}
