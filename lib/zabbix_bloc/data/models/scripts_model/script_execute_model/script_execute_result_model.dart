import 'package:json_annotation/json_annotation.dart';
part 'script_execute_result_model.g.dart';


@JsonSerializable()
class ScriptExecuteResultModel {
  @JsonKey(name: 'response')
  String response;
  @JsonKey(name: 'value')
  String value;


  ScriptExecuteResultModel({
    required this.response,
    required this.value,
  });

  factory ScriptExecuteResultModel.fromJson(Map<String, dynamic> json) => _$ScriptExecuteResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptExecuteResultModelToJson(this);

}
