import 'package:json_annotation/json_annotation.dart';

import 'first_event_result_model.dart';
part 'first_event_response_model.g.dart';


@JsonSerializable()
class FirstEventResponseModel {
  @JsonKey(name: 'jsonrpc')
  final String jsonrpc;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'result')
  final List<FirstEventResultModel> firstEventResult;


  FirstEventResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.firstEventResult,
  });

  factory FirstEventResponseModel.fromJson(Map<String, dynamic> json) => _$FirstEventResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirstEventResponseModelToJson(this);

}
