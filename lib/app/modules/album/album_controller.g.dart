// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbumController on _AlbumBase, Store {
  final _$albumStateAtom = Atom(name: '_AlbumBase.albumState');

  @override
  AlbumState get albumState {
    _$albumStateAtom.context.enforceReadPolicy(_$albumStateAtom);
    _$albumStateAtom.reportObserved();
    return super.albumState;
  }

  @override
  set albumState(AlbumState value) {
    _$albumStateAtom.context.conditionallyRunInAction(() {
      super.albumState = value;
      _$albumStateAtom.reportChanged();
    }, _$albumStateAtom, name: '${_$albumStateAtom.name}_set');
  }

  final _$fetchAlbumsAsyncAction = AsyncAction('fetchAlbums');

  @override
  Future fetchAlbums(AlbumModel filter) {
    return _$fetchAlbumsAsyncAction.run(() => super.fetchAlbums(filter));
  }

  @override
  String toString() {
    final string = 'albumState: ${albumState.toString()}';
    return '{$string}';
  }
}
