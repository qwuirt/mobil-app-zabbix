import 'package:json_annotation/json_annotation.dart';
part 'script_result_model.g.dart';


@JsonSerializable()
class ScriptResultModel {
  @JsonKey(name: 'scriptid')
  String scriptid;
  @JsonKey(name: 'name')
  String name;


  ScriptResultModel({
    required this.scriptid,
    required this.name,
  });

  factory ScriptResultModel.fromJson(Map<String, dynamic> json) => _$ScriptResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptResultModelToJson(this);

}
