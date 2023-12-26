import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:miniblog/models/article.dart';

class ArticleRepostory {
  Future<List<Article>> fetchBlogs() async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
    final response = await http.get(url);
    final List jsonData = json.decode(response.body);

    return jsonData.map((json) => Article.fromJson(json)).toList();
  }

  Future<Article> fetchBlog(String id) async {
    Uri url =
        Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles/${id}");
    final response = await http.get(url);
    print(json.decode(response.body));
    final jsonData = json.decode(response.body);
    return Article.fromJson(jsonData);
  }

  Future<bool> addBlog(
      XFile? selectedImage, String title, String content, String author) async {
    Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");

    var request = http.MultipartRequest("POST", url);

    request.fields["title"] = title;
    request.fields["content"] = content;
    request.fields["author"] = author;
    if (selectedImage != null) {
      http.MultipartFile file =
          await http.MultipartFile.fromPath("File", selectedImage.path);
      request.files.add(file);
    }

    final response = await request.send();
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
