import 'package:json_annotation/json_annotation.dart';
part 'problem_event_result_model.g.dart';


@JsonSerializable()
class ProblemEventResultModel {
  @JsonKey(name: 'eventid')
  String eventid;
  @JsonKey(name: 'acknowledged')
  String acknowledged;
  @JsonKey(name: 'clock')
  String clock;
  @JsonKey(name: 'value')
  String value;
  @JsonKey(name: 'acknowledges')
  List acknowledges;




  ProblemEventResultModel({
    required this.eventid,
    required this.acknowledged,
    required this.clock,
    required this.value,
    required this.acknowledges,
  });

  factory ProblemEventResultModel.fromJson(Map<String, dynamic> json) => _$ProblemEventResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProblemEventResultModelToJson(this);

}


