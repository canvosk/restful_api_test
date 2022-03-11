import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:restful_api_test/core/service/post_service.dart';

import '../core/model/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostService _service = PostService();
  List<Post> posts = [];
  bool isLoading = false;

  Future<void> getPost() async {
    isLoading = !isLoading;
    var _posts = await _service.fetchPost();
    isLoading = !isLoading;

    setState(() {
      posts = _posts;
    });
  }

  @override
  void initState() {
    super.initState();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("API Kullanımı"),
          ),
          body: Container(
            margin: const EdgeInsets.all(0),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(posts[index].title),
                          subtitle: Text(posts[index].body),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
