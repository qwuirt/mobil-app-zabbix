// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResultModel _$ImageResultModelFromJson(Map<String, dynamic> json) {
  return ImageResultModel(
    imageid: json['imageid'] as String,
    imagetype: json['imagetype'] as String,
    name: json['name'] as String,
    image: json['image'] as String,
  );
}

Map<String, dynamic> _$ImageResultModelToJson(ImageResultModel instance) =>
    <String, dynamic>{
      'imageid': instance.imageid,
      'imagetype': instance.imagetype,
      'name': instance.name,
      'image': instance.image,
    };
