import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mad_news_app/Widgets/ArticleViewer.dart';

import 'Feed.dart';

//TODO: make widget to show articles

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsPage> {
  late Future<Feed> futureNews;

  @override
  void initState() {
    super.initState();
    futureNews = fetchFeed();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Newsfeed'),
      ),
      body: Center(
        child: FutureBuilder<Feed>(
          initialData: null,
          future: futureNews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data!.articles
                    .map((e) => ArticleViewer(e))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<Feed> fetchFeed() async {
    String url =
        'http://api.mediastack.com/v1/news?access_key=7bcf8c4596abf9cff9e3ff632c5138d0';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return Feed.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Album');
    }
  }
}
