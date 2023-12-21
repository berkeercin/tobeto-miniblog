import 'dart:convert';
import 'dart:io';
import "package:http/http.dart" as http;

import 'package:flutter/material.dart';
import 'package:miniblog/models/blog.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({required this.blogId, Key? key}) : super(key: key);
  final String blogId;
  @override
  _BlogDetailsState createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  List<Blog> blogList = [];
  Blog blog = Blog();
  fetchBlogs() async {
    Uri url = Uri.parse(
        "https://tobetoapi.halitkalayci.com/api/Articles/${widget.blogId}");
    final response = await http.get(url);
    print(json.decode(response.body));
    final jsonData = json.decode(response.body);
    setState(() {
      blog = Blog.fromJson(jsonData);
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
