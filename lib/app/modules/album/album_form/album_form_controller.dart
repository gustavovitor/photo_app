import 'dart:io';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:photos_app/app/modules/shared/models/album/album_model.dart';
import 'package:photos_app/app/modules/shared/repository/album_repository.dart';

part 'album_form_controller.g.dart';

class AlbumFormController = _AlbumFormBase with _$AlbumFormController;

abstract class _AlbumFormBase with Store {

  // Get Repository Instance
  AlbumRepository _albumRepository = Modular.get();

  // Simple logic to check if is editing or is insert new Album.
  AlbumModel savedAlbum;
  setSavedAlbum(AlbumModel albumModel) => savedAlbum = albumModel;

  // State Management
  @observable
  AlbumFormState albumFormState = AlbumFormState.IDLE;

  // Save Album
  @action
  saveAlbum(Map<String, dynamic> form) async {
    // Set state to Loading to disable form and save button.
    albumFormState = AlbumFormState.LOADING;

    // Capture typed fields from form.
    List images = form['images'] as List;
    String title = form['title'] as String;

    // Get images to send to Amazon.
    List<File> imageNotSaved = images.where((image) => image is File).whereType<File>().toList();
    if (savedAlbum == null) {

      // New Album
      AlbumModel albumModel = AlbumModel(
        // First, upload images to Amazon.
        images: await _albumRepository.uploadImages(imageNotSaved),
        title: title
      );

      // Save Album
      await _albumRepository.insertAlbum(albumModel);
      Modular.to.pop();
      albumFormState = AlbumFormState.IDLE;
    } else {
      // TODO: Update Album Here
    }
    albumFormState = AlbumFormState.IDLE;
  }

}

enum AlbumFormState { IDLE, LOADING }