import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:photos_app/app/modules/album/album_controller.dart';
import 'package:photos_app/app/modules/shared/models/album/album_model.dart';
import 'package:photos_app/app/modules/shared/models/amazon/amazon_image_model.dart';
import 'package:transparent_image/transparent_image.dart';

class AlbumPage extends StatefulWidget {
  final String title;

  const AlbumPage({Key key, this.title = "Album"}) : super(key: key);

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends ModularState<AlbumPage, AlbumController> {

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<FormBuilderState> _searchFormBuilderKey = new GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();

    controller.fetchAlbums(AlbumModel());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          await Modular.to.pushNamed('/form');
          controller.fetchAlbums(AlbumModel());
        },
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: <Widget>[
                  Text('Albums', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),),
                  SizedBox(height: 12,),
                  FormBuilder(
                    onChanged: (_) {
                      controller.fetchAlbums(AlbumModel.fromJson(_searchFormBuilderKey.currentState.value));
                    },
                    key: _searchFormBuilderKey,
                    initialValue: {
                      'title': null
                    },
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: 'title',
                          maxLines: 1,
                          decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)
                            )
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Observer(builder: (_) {
                  if (controller.albumState == AlbumState.LOADING) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (controller.albumState == AlbumState.IDLE) {
                    return RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () async {
                        _searchFormBuilderKey.currentState.reset();
                        await controller.fetchAlbums(AlbumModel());
                      },
                      child: ListView.builder(
                          itemCount: controller.albums.length, itemBuilder: (_, i) => _buildAlbumTile(controller.albums[i])),
                    );
                  } else {
                    return Container();
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAlbumTile(AlbumModel albumModel) {
    return GestureDetector(
      onTap: () {
        Modular.to.pushNamed('/form', arguments: albumModel);
      },
      child: Card(
        margin: EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            children: <Widget>[
              Text(
                albumModel.title,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                height: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: albumModel.images.length,
                    itemBuilder: (_, i) => _buildImage(albumModel.images[i]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(AmazonImageModel amazonImageModel) {
    return ClipRRect(
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: amazonImageModel.imageUrl,
        fit: BoxFit.cover,
        width: 120,
        height: 120,
      ),
    );
  }
}
