
import 'package:json_annotation/json_annotation.dart';

import 'item_history_result_model.dart';
part 'item_history_response_model.g.dart';

@JsonSerializable()
class ItemHistoryResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<ItemHistoryResultModel> itemHistoryResult;

  ItemHistoryResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.itemHistoryResult,
  });

  factory ItemHistoryResponseModel.fromJson(Map<String, dynamic> json) => _$ItemHistoryResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemHistoryResponseModelToJson(this);

}
