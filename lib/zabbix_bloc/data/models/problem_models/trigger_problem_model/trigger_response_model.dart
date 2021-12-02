import 'package:json_annotation/json_annotation.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/trigger_problem_model/trigger_result_model.dart';
part 'trigger_response_model.g.dart';


@JsonSerializable()
class TriggerResponseModel {
  @JsonKey(name: 'jsonrpc')
  final String jsonrpc;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'result')
  final List<TriggerResultModel> triggerResult;


  TriggerResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.triggerResult,
  });

  factory TriggerResponseModel.fromJson(Map<String, dynamic> json) => _$TriggerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerResponseModelToJson(this);

}
