import 'package:dailyquotes/common/common.dart';
import 'package:dailyquotes/widgets/quote_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_color/random_color.dart';

class AuthorQuotes extends StatefulWidget {
  final String author;
  AuthorQuotes(this.author);

  @override
  _AuthorQuotesState createState() => _AuthorQuotesState();
}

class _AuthorQuotesState extends State<AuthorQuotes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final listController = PageController();
  var quotesByAuthorList = [];
  bool loadingQuotesByAuthor = true;
  int lastItemIndex;
  int totalCount;

  @override
  void initState() {
    super.initState();
    getQuotesByAuthor();
  }

  Future getQuotesByAuthor() async {
    var quotesByAuthor = await Common().getQuotesByAuthor(
      widget.author,
      0,
    );
    // print(quotesByCategory);
    for (var i = 0; i < quotesByAuthor["count"]; i++) {
      quotesByAuthorList.add(quotesByAuthor["results"][i]);
    }
    setState(() {
      loadingQuotesByAuthor = false;
      lastItemIndex = quotesByAuthor['lastItemIndex'];
      totalCount = quotesByAuthor['totalCount'];
    });
    // return quotesByAuthorList;
  }

  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: loadingQuotesByAuthor
          ? Container(
              color: Colors.black54,
              child: Center(
                child: SpinKitPulse(
                  color: Colors.white,
                  size: 50.0,
                ),
              ),
            )
          : PageView.builder(
              controller: listController,
              physics: ScrollPhysics(),
              itemCount: quotesByAuthorList.length,
              scrollDirection: Axis.vertical,
              onPageChanged: (page) async {
                print(page);
                if (lastItemIndex != null) {
                  if (page == (lastItemIndex - 3) &&
                      totalCount > Common().quotesLimit) {
                    var quotesByCategory = await Common().getQuotesByAuthor(
                      widget.author,
                      lastItemIndex,
                    );
                    // print(quotesByCategory);
                    for (var i = 0; i < quotesByCategory["count"]; i++) {
                      quotesByAuthorList.add(quotesByCategory["results"][i]);
                    }
                    setState(() {
                      lastItemIndex = quotesByCategory["lastItemIndex"];
                    });
                  }
                }
              },
              itemBuilder: (context, index) {
                var model = quotesByAuthorList[index];
                return QuoteWidget(
                  scaffoldKey: _scaffoldKey,
                  currentIndex: index,
                  quote: model["content"].toString(),
                  author: model["author"] == null
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
            ),
    );
  }
}
