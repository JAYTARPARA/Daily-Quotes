import 'dart:io';

import 'package:dailyquotes/widgets/show_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share_it/share_it.dart';

class QuoteView extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final String imgPath;
  QuoteView(
    this.imgPath,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowSnackbar().showSnackBar(
            "Sharing...",
            Colors.black87,
            2,
            _scaffoldKey,
          );
          ShareIt.file(
            path: this.imgPath,
            type: ShareItFileType.image,
          );
        },
        child: Icon(
          Icons.share,
        ),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            PhotoView.customChild(
              child: Image.file(
                File(this.imgPath),
                fit: BoxFit.cover,
              ),
              minScale: PhotoViewComputedScale.covered * 1.0,
              initialScale: PhotoViewComputedScale.covered * 1.1,
              maxScale: PhotoViewComputedScale.covered * 1.0,
            ),
          ],
        ),
      ),
    );
  }
}
