import 'package:json_annotation/json_annotation.dart';

import 'script_execute_result_model.dart';

part 'script_execute_response_model.g.dart';


@JsonSerializable()
class ScriptExecuteResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<ScriptExecuteResultModel> scriptExecuteResult;

  ScriptExecuteResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.scriptExecuteResult,
  });

  factory ScriptExecuteResponseModel.fromJson(Map<String, dynamic> json) => _$ScriptExecuteResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptExecuteResponseModelToJson(this);

}
