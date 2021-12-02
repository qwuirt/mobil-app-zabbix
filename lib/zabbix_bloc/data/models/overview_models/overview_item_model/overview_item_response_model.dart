import 'package:json_annotation/json_annotation.dart';

import 'overview_item_result_model.dart';

part 'overview_item_response_model.g.dart';


@JsonSerializable()
class OverviewItemResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<OverviewItemResultModel> overviewItemResult;

  OverviewItemResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.overviewItemResult,
  });

  factory OverviewItemResponseModel.fromJson(Map<String, dynamic> json) => _$OverviewItemResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverviewItemResponseModelToJson(this);

}
