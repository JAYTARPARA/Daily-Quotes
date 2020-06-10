import 'package:dailyquotes/pages/category_page.dart';
import 'package:dailyquotes/pages/home_page.dart';
import 'package:dailyquotes/pages/saved_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Sidebar extends StatefulWidget {
  final String page;
  Sidebar(this.page);

  @override
  _SidebarState createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  String page;

  @override
  void initState() {
    super.initState();
    if (widget.page != null) {
      setState(() {
        page = widget.page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            height: 200.0,
            decoration: BoxDecoration(
              color: Colors.black87,
            ),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    10.0,
                    40.0,
                    0.0,
                    0.0,
                  ),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      "assets/images/quote.png",
                      height: 50.0,
                      width: 50.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                            ),
                          ),
                          children: [
                            TextSpan(
                              text: "Daily\n",
                            ),
                            TextSpan(
                              text: "Quotes",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListView(
            shrinkWrap: true,
            children: <Widget>[
              ListTile(
                onTap: () {
                  if (page != "saved") {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/saved_quotes',
                      (r) => false,
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                leading: Icon(
                  Icons.save,
                ),
                title: Text(
                  "Saved Quotes",
                  style: GoogleFonts.lato(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                trailing: Visibility(
                  visible: page == "saved" ? true : false,
                  child: Icon(
                    Icons.check_circle_outline,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  if (page != "category") {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/categories',
                      (r) => false,
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                leading: Icon(
                  Icons.category,
                ),
                title: Text(
                  "Quotes By Category",
                  style: GoogleFonts.lato(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                trailing: Visibility(
                  visible: page == "category" ? true : false,
                  child: Icon(
                    Icons.check_circle_outline,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  if (page != "random") {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/home',
                      (r) => false,
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                leading: Icon(
                  Icons.swap_horiz,
                ),
                title: Text(
                  "Random Quotes",
                  style: GoogleFonts.lato(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                trailing: Visibility(
                  visible: page == "random" ? true : false,
                  child: Icon(
                    Icons.check_circle_outline,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
              ListTile(
                onTap: () {
                  if (page != "author") {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/authors',
                      (r) => false,
                    );
                  } else {
                    Navigator.pop(context);
                  }
                },
                leading: Icon(
                  Icons.perm_identity,
                ),
                title: Text(
                  "Quotes By Author",
                  style: GoogleFonts.lato(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                trailing: Visibility(
                  visible: page == "author" ? true : false,
                  child: Icon(
                    Icons.check_circle_outline,
                  ),
                ),
              ),
              Divider(
                height: 1,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
