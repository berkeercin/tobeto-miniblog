import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:http/http.dart' as http;
import 'package:miniblog/models/article.dart';
import 'package:miniblog/repostories/article_repostory.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepostory articleRepostory;
  ArticleBloc({required this.articleRepostory}) : super(ArticlesInitial()) {
    on<FetchArticles>(_onFetch);
    on<AddArticle>(_onAdd);
  }

  void _onFetch(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    final articles = await articleRepostory.fetchBlogs();
    emit(ArticlesLoaded(articles: articles));
    // ...
  }

  void _onAdd(AddArticle event, Emitter<ArticleState> emit) {}
}
