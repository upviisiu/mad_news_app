import 'package:flutter/material.dart';
import 'package:mad_news_app/Login/Login.dart';
import 'package:mad_news_app/Login/Register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Welcome to MAD NEWS!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => SignInPage())
                );
              },
                child: Text('Sign in'),
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => RegistrationPage())
                  );
                },
                child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
