// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirmation_problem_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmationProblemResponseModel _$ConfirmationProblemResponseModelFromJson(
    Map<String, dynamic> json) {
  return ConfirmationProblemResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    confirmationProblemResult: (json['result'] as List<dynamic>)
        .map((e) =>
            ConfirmationProblemResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$ConfirmationProblemResponseModelToJson(
        ConfirmationProblemResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.confirmationProblemResult,
    };
