import 'package:json_annotation/json_annotation.dart';
part 'item_history_result_model.g.dart';


@JsonSerializable()
class ItemHistoryResultModel {
  @JsonKey(name: 'itemid')
  String itemid;
  @JsonKey(name: 'clock')
  String clock;
  @JsonKey(name: 'value')
  String value;
  @JsonKey(name: 'ns')
  String ns;


  ItemHistoryResultModel({
    required this.itemid,
    required this.clock,
    required this.value,
    required this.ns,

  });

  factory ItemHistoryResultModel.fromJson(Map<String, dynamic> json) => _$ItemHistoryResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemHistoryResultModelToJson(this);

}
