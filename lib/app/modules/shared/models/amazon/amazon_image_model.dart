import 'package:json_annotation/json_annotation.dart';

part 'amazon_image_model.g.dart';

@JsonSerializable()
class AmazonImageModel {
  AmazonImageModel({
    this.amazonUserImageId,
    this.imageUrl
  });

  String amazonUserImageId;
  String imageUrl;

  factory AmazonImageModel.fromJson(Map<String, dynamic> json) => _$AmazonImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$AmazonImageModelToJson(this);
}