import 'package:flutter/material.dart';
import 'package:jsonplaceholder/model/comments.dart';
import 'package:jsonplaceholder/service/api_service.dart';
import 'package:jsonplaceholder/widget/async_data_view.dart';
import 'package:jsonplaceholder/widget/comment_widget.dart';

class CommentsTab extends StatelessWidget {
  const CommentsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Comments>(
      title: 'Comments',
      onFetch: ApiService.fetchComments,
      searchFilter: (comment, query) {
        final q = query.toLowerCase();
        return comment.name.toLowerCase().contains(q) ||
            comment.email.toLowerCase().contains(q) ||
            comment.body.toLowerCase().contains(q);
      },
      itemBuilder: (context, comment, index) {
        return CommentWidget(comments: comment);
      },
    );
  }
}
