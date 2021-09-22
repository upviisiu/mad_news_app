import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import 'package:mad_news_app/Widgets/ArticleViewer.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';

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
    Size size= MediaQuery.of(context).size;

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
      drawer: MultiLevelDrawer(
        header: Container(
          height: size.height*0.25,
        ),
        children: [
          MLMenuItem(
              leading: Icon(Icons.language),
              trailing: Icon(Icons.arrow_right),
              content: Text(
                "Language",
              ),
              subMenuItems: [
                MLSubmenu(onClick: (){}, submenuContent: Text("Arabic")),
                MLSubmenu(onClick: (){}, submenuContent: Text("German")),
                MLSubmenu(onClick: (){}, submenuContent: Text("English")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Spanish")),
                MLSubmenu(onClick: (){}, submenuContent: Text("French")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Hebrew")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Italian")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Dutch")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Norwegian")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Portuguese")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Russian")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Swedish")),
                MLSubmenu(onClick: (){}, submenuContent: Text("Chinese")),
              ],
              onClick: () {}
              ),
          MLMenuItem(
            leading: Icon(Icons.language),
            trailing: Icon(Icons.arrow_right),
            content: Text("Country"),
            subMenuItems: [
              MLSubmenu(onClick: (){}, submenuContent: Text("Argentina")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Australia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Austria")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Belgium")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Brazil")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Bulgaria")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Canada")),
              MLSubmenu(onClick: (){}, submenuContent: Text("China")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Colombia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Czech Republic")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Egypt")),
              MLSubmenu(onClick: (){}, submenuContent: Text("France")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Germany")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Greece")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Hong Kong")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Hungary")),
              MLSubmenu(onClick: (){}, submenuContent: Text("India")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Indonesia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Ireland")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Israel")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Italy")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Japan")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Latvia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Lithuania")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Malaysia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Mexico")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Morocco")),
              MLSubmenu(onClick: (){}, submenuContent: Text("the Netherlands")),
              MLSubmenu(onClick: (){}, submenuContent: Text("New Zealand")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Nigeria")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Norway")),
              MLSubmenu(onClick: (){}, submenuContent: Text("the Philippines")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Poland")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Portugal")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Romania")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Saudi Arabia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Serbia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Singapore")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Slovakia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Slovenia")),
              MLSubmenu(onClick: (){}, submenuContent: Text("South Africa")),
              MLSubmenu(onClick: (){}, submenuContent: Text("South Korea")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Sweden")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Switzerland")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Taiwan")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Thailand")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Turkey")),
              MLSubmenu(onClick: (){}, submenuContent: Text("United Arab Emirates")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Ukraine")),
              MLSubmenu(onClick: (){}, submenuContent: Text("United Kingdom")),
              MLSubmenu(onClick: (){}, submenuContent: Text("United States")),
              MLSubmenu(onClick: (){}, submenuContent: Text("Venezuela")),
            ],
            onClick: (){},
          ),
          MLMenuItem(onClick: changeMode, content: Text("Change Views")),
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
