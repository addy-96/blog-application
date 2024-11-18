import 'dart:io';
import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/features/blog/presentation/widgets/category_container.dart';
import 'package:blog_app/features/blog/presentation/widgets/image_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddNewBlogPage extends StatefulWidget {
  const AddNewBlogPage({super.key});

  @override
  State<AddNewBlogPage> createState() => _AddNewBlogPageState();
}

class _AddNewBlogPageState extends State<AddNewBlogPage> {
  File? selectedImage;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final List<String> selectedTopics = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallets.dark,
      appBar: AppBar(
        foregroundColor: ColorPallets.light,
        backgroundColor: ColorPallets.dark,
        actions: [
          IconButton(
            onPressed: () {},
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
              const ImageContainer(),
              const Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tags',
                    style: TextLook().normalText(15, ColorPallets.light),
                  ),
                  const Gap(5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children:
                          ['Texhnolgy', 'Food', 'Sports', 'Movies'].map((e) {
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
                maxLength: 50,
                style: TextLook().normalText(15, ColorPallets.light),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  labelText: 'Title',
                  labelStyle: TextLook().normalText(15, ColorPallets.light),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 10,
                      color: Colors.grey.withOpacity(
                        0.5,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(20),
              TextField(
                maxLength: 50,
                maxLines: 10,
                style: TextLook().normalText(15, ColorPallets.light),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(18),
                  hintText: 'Body',
                  hintStyle: TextLook().normalText(15, ColorPallets.light),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      width: 10,
                      color: Colors.grey.withOpacity(
                        0.5,
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }
}
