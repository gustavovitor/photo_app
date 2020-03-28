import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photos_app/app/modules/album/album_form/album_form_controller.dart';
import 'package:photos_app/app/modules/album/album_form/form_builder_image_field.dart';
import 'package:photos_app/app/modules/shared/models/album/album_model.dart';

class AlbumFormPage extends StatefulWidget {
  final AlbumModel savedAlbum;

  const AlbumFormPage({Key key, this.savedAlbum}) : super(key: key);

  @override
  _AlbumFormPageState createState() => _AlbumFormPageState();
}

class _AlbumFormPageState extends ModularState<AlbumFormPage, AlbumFormController> {
  AlbumModel _value;
  Map<String, dynamic> _initialValue;

  final GlobalKey<FormBuilderState> _albumFormBuilderKey = new GlobalKey<FormBuilderState>();

  @override
  void initState() {
    _value = widget.savedAlbum;
    controller.setSavedAlbum(_value);

    if (_value != null) {
      _initialValue = {
        'albumId': _value.albumId,
        'images': _value.images.map<String>((image) => image.imageUrl).toList(),
        'title': _value.title
      };
    } else {
      _initialValue = {
        'albumId': null,
        'title': null,
        'images': []
      };
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 26),
                  child: Text(
                    'New Album',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Observer(
                      builder: (_) => Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.save),
                          onPressed: controller.albumFormState == AlbumFormState.LOADING ? null : () {
                            if (_albumFormBuilderKey.currentState.saveAndValidate()) {
                              controller.saveAlbum(_albumFormBuilderKey.currentState.value);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: <Widget>[
                  Observer(
                    builder: (_) => FormBuilder(
                      readOnly: controller.albumFormState == AlbumFormState.LOADING,
                      key: _albumFormBuilderKey,
                      initialValue: _initialValue,
                      child: Column(
                        children: <Widget>[
                          FormBuilderImageField(
                            attribute: 'images',
                            validators: [
                              (images) {
                                if (images is List) {
                                  if (images.isEmpty) {
                                    return 'Images are required.';
                                  }
                                }
                                return null;
                              }
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FormBuilderTextField(
                            maxLines: 1,
                            attribute: 'title',
                            decoration: InputDecoration(
                                labelText: 'Title',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40)
                                )
                            ),
                            validators: [
                              FormBuilderValidators.required(),
                              FormBuilderValidators.maxLength(64)
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
