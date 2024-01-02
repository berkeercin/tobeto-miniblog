import 'package:flutter_bloc/flutter_bloc.dart';
import 'article_detail_event.dart';
import 'article_detail_state.dart';
import 'package:miniblog/repostories/article_repostory.dart';

class ArticleDetailBloc extends Bloc<ArticleDetailEvent, ArticleDetailState> {
  final ArticleRepostory articleRepostory;
  ArticleDetailBloc({required this.articleRepostory})
      : super(ArticlesInitial()) {
    on<FetchArticleDetails>(_onFetchArticle);
    on<ResetArticleDetails>(_onReset);
  }

  void _onReset(
      ResetArticleDetails event, Emitter<ArticleDetailState> emit) async {
    emit(ArticlesInitial());
  }

  void _onFetchArticle(
      FetchArticleDetails event, Emitter<ArticleDetailState> emit) async {
    final article = await articleRepostory.fetchBlog(event.id!);
    emit(ArticleLoaded(article: article));
    // ...
  }
}
