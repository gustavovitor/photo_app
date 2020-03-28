import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:photos_app/app/modules/shared/models/album/album_model.dart';
import 'package:photos_app/app/modules/shared/repository/album_repository.dart';

part 'album_controller.g.dart';

class AlbumController = _AlbumBase with _$AlbumController;

abstract class _AlbumBase with Store {

  AlbumRepository _albumRepository = Modular.get();

  List<AlbumModel> albums = [];

  // Create an enumeraiton to easl'y manage the page state.
  @observable
  AlbumState albumState = AlbumState.LOADING;

  @action
  fetchAlbums(AlbumModel filter) async {
    albumState = AlbumState.LOADING;

    albums = [];
    albums.addAll(await _albumRepository.findAllAlbums(filter));

    if (albums.length > 0) {
      albumState = AlbumState.IDLE;
    } else {
      albumState = AlbumState.NOITENS;
    }

  }

}

enum AlbumState { IDLE, LOADING, NOITENS }
