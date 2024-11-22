import 'dart:math';
import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/core/utils/calculate_blog_reading_time.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BlogContainer extends StatelessWidget {
  const BlogContainer(
      {super.key,
      required this.selectedTopics,
      required this.blogTitle,
      required this.date,
      required this.blogContentWordCount});

  final List<String> selectedTopics;
  final String blogTitle;
  final DateTime date;
  final int blogContentWordCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: ColorPallets
              .postColor[Random().nextInt(ColorPallets.postColor.length - 1)],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User11111',
                    style: TextLook()
                        .normalText(18, ColorPallets.dark)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 30),
                  Material(
                    elevation: 5,
                    borderRadius: BorderRadius.circular(50),
                    color: ColorPallets.dark,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.bookmark_outline,
                        color: ColorPallets.light,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Material(
                          color: Colors.transparent,
                          elevation: 5,
                          shadowColor: Colors.transparent,
                          child: Row(
                            children: [
                              for (var item in selectedTopics)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Material(
                                    elevation: 5,
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      child: Text(
                                        item,
                                        style: TextLook().normalText(
                                          15,
                                          ColorPallets.light,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                blogTitle,
                textAlign: TextAlign.start,
                style: TextLook()
                    .normalText(15, ColorPallets.dark)
                    .copyWith(fontWeight: FontWeight.w500, height: 2),
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${calculateBlogReadingTime(blogContentWordCount).toString()} min',
                    style: TextLook()
                        .normalText(15, ColorPallets.dark)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${date.day} / ${date.month} / ${date.year}',
                    style: TextLook()
                        .normalText(15, ColorPallets.dark)
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
