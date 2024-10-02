import 'package:flutter/material.dart';

class Utils {
  static snackBarMessage(BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Enter required fields'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
