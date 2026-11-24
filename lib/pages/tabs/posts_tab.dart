import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/posts.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/post_widget.dart';

class PostsTab extends StatelessWidget {
  const PostsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Posts>(
      title: 'Posts',
      onFetch: ApiService.fetchPosts,
      searchFilter: (post, query) {
        final q = query.toLowerCase();
        return post.title.toLowerCase().contains(q) ||
            post.body.toLowerCase().contains(q);
      },
      itemBuilder: (context, post, index) {
        return PostWidget(posts: post);
      },
    );
  }
}
