// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResponseModel _$ImageResponseModelFromJson(Map<String, dynamic> json) {
  return ImageResponseModel(
    jsonrpc: json['jsonrpc'] as String,
    imageResult: (json['result'] as List<dynamic>)
        .map((e) => ImageResultModel.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as int,
  );
}

Map<String, dynamic> _$ImageResponseModelToJson(ImageResponseModel instance) =>
    <String, dynamic>{
      'jsonrpc': instance.jsonrpc,
      'result': instance.imageResult,
      'id': instance.id,
    };
