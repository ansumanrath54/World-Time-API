import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'pages/homepage.dart';
import 'pages/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //home: HomePage(),
      initialRoute: '/loading',
      routes: {
        '/home': (context) => HomePage(),
        '/loading': (context) => Loading(),
        '/location': (context) => Location()
      },
    );
  }
}

