// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'second_event_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecondEventResponseModel _$SecondEventResponseModelFromJson(
    Map<String, dynamic> json) {
  return SecondEventResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    id: json['id'] as int,
    secondEventResult: (json['result'] as List<dynamic>)
        .map((e) => SecondEventResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$SecondEventResponseModelToJson(
        SecondEventResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'id': instance.id,
      'result': instance.secondEventResult,
    };
