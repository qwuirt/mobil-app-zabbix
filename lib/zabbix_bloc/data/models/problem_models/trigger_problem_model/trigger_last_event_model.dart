import 'package:json_annotation/json_annotation.dart';
part 'trigger_last_event_model.g.dart';

@JsonSerializable()
class TriggerLastEventModel {
  @JsonKey(name: 'eventid')
  String eventid;
  @JsonKey(name: 'source')
  String source;
  @JsonKey(name: 'object')
  String object;
  @JsonKey(name: 'objectid')
  String objectid;
  @JsonKey(name: 'clock')
  String clock;
  @JsonKey(name: 'value')
  String value;
  @JsonKey(name: 'acknowledged')
  String acknowledged;
  @JsonKey(name: 'ns')
  String ns;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'severity')
  String severity;

  TriggerLastEventModel({
    required this.eventid, //	строка, ID события о проблеме.
    required this.source,  //	целое число,	Тип события о проблеме.
    required this.object,  //целое число,	Тип объекта, к которому относится событие о проблеме.
    required this.objectid,  //строка,	ID связанного объекта.
    required this.clock,  //штамп времени	Время, когда было получено значение.
    required this.value,
    required this.acknowledged, //целое число,	Состояние подтверждения проблемы.
    required this.ns, //целое число,	Наносекунды, когда было получено значение.
    required this.name, //Имя решённой проблемы.
    required this.severity, //целое число,	Текущая важность проблемы.
  });

  factory TriggerLastEventModel.fromJson(Map<String, dynamic> json) => _$TriggerLastEventModelFromJson(json);

  Map<String, dynamic> toJson() => _$TriggerLastEventModelToJson(this);

}


