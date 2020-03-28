import 'package:json_annotation/json_annotation.dart';
import 'package:photos_app/app/modules/shared/models/amazon/amazon_image_model.dart';

part 'album_model.g.dart';

@JsonSerializable()
class AlbumModel {
  AlbumModel({
    this.albumId,
    this.title,
    this.images
  });

  String albumId;
  String title;
  List<AmazonImageModel> images;

  factory AlbumModel.fromJson(Map<String, dynamic> json) => _$AlbumModelFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumModelToJson(this);
}