import 'package:json_annotation/json_annotation.dart';
part 'graph_result_model.g.dart';


@JsonSerializable()
class GraphResultModel {
  @JsonKey(name: 'graphid')
  String graphid;
  @JsonKey(name: 'name')
  String name;


  GraphResultModel({
    required this.graphid,
    required this.name,
  });

  factory GraphResultModel.fromJson(Map<String, dynamic> json) => _$GraphResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$GraphResultModelToJson(this);

}
