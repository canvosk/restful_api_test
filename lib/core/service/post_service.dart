import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/post.dart';

class PostService {
  final url = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Post>> fetchPost() async {
    List<Post> _posts = [];
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var jsonBody = jsonDecode(res.body);
      if (jsonBody is List) {
        jsonBody.forEach((x) {
          _posts.add(Post.fromJson(x));
        });
        return _posts;
      } else {
        return throw Exception("Hata olustu ${res.statusCode}");
      }
    } else {
      throw Exception("Hata olustu ${res.statusCode}");
    }
  }
}
