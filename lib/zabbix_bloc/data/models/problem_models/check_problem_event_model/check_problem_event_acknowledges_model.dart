import 'package:json_annotation/json_annotation.dart';
part 'check_problem_event_acknowledges_model.g.dart';


@JsonSerializable()
class CheckProblemEventAcknowledgesModel {
  @JsonKey(name: 'message')
  String message;
  @JsonKey(name: 'alias')
  String alias;
  @JsonKey(name: 'clock')
  String clock;

  CheckProblemEventAcknowledgesModel({
    required this.message,
    required this.alias,
    required this.clock,
  });

  factory CheckProblemEventAcknowledgesModel.fromJson(Map<String, dynamic> json) => _$CheckProblemEventAcknowledgesModelFromJson(json);

  Map<String, dynamic> toJson() => _$CheckProblemEventAcknowledgesModelToJson(this);

}


