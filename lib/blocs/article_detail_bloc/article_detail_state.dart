import 'package:miniblog/models/article.dart';

abstract class ArticleDetailState {}

class ArticlesInitial extends ArticleDetailState {}

class ArticlesLoading extends ArticleDetailState {}

class ArticlesLoaded extends ArticleDetailState {
  final List<Article> articles;

  ArticlesLoaded({required this.articles});
}

class ArticleLoaded extends ArticleDetailState {
  final Article article;
  ArticleLoaded({required this.article});
}

class ArticlesError extends ArticleDetailState {}
