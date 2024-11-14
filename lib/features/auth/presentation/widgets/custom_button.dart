import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.themeColor,
    required this.buttonText,
    required this.onPressed,
  });

  final Color themeColor;
  final String buttonText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeColor,
        ),
        child: Center(
          child: Text(
            buttonText,
            style: TextLook().normalText(
              22,
              ColorPallets.dark,
            ),
          ),
        ),
      ),
    );
  }
}
