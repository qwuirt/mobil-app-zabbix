import 'package:json_annotation/json_annotation.dart';

import 'script_result_model.dart';

part 'script_response_model.g.dart';


@JsonSerializable()
class ScriptResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<ScriptResultModel> scriptResult;

  ScriptResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.scriptResult,
  });

  factory ScriptResponseModel.fromJson(Map<String, dynamic> json) => _$ScriptResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptResponseModelToJson(this);

}
