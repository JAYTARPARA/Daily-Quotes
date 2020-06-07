import 'package:dailyquotes/pages/home_page.dart';
import 'package:dailyquotes/pages/login_page.dart';
import 'package:dailyquotes/pages/saved_page.dart';
import 'package:flutter/material.dart';

import 'pages/intro_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quotes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        accentColor: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: IntroPage(),
      routes: <String, WidgetBuilder>{
        '/intro': (BuildContext context) => new IntroPage(),
        '/home': (BuildContext context) => new HomePage(),
        '/login': (BuildContext context) => new LoginPage(),
        '/saved_quotes': (BuildContext context) => new SavedPage(),
      },
    );
  }
}
