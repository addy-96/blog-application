import 'dart:math';

import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/core/utils/calculate_blog_reading_time.dart';
import 'package:blog_app/features/blog/presentation/bloc/get_username_bloc/bloc/get_username_bloc.dart';
import 'package:blog_app/features/blog/presentation/widgets/save_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class BlogContainer extends StatefulWidget {
  const BlogContainer({
    super.key,
    required this.selectedTopics,
    required this.blogTitle,
    required this.date,
    required this.blogContentWordCount,
    required this.userId,
    required this.blogId,
  });

  final List<String> selectedTopics;
  final String blogTitle;
  final DateTime date;
  final int blogContentWordCount;
  final String userId;
  final String blogId;

  @override
  State<BlogContainer> createState() => _BlogContainerState();
}

class _BlogContainerState extends State<BlogContainer> {
  @override
  void initState() {
    super.initState();
    context
        .read<GetUsernameBloc>()
        .add(UsernameRequested(userID: widget.userId));
  }

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
                  BlocBuilder<GetUsernameBloc, GetUsernameState>(
                    builder: (context, state) {
                      if (state is GetUsernameSuccess) {
                        return SizedBox(
                          height: 30,
                          child: FutureBuilder(
                            future: state.username,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.blueGrey.withOpacity(0.5),
                                    ));
                              }
                              if (snapshot.hasData) {
                                return Text(
                                  snapshot.data ?? 'User',
                                  style: TextLook()
                                      .normalText(18, ColorPallets.dark)
                                      .copyWith(fontWeight: FontWeight.bold),
                                );
                              }
                              return Container();
                            },
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                  const Gap(30),
                  SaveButton(blogId: widget.blogId),
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
