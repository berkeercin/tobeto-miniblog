import 'package:flutter/material.dart';
import "package:http/http.dart" as http;
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Blog Listesi"),
          actions: [
            IconButton(
                onPressed: () async {
                  bool? result = await Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Container()));
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
            if (state is ArticlesInitial) {
              context.read<ArticleBloc>().add(FetchArticles());

              return Center(child: Text("İstek yükleniyor"));
            }

            if (state is ArticlesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ArticlesError) {
              return const Center(
                child: Text("İstek hatalı..."),
              );
            }

            if (state is ArticlesLoaded) {
              return ListView.builder(
                itemCount: state.articles.length,
                itemBuilder: (context, index) =>
                    ArticleItem(article: state.articles[index]),
              );
            }

            return const Center(
              child: Text("Bilinmedik Durum"),
            );
          }),
        ));
  }
}
