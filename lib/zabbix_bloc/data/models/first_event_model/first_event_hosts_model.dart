import 'package:json_annotation/json_annotation.dart';
part 'first_event_hosts_model.g.dart';


@JsonSerializable()
class FirstEventHostsModel {
  @JsonKey(name: 'hostid')
  final String hostid;
  @JsonKey(name: 'name')
  final String name;


  FirstEventHostsModel({
    required this.hostid,
    required this.name,
  });

  factory FirstEventHostsModel.fromJson(Map<String, dynamic> json) => _$FirstEventHostsModelFromJson(json);

  Map<String, dynamic> toJson() => _$FirstEventHostsModelToJson(this);

}


