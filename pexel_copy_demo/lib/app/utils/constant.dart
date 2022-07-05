import 'package:flutter/material.dart';

/// Shows a generic [Snackbar]
void showGenericSnackbar(
  GlobalKey<State<StatefulWidget>> key,
  String text, {
  bool isError = false,
}) {
  // key.currentState?.showSnackBar(_getGenericSnackbar(text, isError));
  ScaffoldMessenger.of(key.currentContext!).showSnackBar(_getGenericSnackbar(text, isError));
}

/// Returns the app's default snackbar with a [text].
SnackBar _getGenericSnackbar(String text, bool isError) {
  return SnackBar(
    content: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: isError ? Colors.red : Colors.white,
        fontSize: 16.0,
      ),
    ),
  );
}

class Resources {
  static const String background = 'assets/img/background.jpg';
  static const String logo = 'assets/img/logo.png';
  static const String loader = 'assets/img/loading.svg';
}

class Space {
  static const SizedBox horizontalSmall = SizedBox(height: 20.0);
  static const SizedBox horizontalMedium = SizedBox(height: 40.0);
}
