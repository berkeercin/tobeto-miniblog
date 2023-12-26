import 'package:flutter/material.dart';
import 'package:miniblog/models/article.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({required this.article, Key? key}) : super(key: key);
  final Article article;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                    color: Colors.grey.withOpacity(0.3),
                    child: Image.network(article.thumbnail!))),
            ListTile(
              title: Text(article.title!),
              subtitle: Text(article.author!),
            )
          ],
        ),
      ),
    );
  }
}
