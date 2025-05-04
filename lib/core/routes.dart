import 'package:flutter/material.dart';

class MaterialNavigate {
  void pushPage(BuildContext context, Widget widget) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
  }
}
