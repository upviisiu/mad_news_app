import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Register',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Register'),
          ),
        body: ListView(
            children:[
              username,
              password,
              button,
            ]
        ),
      ),
    ),
  );
}

Widget username = TextField (

);

Widget password = TextField (

);

Widget button = ElevatedButton(
    onPressed: null,
    child: const Text('Register'),
);