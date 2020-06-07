import 'dart:convert';

import 'package:dailyquotes/pages/saved_page.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:dailyquotes/widgets/quote_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:random_color/random_color.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final listController = PageController();
  var apiURL = "https://type.fit/api/quotes";

  @override
  void dispose() {
    super.dispose();
    listController.dispose();
  }

  Future<List<dynamic>> getPost() async {
    final response = await http.get('$apiURL');
    return postFromJson(response.body);
  }

  List<dynamic> postFromJson(String str) {
    List<dynamic> jsonData = json.decode(str);
    jsonData.shuffle();
    return jsonData;
  }

  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: _randomColor.randomColor(
          colorBrightness: ColorBrightness.dark,
          colorHue: ColorHue.multiple(
            colorHues: [ColorHue.orange, ColorHue.blue],
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            new MaterialPageRoute(
              builder: (context) => SavedPage(),
            ),
          );
        },
        child: Center(
          child: Icon(
            Icons.save,
            size: 30.0,
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: DoubleBack(
        message: "Press again to exit",
        child: FutureBuilder<List<dynamic>>(
          future: getPost(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return ErrorWidget(snapshot.error);
              }
              return PageView.builder(
                controller: listController,
                physics: ScrollPhysics(),
                itemCount: snapshot.data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  var model = snapshot.data[index];
                  return QuoteWidget(
                    scaffoldKey: _scaffoldKey,
                    currentIndex: index,
                    listController: listController,
                    quote: model["text"].toString(),
                    author: model["author"].toString() == null
                        ? 'By Unknwon'
                        : "By " + model["author"].toString(),
                    bgColor: _randomColor.randomColor(
                      colorBrightness: ColorBrightness.dark,
                      colorHue: ColorHue.multiple(
                        colorHues: [ColorHue.orange, ColorHue.blue],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container(
                color: Colors.black54,
                child: Center(
                  child: SpinKitPulse(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
