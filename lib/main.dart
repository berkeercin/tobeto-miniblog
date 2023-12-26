import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/repostories/article_repostory.dart';
import 'package:miniblog/screens/homepage.dart';

void main() {
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<ArticleBloc>(
          create: (context) =>
              ArticleBloc(articleRepostory: ArticleRepostory()))
    ],
    child: MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Homepage(),
    ),
  ));
}
