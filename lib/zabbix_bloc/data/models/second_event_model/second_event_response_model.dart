import 'package:json_annotation/json_annotation.dart';
import 'package:Zabbix/zabbix_bloc/data/models/second_event_model/second_event_result_model.dart';

part 'second_event_response_model.g.dart';

@JsonSerializable()
class SecondEventResponseModel {
  @JsonKey(name: 'jsonrpc')
  final String jsonrpc;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'result')
  final List<SecondEventResultModel> secondEventResult;


  SecondEventResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.secondEventResult,
  });

  factory SecondEventResponseModel.fromJson(Map<String, dynamic> json) => _$SecondEventResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SecondEventResponseModelToJson(this);

}
