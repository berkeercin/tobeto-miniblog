import 'package:image_picker/image_picker.dart';

abstract class AddArticleEvent {}

class AddArticle extends AddArticleEvent {
  final XFile? selectedImage;
  final String title;
  final String content;
  final String author;
  AddArticle(this.selectedImage, this.title, this.content, this.author);
}

class ResetArticles extends AddArticleEvent {}
