import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/post.dart';

class PostService {
  final url = "https://jsonplaceholder.typicode.com/posts";

  Future<Post> fetchPost() async {
    var res = await http.get(Uri.parse(url));

    if (res.statusCode == 200) {
      var jsonBody = Post.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      throw Exception("Hata olustu ${res.statusCode}");
    }
  }
}
