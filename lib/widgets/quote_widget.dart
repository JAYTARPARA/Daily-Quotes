import 'dart:async';
import 'dart:io';

import 'package:dailyquotes/common/common.dart';
import 'package:dailyquotes/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:random_string/random_string.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_it/share_it.dart';

class QuoteWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final currentIndex;
  var quote = "";
  var author = "";
  var onShareClick;
  var onSaveClick;
  var bgColor;

  QuoteWidget({
    this.scaffoldKey,
    this.currentIndex,
    this.bgColor,
    this.quote,
    this.author,
    this.onShareClick,
    this.onSaveClick,
  });

  @override
  _QuoteWidgetState createState() => _QuoteWidgetState();
}

class _QuoteWidgetState extends State<QuoteWidget> {
  ScreenshotController ssc = ScreenshotController();
  bool downloadStart = false;

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
    } else if (status == PermissionStatus.denied) {
      Permission.storage.request();
    } else if (status == PermissionStatus.granted) {
      createFolder();
    }
  }

  createFolder() async {
    final Directory _appDocDirFolder = Directory(
      Common().folderName,
    );

    if (await _appDocDirFolder.exists()) {
      //if folder already exists return path
      // print(_appDocDirFolder.path);
    } else {
      //if folder not exists create folder and then return its path
      final Directory _appDocDirNewFolder =
          await _appDocDirFolder.create(recursive: true);
      // print(_appDocDirNewFolder.path);
    }
  }

  downLoadQuotes(task) async {
    await checkPermission();
    ShowSnackbar().showSnackBar(
      "Downloading... Please wait...",
      Colors.black87,
      2,
      widget.scaffoldKey,
    );
    var quoteName = randomAlpha(8);
    setState(() {
      downloadStart = true;
    });
    Timer(new Duration(seconds: 2), () async {
      var quotePathName = Common().folderName;
      var quoteFileName = "DailyQuotes-$quoteName.png";
      ssc
          .capture(
        path: quotePathName + quoteFileName,
        pixelRatio: 1.5,
        delay: Duration(milliseconds: 10),
      )
          .then((File image) async {
        setState(() {
          downloadStart = false;
        });
        if (task == "share") {
          ShareIt.file(
            path: quotePathName + quoteFileName,
            type: ShareItFileType.image,
          );
        } else {
          ShowSnackbar().showSnackBar(
            "Done... Please check in the gallery",
            Colors.green,
            2,
            widget.scaffoldKey,
          );
        }
      }).catchError((onError) {
        setState(() {
          downloadStart = false;
        });
        print(onError);
        ShowSnackbar().showSnackBar(
          "Something went wrong! Please try again later.",
          Colors.green,
          2,
          widget.scaffoldKey,
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Screenshot(
      controller: ssc,
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: widget.bgColor,
        padding: EdgeInsets.only(
          left: 30.0,
          right: 30.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(
              flex: 2,
            ),
            Image.asset(
              "assets/images/quote.png",
              height: 30.0,
              width: 30.0,
              color: Colors.white,
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              widget.quote,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              widget.author,
              style: GoogleFonts.lato(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Visibility(
              // visible: downloadStart ? false : true,
              visible: true,
              child: Container(
                alignment: Alignment.center,
                child: Visibility(
                  visible: downloadStart ? false : true,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () async {
                          await checkPermission();
                          downLoadQuotes("download");
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.save_alt,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await downLoadQuotes("share");
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 10.0,
                          ),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: Colors.white,
                            ),
                          ),
                          padding: EdgeInsets.all(
                            10.0,
                          ),
                          child: Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
