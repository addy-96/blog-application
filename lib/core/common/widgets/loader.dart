import 'package:blog_app/core/text_look.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class Loader extends StatelessWidget {
  const Loader({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: color,
          ),
          const Gap(10),
          Text(
            'Loading .....',
            style: TextLook().normalText(15, color),
          ),
        ],
      ),
    );
  }
}
