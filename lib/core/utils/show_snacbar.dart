import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:flutter/material.dart';

void showSnackbar(BuildContext context, String content) {
  ScaffoldMessenger.of(context)
    ..clearSnackBars()
    ..showSnackBar(
      SnackBar(
        backgroundColor: ColorPallets.light,
        content: Text(
          content,
          style: TextLook().normalText(
            18,
            ColorPallets.dark,
          ),
        ),
      ),
    );
}
