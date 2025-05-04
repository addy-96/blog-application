import 'dart:math';

import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/core/utils/calculate_blog_reading_time.dart';
import 'package:blog_app/features/blog/presentation/widgets/delete_button.dart';
import 'package:blog_app/features/blog/presentation/widgets/save_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BlogContainer extends StatefulWidget {
  const BlogContainer({
    super.key,
    required this.selectedTopics,
    required this.blogTitle,
    this.date,
    required this.blogContentWordCount,
    required this.userId,
    required this.blogId,
  });

  final List<String> selectedTopics;
  final String blogTitle;
  final DateTime? date;
  final int blogContentWordCount;
  final String userId;
  final String blogId;

  @override
  State<BlogContainer> createState() => _BlogContainerState();
}

class _BlogContainerState extends State<BlogContainer> {
  Future<String> getUsername(String userID) async {
    // this function should not be here this is a temporary solution for privious inconsistent username error , iwill try solvin it later using get username bloc.
    final ref = FirebaseFirestore.instance.collection('users').doc(userID);
    final response = await ref.get();
    final username = response.data()!['username'];
    return username;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 10,
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
                  FutureBuilder(
                    future: getUsername(widget.userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Loader(color: Colors.white);
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            style: TextLook()
                                .normalText(
                                  22,
                                  ColorPallets.dark,
                                )
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                          );
                        }
                        if (!snapshot.hasData) {
                          return const Text('Error!');
                        }
                      }
                      return const Text('error..');
                    },
                  ),
                  const Gap(30),
                  Row(
                    children: [
                      FirebaseAuth.instance.currentUser!.uid == widget.userId
                          ? DeleteButton(blogID: widget.blogId)
                          : Container(),
                      Gap(10),
                      SaveButton(blogId: widget.blogId),
                    ],
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
                              for (var item in widget.selectedTopics)
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
                widget.blogTitle,
                textAlign: TextAlign.start,
                style: TextLook()
                    .normalText(15, ColorPallets.dark)
                    .copyWith(fontWeight: FontWeight.bold, height: 2),
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${calculateBlogReadingTime(widget.blogContentWordCount).toString()} min',
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
