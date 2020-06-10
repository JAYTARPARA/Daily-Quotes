import 'package:dailyquotes/common/common.dart';
import 'package:dailyquotes/pages/category_quotes.dart';
import 'package:dailyquotes/sidebar/sidebar.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loadingCategories = true;
  var listCategories;
  String quoteImage = "assets/images/quote.png";

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  Future getCategories() async {
    var categories = await Common().getCategories();
    // print(categories);
    if (categories != null) {
      setState(() {
        loadingCategories = false;
        listCategories = categories;
      });
      for (var i = 0; i < listCategories.length; i++) {
        if (listCategories[i]["name"] == "business") {
          listCategories[i]["quoteImage"] = "assets/images/business.jpg";
        } else if (listCategories[i]["name"] == "education") {
          listCategories[i]["quoteImage"] = "assets/images/education.jpg";
        } else if (listCategories[i]["name"] == "faith") {
          listCategories[i]["quoteImage"] = "assets/images/faith.jpg";
        } else if (listCategories[i]["name"] == "famous-quotes") {
          listCategories[i]["quoteImage"] = "assets/images/famous.jpg";
        } else if (listCategories[i]["name"] == "friendship") {
          listCategories[i]["quoteImage"] = "assets/images/friendship.jpg";
        } else if (listCategories[i]["name"] == "future") {
          listCategories[i]["quoteImage"] = "assets/images/future.jpg";
        } else if (listCategories[i]["name"] == "happiness") {
          listCategories[i]["quoteImage"] = "assets/images/happiness.jpg";
        } else if (listCategories[i]["name"] == "history") {
          listCategories[i]["quoteImage"] = "assets/images/history.jpg";
        } else if (listCategories[i]["name"] == "inspirational") {
          listCategories[i]["quoteImage"] = "assets/images/inspirational.jpg";
        } else if (listCategories[i]["name"] == "life") {
          listCategories[i]["quoteImage"] = "assets/images/life.jpg";
        } else if (listCategories[i]["name"] == "love") {
          listCategories[i]["quoteImage"] = "assets/images/love.jpg";
        } else if (listCategories[i]["name"] == "nature") {
          listCategories[i]["quoteImage"] = "assets/images/nature.jpg";
        } else if (listCategories[i]["name"] == "politics") {
          listCategories[i]["quoteImage"] = "assets/images/politics.jpg";
        } else if (listCategories[i]["name"] == "proverb") {
          listCategories[i]["quoteImage"] = "assets/images/proverb.jpg";
        } else if (listCategories[i]["name"] == "religion") {
          listCategories[i]["quoteImage"] = "assets/images/religion.jpg";
        } else if (listCategories[i]["name"] == "science") {
          listCategories[i]["quoteImage"] = "assets/images/science.jpg";
        } else if (listCategories[i]["name"] == "success") {
          listCategories[i]["quoteImage"] = "assets/images/success.jpg";
        } else if (listCategories[i]["name"] == "technology") {
          listCategories[i]["quoteImage"] = "assets/images/technology.jpg";
        } else if (listCategories[i]["name"] == "wisdom") {
          listCategories[i]["quoteImage"] = "assets/images/wisdom.jpg";
        } else {
          listCategories[i]["quoteImage"] = quoteImage;
        }
      }
      // print(listCategories);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Sidebar("category"),
      appBar: AppBar(
        title: Text(
          "Quotes By Category",
          style: GoogleFonts.lato(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: DoubleBack(
        message: "Press again to exit",
        child: loadingCategories
            ? Container(
                color: Colors.black54,
                child: Center(
                  child: SpinKitPulse(
                    color: Colors.white,
                    size: 50.0,
                  ),
                ),
              )
            : ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 10.0,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: listCategories.length,
                      itemBuilder: (context, index) {
                        var category = listCategories[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => CategoryQuotes(
                                  category["name"].toString(),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 10.0,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Colors.white,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(
                                5.0,
                              ),
                            ),
                            margin: EdgeInsets.symmetric(
                              horizontal: 10.0,
                              vertical: 6.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black87,
                                borderRadius: BorderRadius.circular(
                                  5.0,
                                ),
                              ),
                              child: ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20.0,
                                  vertical: 10.0,
                                ),
                                leading: Container(
                                  padding: EdgeInsets.only(
                                    right: 12.0,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        width: 1.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  child: SizedBox(
                                    height: 50.0,
                                    width: 50.0,
                                    child: Center(
                                      child: CircleAvatar(
                                        backgroundImage: AssetImage(
                                          category["quoteImage"].toString(),
                                        ),
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ),
                                      // Image.asset(
                                      //   "assets/images/quote.png",
                                      //   height: 30.0,
                                      //   width: 30.0,
                                      //   color: Colors.white,
                                      // ),
                                    ),
                                  ),
                                ),
                                title: Text(
                                  category["name"].toString().toUpperCase(),
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Row(
                                  children: <Widget>[
                                    // Icon(
                                    //   Icons.comment,
                                    //   color: Colors.white,
                                    //   size: 18.0,
                                    // ),
                                    Image.asset(
                                      "assets/images/quote.png",
                                      height: 10.0,
                                      width: 10.0,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 5.0,
                                    ),
                                    Text(
                                      category["quoteCount"].toString() +
                                          " Quotes available",
                                      style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                trailing: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      new MaterialPageRoute(
                                        builder: (context) => CategoryQuotes(
                                          category["name"].toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
