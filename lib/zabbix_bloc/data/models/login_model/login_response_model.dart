import 'package:json_annotation/json_annotation.dart';
part 'login_response_model.g.dart';


@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'result')
  String loginResult;
  @JsonKey(name: 'id')
  int id;



  LoginResponseModel({
    required this.jsonrpc,
    required this.loginResult,
    required this.id,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);

}