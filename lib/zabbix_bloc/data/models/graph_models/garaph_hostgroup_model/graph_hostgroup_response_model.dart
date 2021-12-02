import 'package:json_annotation/json_annotation.dart';

import 'graph_hostgroup_result_model.dart';
part 'graph_hostgroup_response_model.g.dart';


@JsonSerializable()
class GraphHostgroupResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<GraphHostgroupResultModel> graphHostgroupResult;

  GraphHostgroupResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.graphHostgroupResult,
  });

  factory GraphHostgroupResponseModel.fromJson(Map<String, dynamic> json) => _$GraphHostgroupResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GraphHostgroupResponseModelToJson(this);

}
