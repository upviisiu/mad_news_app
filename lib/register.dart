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
              repeatPassword,
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

Widget repeatPassword = TextField (

);

Widget button = ElevatedButton(
    onPressed: null,
    child: const Text('Register'),
);