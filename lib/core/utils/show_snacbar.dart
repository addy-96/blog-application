import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
        ),
      ),
    );
}
