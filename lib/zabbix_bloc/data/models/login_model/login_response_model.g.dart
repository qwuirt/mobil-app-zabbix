// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) {
  return LoginResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    loginResult: json['result'] as String,
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'result': instance.loginResult,
      'id': instance.id,
    };
