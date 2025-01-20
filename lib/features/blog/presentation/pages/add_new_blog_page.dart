import 'dart:io';
import 'dart:math';

import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/common/cubits/blog_image_cubit/cubit/blog_image_cubit.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/core/utils/show_snacbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/upload_blog_bloc/upload_blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/category_container.dart';
import 'package:blog_app/features/blog/presentation/widgets/image_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  final Color color = ColorPallets
      .postColor[Random().nextInt(ColorPallets.postColor.length - 1)];
  File? selectedImage;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final List<String> selectedTopics = [];

  bool validateInput() {
    if (titleController.text.trim().isEmpty &&
        contentController.text.trim().isEmpty) {
      showSnackbar(context, 'Can\'t share empty Blog ! ');
      return false;
    }

    if (titleController.text.trim().isEmpty ||
        titleController.text.length <= 6) {
      showSnackbar(context, 'The title must be atleast 6 characters ');
      return false;
    }
    if (selectedTopics.isEmpty) {
      showSnackbar(context,
          'please Select atleast 1 tag ( \'Food\' , \'Sports\' etc. )');
      return false;
    }
    return true;
  }

  void onUploadBlog() async {
    final isValid = validateInput();

    selectedImage = context.read<BlogImageCubit>().state;

    if (isValid) {
      context.read<BlogBloc>().add(
            BlogUploadRequested(
              blogTitle: titleController.text.trim().trim(),
              image: selectedImage,
              blogContent: contentController.text,
              blogTopics: selectedTopics,
              uploadedAt: DateTime.now(),
            ),
          );
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is BlogFailure) {
          return showSnackbar(
            context,
            state.message,
          );
        }

        if (state is BlogSuccess) {
          Navigator.of(context).pop(
            MaterialPageRoute(
              builder: (ctx) => const BlogPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is BlogLoading) {
          return Loader(
            color: ColorPallets
                .postColor[Random().nextInt(ColorPallets.postColor.length - 1)],
          );
        }

        return Scaffold(
          backgroundColor: ColorPallets.dark,
          appBar: AppBar(
            foregroundColor: ColorPallets.light,
            backgroundColor: ColorPallets.dark,
            leading: IconButton(
              onPressed: () async {
                context.read<BlogImageCubit>().resetImage();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: ColorPallets.light,
              ),
            ),
            actions: [
              IconButton(
                onPressed: onUploadBlog,
                icon: const Icon(
                  size: 30,
                  CupertinoIcons.arrowshape_turn_up_right_fill,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  const Gap(20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tags',
                        style: TextLook()
                            .normalText(19, color)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const Gap(5),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            'Texhnolgy',
                            'Food',
                            'Sports',
                            'Movies',
                            'Personal'
                          ].map((e) {
                            return CategoryContainer(
                              title: e,
                              selectedTopics: selectedTopics,
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  TextField(
                    controller: titleController,
                    maxLength: 50,
                    style: TextLook().normalText(18, ColorPallets.light),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(18),
                      labelText: 'Title',
                      labelStyle: TextLook()
                          .normalText(18, ColorPallets.light.withOpacity(0.5)),
                      border: InputBorder.none,
                    ),
                  ),
                  ImageContainer(
                    color: color,
                  ),
                  const Gap(10),
                  Column(
                    children: [
                      TextField(
                        controller: contentController,
                        maxLines: 10,
                        style: TextLook().normalText(18, ColorPallets.light),
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(18),
                          hintText: 'What\'s happening ?',
                          hintStyle: TextLook().normalText(
                              18, ColorPallets.light.withOpacity(0.5)),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 3, color: color),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              width: 10,
                              color: Colors.grey.withOpacity(
                                1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
