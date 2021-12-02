import 'package:json_annotation/json_annotation.dart';

import 'confirmation_problem_result_model.dart';
part 'confirmation_problem_response_model.g.dart';


@JsonSerializable()
class ConfirmationProblemResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'id')
  int id;
  @JsonKey(name: 'result')
  List<ConfirmationProblemResultModel> confirmationProblemResult;


  ConfirmationProblemResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.confirmationProblemResult,
  });

  factory ConfirmationProblemResponseModel.fromJson(Map<String, dynamic> json) => _$ConfirmationProblemResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConfirmationProblemResponseModelToJson(this);

}
