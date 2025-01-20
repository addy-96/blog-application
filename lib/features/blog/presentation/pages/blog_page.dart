import 'dart:math';

import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/blog/presentation/bloc/fetch_blog_bloc/fetch_blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_container.dart';
import 'package:blog_app/features/blog/presentation/widgets/pop_up_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    context.read<FetchBlogBloc>().add(FetchBlogRequested());
    super.initState();
  }

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
        actions: const [
          CustomPopUpMenu(),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocConsumer<FetchBlogBloc, FetchBlogState>(
            listener: (context, state) {
              if (state is FetchBlogLoading) {
                Loader(
                  color: ColorPallets.postColor[
                      Random().nextInt(ColorPallets.postColor.length - 1)],
                );
              }
              if (state is AuthUserLoggedOut) {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (ctx) => const LoginPage()));
              }
            },
            builder: (context, state) {
              if (state is FetchBlogFailure) {
                return const Center(
                  child: Text('Error ! Try Again...'),
                );
              }

              if (state is FetchblogSuccess) {
                return FutureBuilder(
                  future: state.fetchedBlogList,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Loader(color: ColorPallets.light);
                    }
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final wordCount = snapshot.data![index].blogContent
                              .split(RegExp(r'\s+'))
                              .length; // counting the words in the content
                          return InkWell(
                            radius: 10,
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (ctx) => BlogDetails(
                                    blog: snapshot.data![index],
                                  ),
                                ),
                              );
                            },
                            enableFeedback: true,
                            child: BlogContainer(
                              selectedTopics: snapshot.data![index].blogTopics,
                              blogTitle: snapshot.data![index].blogTitle,
                              blogContentWordCount: wordCount,
                              userId: snapshot.data![index].uploaderId,
                              blogId: snapshot.data![index].blogId,
                      
                            ),
                          );
                        },
                      );
                    }
                    return const Text('Future builder');
                  },
                );
              }
              return const Text('Some Error Occcured ! ');
            },
          )),
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
        child: const Icon(
          CupertinoIcons.pencil_outline,
          size: 40,
        ),
      ),
    );
  }
}


/*  */