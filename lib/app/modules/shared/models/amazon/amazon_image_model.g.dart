// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'amazon_image_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmazonImageModel _$AmazonImageModelFromJson(Map<String, dynamic> json) {
  return AmazonImageModel(
    amazonUserImageId: json['amazonUserImageId'] as String,
    imageUrl: json['imageUrl'] as String,
  );
}

Map<String, dynamic> _$AmazonImageModelToJson(AmazonImageModel instance) =>
    <String, dynamic>{
      'amazonUserImageId': instance.amazonUserImageId,
      'imageUrl': instance.imageUrl,
    };
