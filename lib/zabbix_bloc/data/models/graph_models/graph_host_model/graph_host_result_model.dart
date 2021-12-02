import 'package:json_annotation/json_annotation.dart';
part 'graph_host_result_model.g.dart';


@JsonSerializable()
class GraphHostResultModel {
  @JsonKey(name: 'hostid')
  String hostid;
  @JsonKey(name: 'name')
  String name;


  GraphHostResultModel({
    required this.hostid,
    required this.name,
  });

  factory GraphHostResultModel.fromJson(Map<String, dynamic> json) => _$GraphHostResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GraphHostResultModelToJson(this);

}
