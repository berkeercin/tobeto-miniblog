import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class AddArticle extends ArticleEvent {}
