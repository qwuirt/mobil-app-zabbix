import 'package:json_annotation/json_annotation.dart';
part 'scripts_host_result_model.g.dart';


@JsonSerializable()
class ScriptsHostResultModel {
  @JsonKey(name: 'hostid')
  String hostid;
  @JsonKey(name: 'name')
  String name;


  ScriptsHostResultModel({
    required this.hostid,
    required this.name,
  });

  factory ScriptsHostResultModel.fromJson(Map<String, dynamic> json) => _$ScriptsHostResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptsHostResultModelToJson(this);

}
