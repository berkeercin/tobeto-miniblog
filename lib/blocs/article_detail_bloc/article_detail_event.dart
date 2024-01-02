import 'package:image_picker/image_picker.dart';

abstract class ArticleDetailEvent {}

class FetchArticleDetails extends ArticleDetailEvent {
  final String? id;
  FetchArticleDetails(this.id);
}

class ResetArticleDetails extends ArticleDetailEvent {}
