import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/photos.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/photo_widget.dart';

class PhotosTab extends StatelessWidget {
  const PhotosTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Photos>(
      title: 'Photos',
      onFetch: ApiService.fetchPhotos,
      searchFilter: (photo, query) {
        return photo.title.toLowerCase().contains(query.toLowerCase());
      },
      itemBuilder: (context, photo, index) {
        return PhotoWidget(photos: photo);
      },
    );
  }
}
