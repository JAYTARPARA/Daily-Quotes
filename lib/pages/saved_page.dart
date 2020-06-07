import 'dart:io';

import 'package:dailyquotes/common/common.dart';
import 'package:dailyquotes/pages/quote_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';

class SavedPage extends StatefulWidget {
  @override
  _SavedPageState createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // We didn't ask for permission yet.
      Permission.storage.request();
      setState(() {});
    } else if (status == PermissionStatus.denied) {
      Permission.storage.request();
    }
  }

  createFolder() async {
    final Directory _appDocDirFolder = Directory(
      Common().folderName,
    );

    if (await _appDocDirFolder.exists()) {
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    var quoteList = [];
    final Directory _quoteDir = Directory(
      Common().folderName,
    );
    quoteList = _quoteDir
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".png"))
        .toList(growable: false);

    quoteList = quoteList.reversed.toList();

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          "Saved Quotes",
          style: GoogleFonts.lato(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        centerTitle: true,
      ),
      body: quoteList.length == 0
          ? Container(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "You have not downloaded any quote yet.",
                        style: GoogleFonts.lato(
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  8.0,
                  12.0,
                  8.0,
                  8.0,
                ),
                child: StaggeredGridView.countBuilder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: quoteList.length,
                  crossAxisCount: 4,
                  itemBuilder: (context, index) {
                    String quotePath = quoteList[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => QuoteView(
                              quotePath,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: quotePath,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          child: Image.file(
                            File(quotePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  staggeredTileBuilder: (i) =>
                      StaggeredTile.count(2, i.isEven ? 2 : 3),
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              ),
            ),
    );
  }
}
