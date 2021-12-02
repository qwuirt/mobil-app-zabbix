import 'package:json_annotation/json_annotation.dart';
part 'confirmation_problem_result_model.g.dart';


@JsonSerializable()
class ConfirmationProblemResultModel {
  @JsonKey(name: 'eventid')
  String eventid;

  ConfirmationProblemResultModel({
    required this.eventid,
  });

  factory ConfirmationProblemResultModel.fromJson(Map<String, dynamic> json) => _$ConfirmationProblemResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmationProblemResultModelToJson(this);

}


