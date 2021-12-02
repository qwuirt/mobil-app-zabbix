import 'package:json_annotation/json_annotation.dart';

import 'graph_host_result_model.dart';

part 'graph_host_response_model.g.dart';


@JsonSerializable()
class GraphHostResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<GraphHostResultModel> graphHostResult;

  GraphHostResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.graphHostResult,
  });

  factory GraphHostResponseModel.fromJson(Map<String, dynamic> json) => _$GraphHostResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GraphHostResponseModelToJson(this);

}
