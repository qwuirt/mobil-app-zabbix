import 'package:json_annotation/json_annotation.dart';

import 'check_problem_event_acknowledges_model.dart';
part 'check_problem_event_result_model.g.dart';


@JsonSerializable()
class CheckProblemEventResultModel {
  @JsonKey(name: 'eventid')
  String eventid;
  @JsonKey(name: 'acknowledges')
  List<CheckProblemEventAcknowledgesModel> checkProblemAcknowledges;

  CheckProblemEventResultModel({
    required this.eventid,
    required this.checkProblemAcknowledges,
  });

  factory CheckProblemEventResultModel.fromJson(Map<String, dynamic> json) => _$CheckProblemEventResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckProblemEventResultModelToJson(this);

}


