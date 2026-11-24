import 'package:flutter/material.dart';
import 'package:jsonplaceholder/pages/tabs/posts_tab.dart';
import 'package:jsonplaceholder/pages/tabs/comments_tab.dart';
import 'package:jsonplaceholder/pages/tabs/albums_tab.dart';
import 'package:jsonplaceholder/pages/tabs/users_tab.dart';
import 'package:jsonplaceholder/pages/tabs/photos_tab.dart';
import 'package:jsonplaceholder/pages/tabs/todos_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'JSONPlaceholder API',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: const TabBar(
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            tabs: [
              Tab(icon: Icon(Icons.article), text: 'Posts (100)'),
              Tab(icon: Icon(Icons.comment), text: 'Comments (500)'),
              Tab(icon: Icon(Icons.photo_album), text: 'Albums (100)'),
              Tab(icon: Icon(Icons.people), text: 'Users (10)'),
              Tab(icon: Icon(Icons.photo), text: 'Photos (5000)'),
              Tab(icon: Icon(Icons.check_box), text: 'Todos (200)'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            PostsTab(),
            CommentsTab(),
            AlbumsTab(),
            UsersTab(),
            PhotosTab(),
            TodosTab(),
          ],
        ),
      ),
    );
  }
}
