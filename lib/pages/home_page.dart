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
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.auto_awesome_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'JSONPlaceholder',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      letterSpacing: -0.4,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  Text(
                    'REST API Explorer',
                    style: TextStyle(
                      fontSize: 11,
                      color: Colors.grey.shade500,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(62),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1),
                ),
              ),
              child: const TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorWeight: 3,
                indicatorColor: Color(0xFF6366F1),
                labelColor: Color(0xFF6366F1),
                unselectedLabelColor: Color(0xFF64748B),
                labelStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
                tabs: [
                  Tab(icon: Icon(Icons.article_outlined, size: 20), text: 'Posts (100)'),
                  Tab(icon: Icon(Icons.forum_outlined, size: 20), text: 'Comments (500)'),
                  Tab(icon: Icon(Icons.photo_library_outlined, size: 20), text: 'Albums (100)'),
                  Tab(icon: Icon(Icons.people_alt_outlined, size: 20), text: 'Users (10)'),
                  Tab(icon: Icon(Icons.image_outlined, size: 20), text: 'Photos (5000)'),
                  Tab(icon: Icon(Icons.task_alt_outlined, size: 20), text: 'Todos (200)'),
                ],
              ),
            ),
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
