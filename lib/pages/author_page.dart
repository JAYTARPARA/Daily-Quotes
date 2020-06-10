import 'package:dailyquotes/common/common.dart';
import 'package:dailyquotes/pages/author_quotes.dart';
import 'package:dailyquotes/sidebar/sidebar.dart';
import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthorPage extends StatefulWidget {
  @override
  _AuthorPageState createState() => _AuthorPageState();
}

class _AuthorPageState extends State<AuthorPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool loadingAuthors = true;
  var listAuthors;
  String quoteImage = "assets/images/quote.png";

  @override
  void initState() {
    super.initState();
    getAuthors();
  }

  Future getAuthors() async {
    var authors = await Common().getAuthors();
    // print(categories);
    if (authors != null) {
      setState(() {
        loadingAuthors = false;
        listAuthors = authors;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Sidebar("author"),
      appBar: AppBar(
        title: Text(
          "Quotes By Author",
          style: GoogleFonts.lato(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: DoubleBack(
        message: "Press again to exit",
        child: loadingAuthors
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
                    padding: const EdgeInsets.fromLTRB(
                      18.0,
                      10.0,
                      18.0,
                      0.0,
                    ),
                    child: Text(
                      "Click on the card to view quotes",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5.0,
                      vertical: 10.0,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: listAuthors["results"].length,
                      itemBuilder: (context, index) {
                        var author = listAuthors["results"][index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              new MaterialPageRoute(
                                builder: (context) => AuthorQuotes(
                                  author["name"].toString(),
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
                                // leading: Container(
                                //   padding: EdgeInsets.only(
                                //     right: 12.0,
                                //   ),
                                //   decoration: BoxDecoration(
                                //     border: Border(
                                //       right: BorderSide(
                                //         width: 1.0,
                                //         color: Colors.white,
                                //       ),
                                //     ),
                                //   ),
                                //   child: SizedBox(
                                //     height: 50.0,
                                //     width: 50.0,
                                //     child: Center(
                                //       child: CircleAvatar(
                                //         backgroundImage: AssetImage(
                                //           "assets/images/author.jpg",
                                //         ),
                                //         backgroundColor:
                                //             Theme.of(context).primaryColor,
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                title: Text(
                                  author["name"].toString(),
                                  style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Wrap(
                                        children: <Widget>[
                                          Text(
                                            author["bio"],
                                            style: GoogleFonts.lato(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
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
                                          author["quoteCount"].toString() +
                                              " Quotes available",
                                          style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                // trailing: GestureDetector(
                                //   onTap: () {
                                //     Navigator.push(
                                //       context,
                                //       new MaterialPageRoute(
                                //         builder: (context) => CategoryQuotes(
                                //           category["name"].toString(),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                //   child: Icon(
                                //     Icons.arrow_forward,
                                //     color: Colors.white,
                                //     size: 20.0,
                                //   ),
                                // ),
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
