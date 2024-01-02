import 'package:miniblog/models/article.dart';

abstract class AddArticleState {}

class AddArticlesInitial extends AddArticleState {}

class AddArticlesError extends AddArticleState {}

class AddArticlePop extends AddArticleState {}
