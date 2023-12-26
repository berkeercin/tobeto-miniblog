import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/article.dart';

class ArticleRepostory {
  Future<List<Article>> fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);

    return jsonData.map((json) => Article.fromJson(json)).toList();
  }
}
