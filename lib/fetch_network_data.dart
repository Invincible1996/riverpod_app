// Model class
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

// Repository class
class PostRepository {
  final http.Client _client;

  PostRepository(this._client);

  Future<List<Post>> fetchPosts() async {
    final response = await _client
        .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      final posts = jsonDecode(response.body) as List<dynamic>;
      return posts.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to fetch posts');
    }
  }
}

final postRepositoryProvider = Provider((ref) => PostRepository(http.Client()));

// Riverpod provider
final postProvider = FutureProvider<List<Post>>((ref) async {
  final repository = ref.read(postRepositoryProvider);
  return await repository.fetchPosts();
});

// UI
class FetchNetworkData extends ConsumerWidget {
  const FetchNetworkData({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My HomePage'),
      ),
      body: posts.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final post = data[index];
              return ListTile(
                title: Text(post.title),
                subtitle: Text(post.body),
              );
            },
          );
        },
        loading: () {
          return const CircularProgressIndicator();
        },
        error: (error, stackTrace) {
          return Text('Error: $error');
        },
      ),
    );
  }
}
