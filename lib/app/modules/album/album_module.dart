import 'package:photos_app/app/modules/album/album_form/album_form_controller.dart';
import 'package:photos_app/app/modules/album/album_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photos_app/app/modules/album/album_form/album_form_page.dart';
import 'package:photos_app/app/modules/album/album_page.dart';

class AlbumModule extends ChildModule {
  @override
  List<Bind> get binds => [
        Bind((i) => AlbumFormController()),
        Bind((i) => AlbumController()),
      ];

  @override
  List<Router> get routers => [
        Router('/', child: (_, args) => AlbumPage()),
        Router('/form', child: (_, args) => AlbumFormPage(savedAlbum: args.data)),
      ];

  static Inject get to => Inject<AlbumModule>.of();
}
