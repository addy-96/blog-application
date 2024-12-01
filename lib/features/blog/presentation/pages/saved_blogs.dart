import 'dart:math';

import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/core/utils/show_snacbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/display_saved_blogs_bloc/display_saved_blogs_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavedBlogs extends StatefulWidget {
  const SavedBlogs({super.key});

  @override
  State<SavedBlogs> createState() => _SavedBlogsState();
}

class _SavedBlogsState extends State<SavedBlogs> {
  @override
  void initState() {
    super.initState();
    context.read<DisplaySavedBlogsBloc>().add(DisplaySavedBlogsRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallets.dark,
      appBar: AppBar(
        foregroundColor: ColorPallets.light,
        backgroundColor: ColorPallets.dark,
        title: Text(
          'Saved',
          style: TextLook().normalText(32, ColorPallets.light),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: BlocConsumer<DisplaySavedBlogsBloc, DisplaySavedBlogsState>(
          listener: (context, state) {
            if (state is DispalySavedBlogsFailureState) {
              return showSnackbar(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            if (state is DisplaySavedBlogsLoadingState) {
              return Loader(
                  color: ColorPallets.postColor[
                      Random().nextInt(ColorPallets.postColor.length - 1)]);
            }
            if (state is DisplaySavedBlogsSuccessState) {
              if (state.blogList.isEmpty) {
                return Center(
                  child: Text(
                    'Oops No Saved blogs , Try Saving Some..',
                    style: TextLook()
                        .normalText(
                          12,
                          ColorPallets.light.withOpacity(0.4),
                        )
                        .copyWith(
                            fontWeight: FontWeight.w100, letterSpacing: 2),
                  ),
                );
              }

              return ListView.builder(
                itemCount: state.blogList.length,
                itemBuilder: (context, index) {
                  final blog = state.blogList[index];
                  final wordCount = state.blogList[index].blogContent
                      .split(RegExp(r'\s+'))
                      .length;
                  return InkWell(
                    radius: 10,
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlogDetails(blog: blog),
                      ));
                    },
                    child: BlogContainer(
                        selectedTopics: blog.blogTopics,
                        blogTitle: blog.blogTitle,
                        date: blog.updatedAt,
                        blogContentWordCount: wordCount,
                        userId: blog.uploaderId,
                        blogId: blog.blogId),
                  );
                },
              );
            }
            return const Center(
              child: Text('Some Error Occured'),
            );
          },
        ),
      ),
    );
  }
}
