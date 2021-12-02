import 'package:json_annotation/json_annotation.dart';
part 'overview_item_result_model.g.dart';


@JsonSerializable()
class OverviewItemResultModel {
  @JsonKey(name: 'itemid')
  String itemid;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'units')
  String units;
  @JsonKey(name: 'value_type')
  String value_type;
  @JsonKey(name: 'lastvalue')
  String lastvalue;


  OverviewItemResultModel({
    required this.itemid,
    required this.name,
    required this.units,
    required this.value_type,
    required this.lastvalue,
  });

  factory OverviewItemResultModel.fromJson(Map<String, dynamic> json) => _$OverviewItemResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$OverviewItemResultModelToJson(this);

}
