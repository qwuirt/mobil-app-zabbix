// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'script_execute_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScriptExecuteResultModel _$ScriptExecuteResultModelFromJson(
    Map<String, dynamic> json) {
  return ScriptExecuteResultModel(
    response: json['response'] as String,
    value: json['value'] as String,
  );
}

Map<String, dynamic> _$ScriptExecuteResultModelToJson(
        ScriptExecuteResultModel instance) =>
    <String, dynamic>{
      'response': instance.response,
      'value': instance.value,
    };
