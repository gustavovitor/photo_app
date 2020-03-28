import 'package:photos_app/app/modules/album/album_module.dart';
import 'package:photos_app/app/modules/shared/repository/album_repository.dart';
import 'package:dio/dio.dart';
import 'package:photos_app/app/app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:photos_app/app/app_widget.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        // Inject to AlbumRepository the Dio instance.
        Bind((i) => AlbumRepository(
          dio: i.get()
        )),
        Bind((i) => AppController()),
        Bind((i) => Dio(BaseOptions(baseUrl: 'http://192.168.0.106:8080')))
      ];

  @override
  List<Router> get routers => [
        Router('/', module: AlbumModule()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
