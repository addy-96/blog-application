import 'dart:math';

import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:flutter/material.dart';

class CategoryContainer extends StatefulWidget {
  const CategoryContainer({
    super.key,
    required this.title,
    required this.selectedTopics,
  });

  final String title;
  final List selectedTopics;

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        enableFeedback: true,
        splashColor: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          if (widget.selectedTopics.contains(widget.title)) {
            widget.selectedTopics.remove(widget.title);
          } else {
            widget.selectedTopics.add(widget.title);
          }
          print(widget.selectedTopics);
          setState(() {});
        },
        child: Container(
          decoration: BoxDecoration(
            color: widget.selectedTopics.contains(widget.title)
                ? ColorPallets.postColor[Random().nextInt(
                    ColorPallets.postColor.length - 1,
                  )]
                : Colors.transparent,
            border: widget.selectedTopics.contains(widget.title)
                ? null
                : Border.all(
                    color: Colors.grey,
                    width: 2,
                  ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 2,
            ),
            child: Center(
              child: Text(
                widget.title,
                style: TextLook().normalText(
                  22,
                  widget.selectedTopics.contains(widget.title)
                      ? ColorPallets.dark
                      : ColorPallets.light,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
