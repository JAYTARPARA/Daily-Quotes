import 'package:dailyquotes/pages/author_page.dart';
import 'package:dailyquotes/pages/category_page.dart';
import 'package:dailyquotes/pages/home_page.dart';
import 'package:dailyquotes/pages/login_page.dart';
import 'package:dailyquotes/pages/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'pages/intro_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => WaterDropMaterialHeader(),
      headerTriggerDistance: 80.0,
      springDescription: SpringDescription(
        stiffness: 170,
        damping: 16,
        mass: 1.9,
      ),
      maxOverScrollExtent: 100,
      maxUnderScrollExtent: 0,
      enableLoadingWhenFailed: true,
      hideFooterWhenNotFull: true,
      enableBallisticLoad: true,
      child: MaterialApp(
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
          '/categories': (BuildContext context) => new CategoryPage(),
          '/authors': (BuildContext context) => new AuthorPage(),
        },
      ),
    );
  }
}
