import 'package:json_annotation/json_annotation.dart';
part 'image_result_model.g.dart';


@JsonSerializable()
class ImageResultModel {
  @JsonKey(name: 'imageid')
  String imageid;
  @JsonKey(name: 'imagetype')
  String imagetype;
  @JsonKey(name: 'name')
  String name;
  @JsonKey(name: 'image')
  String image;



  ImageResultModel({
    required this.imageid,
    required this.imagetype,
    required this.name,
    required this.image,
  });

  factory ImageResultModel.fromJson(Map<String, dynamic> json) => _$ImageResultModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResultModelToJson(this);

}