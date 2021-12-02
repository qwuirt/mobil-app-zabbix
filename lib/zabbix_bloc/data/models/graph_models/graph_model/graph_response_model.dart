import 'package:json_annotation/json_annotation.dart';

import 'graph_result_model.dart';

part 'graph_response_model.g.dart';


@JsonSerializable()
class GraphResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<GraphResultModel> graphResult;

  GraphResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.graphResult,
  });

  factory GraphResponseModel.fromJson(Map<String, dynamic> json) => _$GraphResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GraphResponseModelToJson(this);

}
