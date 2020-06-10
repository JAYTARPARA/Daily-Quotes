import 'dart:io';

import 'package:dailyquotes/common/common.dart';
import 'package:firebase_in_app_messaging/firebase_in_app_messaging.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroPage extends StatefulWidget {
  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static FirebaseInAppMessaging fiam = FirebaseInAppMessaging();
  AppUpdateInfo _updateInfo;

  @override
  void initState() {
    super.initState();
    initFCM();
    checkForUpdate();
  }

  Future<void> checkForUpdate() async {
    InAppUpdate.checkForUpdate().then((info) {
      setState(() {
        _updateInfo = info;
      });
      if (_updateInfo.updateAvailable == true) {
        InAppUpdate.performImmediateUpdate().catchError((e) => _showError(e));
      }
    }).catchError((e) => _showError(e));
  }

  void _showError(dynamic exception) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          exception.toString(),
        ),
      ),
    );
  }

  initFCM() async {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.subscribeToTopic("daily_quotes_users");
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: true,
      ),
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) async {
      assert(token != null);
      print("TOKEN: $token");
    });
  }

  checkPermission(context) async {
    var status = await Permission.storage.status;
    if (status.isUndetermined) {
      // We didn't ask for permission yet.
      Permission.storage.request();
    } else if (status == PermissionStatus.denied) {
      Permission.storage.request();
    } else if (status == PermissionStatus.granted) {
      createFolder(context);
    }
  }

  createFolder(context) async {
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
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/categories',
      (r) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = 40.0;
    double width = 40.0;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue[50],
      body: Container(
        margin: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Image.asset(
              "assets/images/quote.png",
              height: height,
              width: width,
            ),
            SizedBox(
              height: 50.0,
            ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize: 50,
                    color: Colors.black,
                  ),
                ),
                children: [
                  TextSpan(
                    text: "Get\n",
                  ),
                  TextSpan(
                    text: "Inspired",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                onPressed: () async {
                  await checkPermission(context);
                },
                color: Colors.black,
                textColor: Colors.white,
                child: Text(
                  "Let's Go",
                  style: TextStyle(
                    fontSize: 18.0,
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
