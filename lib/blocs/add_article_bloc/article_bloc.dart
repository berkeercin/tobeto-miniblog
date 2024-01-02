import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/add_article_bloc/article_event.dart';
import 'package:miniblog/blocs/add_article_bloc/article_state.dart';
import 'package:miniblog/repostories/article_repostory.dart';

class AddArticleBloc extends Bloc<AddArticleEvent, AddArticleState> {
  final ArticleRepostory articleRepostory;
  AddArticleBloc({required this.articleRepostory})
      : super(AddArticlesInitial()) {
    on<AddArticle>(_onAdd);
    on<ResetArticles>(_onReset);
  }

  void _onReset(ResetArticles event, Emitter<AddArticleState> emit) async {
    emit(AddArticlesInitial());
  }

  void _onAdd(AddArticle event, Emitter<AddArticleState> emit) async {
    final addArticle = await articleRepostory.addBlog(
        event.selectedImage, event.title, event.content, event.author);
    if (addArticle == true) {
      emit(AddArticlePop());
    }
  }
}
