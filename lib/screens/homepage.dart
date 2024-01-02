import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:miniblog/blocs/article_bloc/article_bloc.dart';
import 'package:miniblog/blocs/article_bloc/article_event.dart';
import 'package:miniblog/blocs/article_bloc/article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_bloc.dart';
import 'package:miniblog/screens/add_article.dart';
import 'package:miniblog/screens/article_details.dart';
import 'package:miniblog/widgets/article_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:miniblog/blocs/article_detail_bloc/article_detail_event.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool darkMode = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDarkMode();
    setJson();
    getJson();
    context.read<ArticleBloc>().add(ResetArticles());
  }

  void setJson() async {
    Map<String, dynamic> json = {
      'name': 'Berke',
      'surname': "Erçin",
      'age': 19
    };
    final sharedPrefs = await SharedPreferences.getInstance();
    final jsonAsString = jsonEncode(json);
    sharedPrefs.setString("user", jsonAsString);
  }

  void getJson() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final jsonAsString = sharedPrefs.getString("user");
    Map<String, dynamic> json = jsonDecode(jsonAsString!);
  }

  void getDarkMode() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final isDarkMode = sharedPrefs.getBool("darkMode");
    if (isDarkMode != null) {
      setState(() {
        darkMode = isDarkMode;
      });
    }
  }

  void onDarkModeChange(bool value) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool("darkMode", value);
    setState(() {
      darkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog Listesi"),
        actions: [
          IconButton(
              onPressed: () async {
                bool? result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => AddArticlePage()));
                if (result == true) {
                  // fetchBlogs();
                }
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: BlocBuilder<ArticleBloc, ArticleState>(builder: (context, state) {
        if (state is ArticlesInitial) {
          context.read<ArticleBloc>().add(FetchArticles());

          return Center(child: Text("İstek yükleniyor"));
        }

        if (state is ArticlesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ArticlesError) {
          return const Center(
            child: Text("İstek hatalı..."),
          );
        }

        if (state is ArticlesLoaded) {
          return Column(
            children: [
              Switch(
                value: darkMode,
                onChanged: (value) {
                  onDarkModeChange(value);
                },
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.articles.length,
                  itemBuilder: (context, index) => InkWell(
                    onTap: () {
                      context
                          .read<ArticleDetailBloc>()
                          .add(FetchArticleDetails(state.articles[index].id));
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => ArticleDetails(
                              blogId: state.articles[index].id!)));
                    },
                    child: ArticleItem(
                      article: state.articles[index],
                    ),
                  ),
                ),
              ),
            ],
          );
        }

        print(state);
        return const Center(
          child: Text("Bilinmedik Durum"),
        );
      }),
    );
  }
}
