import 'dart:convert';
import "package:http/http.dart" as http;

import 'package:flutter/material.dart';
import 'package:miniblog/models/article.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({required this.blogId, Key? key}) : super(key: key);
  final String blogId;
  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  List<Article> blogList = [];
  Article blog = Article();
  fetchBlogs() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.get(url);
    print(json.decode(response.body));
    final jsonData = json.decode(response.body);
    setState(() {
      blog = Article.fromJson(jsonData);
      // jsonData.map((json) => Blog.fromJson(json)).toList();
      // print(blogList[0]);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchBlogs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(blog.title == null ? "İçerik yükleniyor" : blog.title!),
      ),
      body: blog.id == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Column(children: [
                    AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Image.network(blog.thumbnail!)),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      blog.content!,
                      style: TextStyle(letterSpacing: 1.2),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      blog.author!,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    )
                  ]),
                ),
              ),
            ),
    );
  }
}
