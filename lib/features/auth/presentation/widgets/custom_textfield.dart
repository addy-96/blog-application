import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  const CustomTextfield({
    super.key,
    required this.hintText,
    required this.themeColor,
    required this.textController,
  });

  final TextEditingController textController;
  final String hintText;
  final Color themeColor;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hintText == 'Password' ? true : false,
      style: TextLook().normalText(
        22,
        ColorPallets.light,
      ),
      controller: textController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(27),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            width: 4,
            color: ColorPallets.light,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            width: 3,
            color: themeColor,
          ),
        ),
        hintText: hintText,
        hintStyle: TextLook().normalText(
          18,
          ColorPallets.light,
        ),
      ),
      validator: (value) {
        if (hintText == 'Username') {
          if (value == null || value.trim().isEmpty || value.length < 8) {
            return 'Username must be 8 characters';
          }
        }
        if (hintText == 'Email') {
          if (value == null || value.trim().isEmpty || !value.contains('@')) {
            return 'Invalid Email !';
          }
        }
        if (hintText == 'Password') {
          if (value == null || value.trim().isEmpty || value.length < 6) {
            return 'Password must be atleast 6 characters';
          }
        }
        return null;
      },
    );
  }
}
