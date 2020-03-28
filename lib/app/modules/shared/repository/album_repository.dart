import 'dart:io';
import 'package:path/path.dart';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photos_app/app/modules/shared/models/album/album_model.dart';
import 'package:photos_app/app/modules/shared/models/amazon/amazon_image_model.dart';

class AlbumRepository extends Disposable {
  final Dio dio;

  AlbumRepository({
    this.dio
  });

  // FindAllAlbums on Maker Resource in the backend.
  // This calls is one put because your filter, these request receive
  // an Album.class on backend to do an filter. :)
  Future<List<AlbumModel>> findAllAlbums(AlbumModel filter) async {
    // Call the backend, this method are asyncronous, than, await.
    // If any error throws an DioError. But these errors are responsibility of
    // controller to manipulate the screen state.
    Response<List> response = await dio.put('/album/search', data: filter);

    // Case success.
    if (_successResponse(response)) {
      return response.data.map<AlbumModel>((json) => AlbumModel.fromJson(json)).toList();
    } else {

      // Case error, return null.
      return null;
    }
  }

  // uploadImage send image to backend to send AWS S3.
  // This method receive an List of Images, because the
  // backend can receive an List of MultipartFile.
  Future<List<AmazonImageModel>> uploadImages(List<File> images) async {
    // Create the FormData from Dio.
    var formData = FormData();

    // Populate the formData files with the field "images"
    // Thats images for Dio is a MapEntry of String, MultipartFile,
    // easl'y no? If you builded the backend, it receive an MultipartFile like Dio can send!
    formData.files.addAll(images.map<MapEntry<String, MultipartFile>>((image) => _createMapEntryFromFile(image)));

    // Now, is easy. Call the API.
    Response<List> response = await dio.post<List>(
        '/amazon/images',
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded'
          }
        )
    );

    // Case success.
    if (_successResponse(response)) {
      return response.data.map<AmazonImageModel>((json) => AmazonImageModel.fromJson(json)).toList();
    } else {

      // Case error, return null.
      return null;
    }

  }

  // Insert the Album.
  Future<AlbumModel> insertAlbum(AlbumModel albumModel) async {
      Response<Map> response = await dio.post('/album', data: albumModel);

      // Case success.
      if (_successResponse(response)) {
        return AlbumModel.fromJson(response.data);
      } else {

        // Case error, return null.
        return null;
      }
  }

  MapEntry<String, MultipartFile> _createMapEntryFromFile(File image) {
    return MapEntry<String, MultipartFile>('images', MultipartFile
            .fromFileSync(image.path, filename: basename(image.path)));
  }

  @override
  void dispose() { }

  bool _successResponse(Response response) => response.statusCode >= 200 && response.statusCode < 300;
}
