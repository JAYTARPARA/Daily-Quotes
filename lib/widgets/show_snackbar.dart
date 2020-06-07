import 'package:flutter/material.dart';

class ShowSnackbar {
  showSnackBar(
    msg,
    color,
    duration,
    scaffoldKey,
  ) {
    scaffoldKey.currentState.showSnackBar(
      new SnackBar(
        content: new Text(
          msg,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        duration: new Duration(seconds: duration),
        behavior: SnackBarBehavior.fixed,
        // elevation: 3.0,
        backgroundColor: color,
      ),
    );
  }
}
