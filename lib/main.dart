import 'package:flutter/material.dart';
import 'package:world_time/pages/choose_location.dart';
import 'pages/homepage.dart';
import 'pages/loading.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/loading',
      routes: {
        '/home': (context) => const HomePage(),
        '/loading': (context) => const Loading(),
        '/location': (context) => const Location()
      },
    );
  }
}

