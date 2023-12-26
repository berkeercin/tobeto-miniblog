import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/models/article.dart';
import 'package:miniblog/screens/add_article.dart';
import 'package:miniblog/screens/article_details.dart';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/widgets/article_item.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  // fetchBlogs() async {
  //   Uri url = Uri.parse("https://tobetoapi.halitkalayci.com/api/Articles");
  //   final response = await http.get(url);
  //   final List jsonData = json.decode(response.body);
  //   setState(() {
  //     articleList = jsonData.map((json) => Article.fromJson(json)).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog Listesi"),
          actions: [
            IconButton(
                onPressed: () async {
                  bool? result = await Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const AddArticle()));
                  if (result == true) {
                    // fetchBlogs();
                  }
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: BlocProvider(
          create: (context) => ArticleBloc(),
          child:
              BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
            return const Center(
              child: Text("Yazı"),
            );
          }),
        ));
  }
}
