import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mad_news_app/news%20items/Article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleViewer extends StatelessWidget {
  final Article article;
  final int countValue;

  ArticleViewer(this.article, this.countValue);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: countValue == 2
            ? null
            : CachedNetworkImage(
                imageUrl: article.image,
                placeholder: (context, url) => new CircularProgressIndicator(),
                errorWidget: (context, url, error) => Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6c/No_image_3x4.svg/2560px-No_image_3x4.svg.png'),
              ),
        subtitle: Text(
          article.title,
          textAlign: TextAlign.center,
          overflow: TextOverflow.fade,
        ),
        isThreeLine: true,
        onTap: () {
          showNews(article.url);
        },
        trailing: IconButton(
          icon: Icon(Icons.star_border),
          onPressed: addToFavorites,
        ),
        contentPadding: EdgeInsets.all(0),
      ),
    );
  }

  showNews(String url) async {
    if (await canLaunch(url))
      await launch(url);
    else
      throw "Could not launch $url";
  }
}

addToFavorites() {
  //TODO: Implement favorites
}
