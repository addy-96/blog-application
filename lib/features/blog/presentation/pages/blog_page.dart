import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallets.dark,
      appBar: AppBar(
        backgroundColor: ColorPallets.dark,
        title: Text(
          'Blogs',
          style: TextLook().normalText(32, ColorPallets.light),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorPallets.light,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => const AddNewBlogPage(),
            ),
          );
        },
        child: Text(
          '+',
          style: TextLook().normalText(
            40,
            ColorPallets.dark,
          ),
        ),
      ),
    );
  }
}
