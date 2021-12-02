import 'package:json_annotation/json_annotation.dart';
import 'package:Zabbix/zabbix_bloc/data/models/scripts_model/scripts_hostgroup_request_model.dart/scripts_hostgroup_result_model.dart';

part 'scripts_hostgroup_response_model.g.dart';


@JsonSerializable()
class ScriptsHostgroupResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<ScriptsHostgroupResultModel> scriptsHostgroupResult;

  ScriptsHostgroupResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.scriptsHostgroupResult,
  });

  factory ScriptsHostgroupResponseModel.fromJson(Map<String, dynamic> json) => _$ScriptsHostgroupResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ScriptsHostgroupResponseModelToJson(this);

}
