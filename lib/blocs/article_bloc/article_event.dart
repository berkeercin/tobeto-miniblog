import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class FetchArticle extends ArticleEvent {
  final String? id;
  FetchArticle(this.id);
}

class AddArticle extends ArticleEvent {
  final XFile? selectedImage;
  final String title;
  final String content;
  final String author;
  AddArticle(this.selectedImage, this.title, this.content, this.author);
}
