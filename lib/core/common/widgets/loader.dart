import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
