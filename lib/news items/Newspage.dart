import 'dart:convert';
import 'dart:async';
import 'Feed.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

//TODO: investigate string? issue, make widget to show articles

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
    futureNews = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Center(
        child: FutureBuilder<Feed>(
          initialData: null,
          future: futureNews,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(snapshot.data!.articles[0].title);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }

  Future<Feed> fetchAlbum() async {
    final response = await http.get(Uri.parse(
        'http://api.mediastack.com/v1/news?access_key=ad9c22732ed9c3fb2362fb419f16cc0e'));

    if (response.statusCode == 200) {
      return Feed.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load Album');
    }
  }
}
