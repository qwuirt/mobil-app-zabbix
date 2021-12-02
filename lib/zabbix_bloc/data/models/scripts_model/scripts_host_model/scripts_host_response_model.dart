import 'package:json_annotation/json_annotation.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_host_model/scripts_host_result_model.dart';

part 'scripts_host_response_model.g.dart';


@JsonSerializable()
class ScriptsHostResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<ScriptsHostResultModel> scriptsHostResult;

  ScriptsHostResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.scriptsHostResult,
  });

  factory ScriptsHostResponseModel.fromJson(Map<String, dynamic> json) => _$ScriptsHostResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptsHostResponseModelToJson(this);

}
