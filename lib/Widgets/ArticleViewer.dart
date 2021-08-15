import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_news_app/news%20items/Article.dart';

class ArticleViewer extends StatelessWidget {
  final Article article;

  ArticleViewer(this.article);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.red.withAlpha(30),
        onTap: () {
          //TODO: implement on tap go to Article page
        },
        child: Text(article.title),
      ),
    );
  }
}
