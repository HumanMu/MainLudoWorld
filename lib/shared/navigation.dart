import 'package:flutter/material.dart';

void navigateToAnotherScreen(context, newPage) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => newPage));
}

void navigateAndReplaceScreen(context, newPage) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => newPage));
}

Future<void> replaceCurrentWidget(
    BuildContext context, VoidCallback onSuccess) async {
  await Future.delayed(const Duration(seconds: 2));
  onSuccess.call();
}
