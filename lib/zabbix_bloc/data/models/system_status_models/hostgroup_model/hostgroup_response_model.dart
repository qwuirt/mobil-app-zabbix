import 'package:json_annotation/json_annotation.dart';
import 'package:Zabbix/zabbix_bloc/data/models/system_status_models/hostgroup_model/hostgroup_result_model.dart';
part 'hostgroup_response_model.g.dart';


@JsonSerializable()
class HostgroupResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<HostgroupResultModel> hostgroupResult;

  HostgroupResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.hostgroupResult,
  });

  factory HostgroupResponseModel.fromJson(Map<String, dynamic> json) => _$HostgroupResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HostgroupResponseModelToJson(this);

}


