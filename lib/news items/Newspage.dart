import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mad_news_app/Widgets/ArticleViewer.dart';

import 'Feed.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<NewsPage> {
  String apiUrl =
      'http://api.mediastack.com/v1/news?access_key=7bcf8c4596abf9cff9e3ff632c5138d0&languages=en&limit=26';
  int countValue = 2;
  num aspectWidth = 2;
  num aspectHeight = 1;
  late Future<Feed> futureNews;

  //Gridview swap shenanigans
  changeMode() {
    if (countValue == 2) {
      setState(() {
        countValue = 1;
        aspectWidth = 3;
        aspectHeight = 1;
      });
    } else {
      setState(() {
        countValue = 2;
        aspectWidth = 2;
        aspectHeight = 1;
      });
    }
  }

  updateFeed(var result) {
    setState(() {
      futureNews = fetchFeed(result);
    });
  }

  @override
  void initState() {
    super.initState();
    futureNews = fetchFeed("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Newsfeed'),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                final result =
                    await showSearch(context: context, delegate: Search());
                result == null ? updateFeed("") : updateFeed(result);
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: changeMode,
              icon: countValue == 2
                  ? const Icon(Icons.list)
                  : const Icon(Icons.grid_view)),
        ],
      ),
      body: Center(
        child: FutureBuilder<Feed>(
          initialData: null,
          future: futureNews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.count(
                crossAxisCount: countValue,
                childAspectRatio: (aspectWidth / aspectHeight),
                children: snapshot.data!.articles
                    .map((e) => ArticleViewer(e, countValue))
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

  Future<Feed> fetchFeed(String? string) async {
    string = string.toString();
    string = string.replaceAll(' ', '%20');
    String searchUrl = "&keywords=" + string;

    if (string != "") {
      apiUrl += "$searchUrl";
    }
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return Feed.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Feed');
    }
  }
}

//search
class Search extends SearchDelegate<String> {
  var result = '';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, result);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    result = query;
    close(context, result);
    return ListTile();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListTile(
      subtitle: Text(
        "Enter search terms",
        textAlign: TextAlign.center,
      ),
    );
  }
}
