import 'package:json_annotation/json_annotation.dart';

import 'image_result_model.dart';
part 'image_response_model.g.dart';


@JsonSerializable()
class ImageResponseModel {
  @JsonKey(name: 'jsonrpc')
  String jsonrpc;
  @JsonKey(name: 'result')
  List<ImageResultModel> imageResult;
  @JsonKey(name: 'id')
  int id;



  ImageResponseModel({
    required this.jsonrpc,
    required this.imageResult,
    required this.id,
  });

  factory ImageResponseModel.fromJson(Map<String, dynamic> json) => _$ImageResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseModelToJson(this);

}