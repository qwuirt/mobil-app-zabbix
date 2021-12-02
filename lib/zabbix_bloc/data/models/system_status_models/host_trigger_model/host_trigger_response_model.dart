import 'package:json_annotation/json_annotation.dart';

import 'host_trigger_result_model.dart';

part 'host_trigger_response_model.g.dart';

@JsonSerializable()
class HostTriggerResponseModel {
  @JsonKey(name: 'jsonrpc')
  final String jsonrpc;
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'result')
  final List<HostTriggerResultModel> hostTriggerResult;


  HostTriggerResponseModel({
    required this.jsonrpc,
    required this.id,
    required this.hostTriggerResult,
  });

  factory HostTriggerResponseModel.fromJson(Map<String, dynamic> json) => _$HostTriggerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$HostTriggerResponseModelToJson(this);

}