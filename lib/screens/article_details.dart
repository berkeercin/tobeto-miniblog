import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import "package:http/http.dart" as http;

import 'package:flutter/material.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/models/article.dart';

class ArticleDetails extends StatefulWidget {
  const ArticleDetails({required this.blogId, Key? key}) : super(key: key);
  final String blogId;
  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArticleBloc, ArticleState>(
      builder: (context, state) {
        if (state is ArticleLoaded) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text(state.article.title == null
                  ? "İçerik yükleniyor"
                  : state.article.title!),
              leading: InkWell(
                child: Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.pop(context);
                  context.read<ArticleBloc>().add(FetchArticles());
                },
              ),
            ),
            body: state.article.id == null
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Column(children: [
                          AspectRatio(
                              aspectRatio: 4 / 3,
                              child: Image.network(state.article.thumbnail!)),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            state.article.content!,
                            style: TextStyle(letterSpacing: 1.2),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            state.article.author!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 24),
                          )
                        ]),
                      ),
                    ),
                  ),
          );
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              title: Text("İçerik yükleniyor"),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
