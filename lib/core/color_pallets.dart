import 'dart:math';

import 'package:flutter/material.dart';

//Color(0xFF0B192C)
class ColorPallets {
  static const light = Colors.white;
  static const dark = Colors.black;
  static List postColor = const [
    Color(0xFF00FF9C),
    Color(0xFFF3C623),
    Color(0xFF37AFE1),
    Color(0xFF8B5DFF),
    Color(0xFF0D7C66),
    Color(0xFFFF8225),
    Color(0xFF8B5DFF),
    Color(0xFFC3FF93),
    Color(0xFF687EFF),
  ];

  int getRandomIndex() {
    int size = postColor.length;
    final random = Random();
    return 0 + random.nextInt(size);
  }
}
