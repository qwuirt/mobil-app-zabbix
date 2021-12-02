import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'first_event_hosts_model.dart';
part 'first_event_result_model.g.dart';


@JsonSerializable()
class FirstEventResultModel {
  @JsonKey(name: 'eventid')
  final String eventid;
  @JsonKey(name: 'clock')
  final String clock;
  @JsonKey(name: 'acknowledged')
  final String acknowledged;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'severity')
  final String severity;
  @JsonKey(name: 'r_eventid')
  final String r_eventid;
  @JsonKey(name: 'hosts')
  final List<FirstEventHostsModel> firstEventHosts;


  FirstEventResultModel({
    required this.eventid, //строка	ID события.
    required this.clock, //штамп времени	Время, когда событие было создано.
    required this.acknowledged, // целое число	Подтверждено ли событие.
    required this.name, //строка	Имя решённого события.
    required this.severity, //целое число	Текущая важность события.
    required this.r_eventid, //строка	ID события восстановлении
    required this.firstEventHosts, //
  });

  factory FirstEventResultModel.fromJson(Map<String, dynamic> json) => _$FirstEventResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirstEventResultModelToJson(this);

}


