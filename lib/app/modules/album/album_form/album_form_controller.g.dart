// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_form_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AlbumFormController on _AlbumFormBase, Store {
  final _$albumFormStateAtom = Atom(name: '_AlbumFormBase.albumFormState');

  @override
  AlbumFormState get albumFormState {
    _$albumFormStateAtom.context.enforceReadPolicy(_$albumFormStateAtom);
    _$albumFormStateAtom.reportObserved();
    return super.albumFormState;
  }

  @override
  set albumFormState(AlbumFormState value) {
    _$albumFormStateAtom.context.conditionallyRunInAction(() {
      super.albumFormState = value;
      _$albumFormStateAtom.reportChanged();
    }, _$albumFormStateAtom, name: '${_$albumFormStateAtom.name}_set');
  }

  final _$saveAlbumAsyncAction = AsyncAction('saveAlbum');

  @override
  Future saveAlbum(Map<String, dynamic> form) {
    return _$saveAlbumAsyncAction.run(() => super.saveAlbum(form));
  }

  @override
  String toString() {
    final string = 'albumFormState: ${albumFormState.toString()}';
    return '{$string}';
  }
}
