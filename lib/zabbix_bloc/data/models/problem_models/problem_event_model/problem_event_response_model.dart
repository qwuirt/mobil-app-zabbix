import 'package:json_annotation/json_annotation.dart';
import 'package:Zabbix/zabbix_bloc/data/models/problem_models/problem_event_model/problem_event_result_model.dart';
part 'problem_event_response_model.g.dart';


@JsonSerializable()
class ProblemEventResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<ProblemEventResultModel> problemEventResult;


  ProblemEventResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.problemEventResult,
  });

  factory ProblemEventResponseModel.fromJson(Map<String, dynamic> json) => _$ProblemEventResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemEventResponseModelToJson(this);

}
