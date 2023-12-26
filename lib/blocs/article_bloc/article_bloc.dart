import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:miniblog/repostories/article_repostory.dart';

class ArticleBloc extends Bloc<ArticleEvent, ArticleState> {
  final ArticleRepostory articleRepostory;
  ArticleBloc({required this.articleRepostory}) : super(ArticlesInitial()) {
    on<FetchArticles>(_onFetch);
    on<AddArticle>(_onAdd);
    on<FetchArticle>(_onFetchArticle);
  }

  void _onFetch(FetchArticles event, Emitter<ArticleState> emit) async {
    emit(ArticlesLoading());
    final articles = await articleRepostory.fetchBlogs();
    emit(ArticlesLoaded(articles: articles));
    // ...
  }

  void _onFetchArticle(FetchArticle event, Emitter<ArticleState> emit) async {
    final article = await articleRepostory.fetchBlog(event.id!);
    emit(ArticleLoaded(article: article));
    // ...
  }

  void _onAdd(AddArticle event, Emitter<ArticleState> emit) async {
    final addArticle = await articleRepostory.addBlog(
        event.selectedImage, event.title, event.content, event.author);
    if (addArticle == true) {}
  }
}
