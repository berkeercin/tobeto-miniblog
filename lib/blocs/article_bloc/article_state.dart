import 'package:miniblog/models/article.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ArticleState {}

class ArticlesInitial extends ArticleState {}

class ArticlesLoading extends ArticleState {}

class ArticlesLoaded extends ArticleState {
  final List<Article> articles;

  ArticlesLoaded({required this.articles});
}

class ArticlesError extends ArticleState {}
