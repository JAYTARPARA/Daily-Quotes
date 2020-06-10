import 'package:dailyquotes/common/common.dart';
import 'package:dailyquotes/widgets/quote_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:random_color/random_color.dart';

class CategoryQuotes extends StatefulWidget {
  final String category;
  CategoryQuotes(this.category);

  @override
  _CategoryQuotesState createState() => _CategoryQuotesState();
}

class _CategoryQuotesState extends State<CategoryQuotes> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final listController = PageController();
  var quotesByCategoryList = [];
  bool loadingQuotesByCategory = true;
  int lastItemIndex;
  int totalCount;

  @override
  void initState() {
    super.initState();
    getQuotesByCategory();
  }

  Future getQuotesByCategory() async {
    var quotesByCategory = await Common().getQuotesByCategory(
      widget.category,
      0,
    );
    // print(quotesByCategory);
    for (var i = 0; i < quotesByCategory["count"]; i++) {
      quotesByCategoryList.add(quotesByCategory["results"][i]);
    }
    setState(() {
      loadingQuotesByCategory = false;
      lastItemIndex = quotesByCategory['lastItemIndex'];
      totalCount = quotesByCategory['totalCount'];
    });
    // return quotesByCategoryList;
  }

  RandomColor _randomColor = RandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: loadingQuotesByCategory
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
              itemCount: quotesByCategoryList.length,
              scrollDirection: Axis.vertical,
              onPageChanged: (page) async {
                print(page);
                if (lastItemIndex != null) {
                  if (page == (lastItemIndex - 3) &&
                      totalCount > Common().quotesLimit) {
                    var quotesByCategory = await Common().getQuotesByCategory(
                      widget.category,
                      lastItemIndex,
                    );
                    // print(quotesByCategory);
                    for (var i = 0; i < quotesByCategory["count"]; i++) {
                      quotesByCategoryList.add(quotesByCategory["results"][i]);
                    }
                    setState(() {
                      lastItemIndex = quotesByCategory["lastItemIndex"];
                    });
                  }
                }
              },
              itemBuilder: (context, index) {
                var model = quotesByCategoryList[index];
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
