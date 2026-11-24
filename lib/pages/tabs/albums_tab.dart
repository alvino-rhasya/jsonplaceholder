import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/albums.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/album_widget.dart';

class AlbumsTab extends StatelessWidget {
  const AlbumsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Albums>(
      title: 'Albums',
      onFetch: ApiService.fetchAlbums,
      searchFilter: (album, query) {
        return album.title.toLowerCase().contains(query.toLowerCase());
      },
      itemBuilder: (context, album, index) {
        return AlbumWidget(albums: album);
      },
    );
  }
}
