import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'second_event_result_model.g.dart';


@JsonSerializable()
class SecondEventResultModel {
  @JsonKey(name: 'eventid')
  final String eventid;
  @JsonKey(name: 'clock')
  final String clock;
  @JsonKey(name: 'r_eventid')
  final String r_eventid;


  SecondEventResultModel({
    required this.eventid, //строка	ID события.
    required this.clock, //штамп времени	Время, когда событие было создано.
    required this.r_eventid, //строка	ID события восстановлении

  });

  factory SecondEventResultModel.fromJson(Map<String, dynamic> json) => _$SecondEventResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$SecondEventResultModelToJson(this);

}


