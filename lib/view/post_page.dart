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

  @override
  void initState() {
    super.initState();
    _service.fetchPost().then((value) {
      setState(() {
        isLoading = !isLoading;
        Post newPost = value;
        posts.add(newPost);
        isLoading = !isLoading;
      });
    });
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

// child: FutureBuilder(
//               future: fetchData(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     itemCount: 5,
//                     itemBuilder: (context, index) {
//                       return const Card(
//                         child: ListTile(
//                           title: Text("Title"),
//                           subtitle: Text("Body"),
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//             ),