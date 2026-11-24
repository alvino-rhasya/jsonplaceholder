// facebook.com => baseURL (const)
// facebook.com/posts => /posts sebagai endpoint

import 'dart:convert';

import 'package:jsonplaceholder/model/albums.dart';
import 'package:jsonplaceholder/model/comments.dart';
import 'package:jsonplaceholder/model/photos.dart';
import 'package:jsonplaceholder/model/posts.dart';
import 'package:http/http.dart' as http;
import 'package:jsonplaceholder/model/todos.dart';
import 'package:jsonplaceholder/model/users.dart';

class ApiService {
  static const String baseURL = 'https://jsonplaceholder.typicode.com';

  static Future<List<Posts>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseURL/posts'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((json) => Posts.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Gagal memuat posts (HTTP ${response.statusCode})',
      );
    }
  }

  static Future<List<Photos>> fetchPhotos() async {
    final response = await http.get(Uri.parse('$baseURL/photos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((json) => Photos.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Gagal memuat photos (HTTP ${response.statusCode})',
      );
    }
  }

  static Future<List<Comments>> fetchComments() async {
    final response = await http.get(Uri.parse('$baseURL/comments'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((json) => Comments.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Gagal memuat comments (HTTP ${response.statusCode})',
      );
    }
  }

  static Future<List<Albums>> fetchAlbums() async {
    final response = await http.get(Uri.parse('$baseURL/albums'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((json) => Albums.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Gagal memuat albums (HTTP ${response.statusCode})',
      );
    }
  }

  static Future<List<Todos>> fetchTodos() async {
    final response = await http.get(Uri.parse('$baseURL/todos'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((json) => Todos.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Gagal memuat todos (HTTP ${response.statusCode})',
      );
    }
  }

  static Future<List<Users>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseURL/users'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      return data
          .map((json) => Users.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception(
        'Gagal memuat users (HTTP ${response.statusCode})',
      );
    }
  }
}