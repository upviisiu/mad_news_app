import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  int offset = 0;
  num aspectWidth = 2;
  num aspectHeight = 1;

  //TODO: finish the sort shit
  bool authorAsc = false;
  bool titleAsc = false;
  bool popularityAsc = false;
  String language = "";
  //ar - Arabic
  //de - German
  //en - English
  //es - Spanish
  //fr - French
  //he - Hebrew
  //it - Italian
  // nl - Dutch
  //no - Norwegian
  //pt - Portuguese
  //ru - Russian
  //se - Swedish
  //zh - Chinese
  String country = "";
  //https://mediastack.com/sources
  bool dateAsc = false;

  late Future<Feed> futureNews;

  updateApiUrl(String string) {
    apiUrl += string;
  }

  //Gridview swap shenanigans
  changeMode() {
    if (countValue == 2) {
      setState(() {
        countValue = 1;
        aspectWidth = 3;
        aspectHeight = 1;
        Navigator.pop(context);
      });
    } else {
      setState(() {
        countValue = 2;
        aspectWidth = 2;
        aspectHeight = 1;
        Navigator.pop(context);
      });
    }
  }

  updateFeed() {
    print(apiUrl);
    setState(() {
      futureNews = fetchFeed();
    });
  }

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
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                final result =
                    await showSearch(context: context, delegate: Search());
                updateApiUrl(result.toString());
                updateFeed();
              },
              icon: Icon(Icons.search)),
          IconButton(
            onPressed: changeMode,
            icon: Icon(Icons.keyboard_control),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                  //color: Colors.red,
                  ),
              child: null,
            ),
            ListTile(
              title: Text("Change view"),
              onTap: changeMode,
            )
          ],
        ),
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
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                offset >= 26
                    ? offset -= 26
                    : showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return new AlertDialog(
                        title: Text("Error!"),
                        content: Text("Already on First page"),
                      );
                    });
                offset >= 0
                    ? updateApiUrl("&offset=" + offset.toString())
                    : showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return new AlertDialog(
                            title: Text("Error!"),
                            content: Text("Already on First page"),
                          );
                        });
                updateFeed();
              },
              icon: Icon(Icons.arrow_back),
            ),
            label: "Previous",
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                offset += 26;
                updateApiUrl("&offset=" + offset.toString());
                updateFeed();
              },
              icon: Icon(Icons.arrow_forward),
            ),
            label: "Next",
          )
        ],
      ),
    );
  }

  Future<Feed> fetchFeed() async {
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
          result = query;
          result.toString();
          result = result.replaceAll(' ', '%20');
          result = "&keywords=" + result;

          close(context, result);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    result = query;
    result.toString();
    result = result.replaceAll(' ', '%20');
    result = "&keywords=" + result;

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
