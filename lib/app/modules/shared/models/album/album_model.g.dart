// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AlbumModel _$AlbumModelFromJson(Map<String, dynamic> json) {
  return AlbumModel(
    albumId: json['albumId'] as String,
    title: json['title'] as String,
    images: (json['images'] as List)
        ?.map((e) => e == null
            ? null
            : AmazonImageModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$AlbumModelToJson(AlbumModel instance) =>
    <String, dynamic>{
      'albumId': instance.albumId,
      'title': instance.title,
      'images': instance.images,
    };
