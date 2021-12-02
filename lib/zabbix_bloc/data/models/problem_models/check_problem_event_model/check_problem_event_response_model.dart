import 'package:json_annotation/json_annotation.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/check_problem_event_model/check_problem_event_result_model.dart';
part 'check_problem_event_response_model.g.dart';


@JsonSerializable()
class CheckProblemEventResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<CheckProblemEventResultModel> checkProblemEventResult;


  CheckProblemEventResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.checkProblemEventResult,
  });

  factory CheckProblemEventResponseModel.fromJson(Map<String, dynamic> json) => _$CheckProblemEventResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckProblemEventResponseModelToJson(this);

}
