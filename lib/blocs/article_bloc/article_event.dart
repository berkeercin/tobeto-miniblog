import 'package:image_picker/image_picker.dart';

abstract class ArticleEvent {}

class FetchArticles extends ArticleEvent {}

class ResetArticles extends ArticleEvent {}
