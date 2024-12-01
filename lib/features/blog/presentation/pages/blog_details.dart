import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/core/utils/calculate_blog_reading_time.dart';
import 'package:blog_app/core/utils/get_formated_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/get_username_bloc/get_username_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BlogDetails extends StatefulWidget {
  const BlogDetails({super.key, required this.blog});

  final Blog blog;

  @override
  State<BlogDetails> createState() => _BlogDetailsState();
}

class _BlogDetailsState extends State<BlogDetails> {
  @override
  void initState() {
    context
        .read<GetUsernameBloc>()
        .add(UsernameRequested(userID: widget.blog.uploaderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPallets.dark,
        foregroundColor: ColorPallets.light,
      ),
      backgroundColor: ColorPallets.dark,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          interactive: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.blog.blogTitle.toUpperCase(),
                  style: TextLook()
                      .normalText(28, ColorPallets.light)
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                const Gap(30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BlocBuilder<GetUsernameBloc, GetUsernameState>(
                      builder: (context, state) {
                        if (state is GetUsernameSuccess) {
                          return FutureBuilder(
                            future: state.username,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Text(
                                  'by ${snapshot.requireData}',
                                  style: TextLook()
                                      .normalText(15, ColorPallets.light),
                                );
                              }
                              return Container();
                            },
                          );
                        }
                        return Container();
                      },
                    ),
                    const Gap(20),
                    widget.blog.blogImageUrl != ''
                        ? Container(
                            height: MediaQuery.of(context).size.height / 3,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                fit: BoxFit.cover,
                                widget.blog.blogImageUrl,
                              ),
                            ),
                          )
                        : const SizedBox(),
                    const Gap(20),
                    Text(
                      '${getFormattedDatedMMMyyyy(widget.blog.updatedAt)}'
                      ' , '
                      '${calculateBlogReadingTime(widget.blog.blogContent.length)} min',
                      style: TextLook().normalText(15, ColorPallets.light),
                    ),
                  ],
                ),
                const Gap(30),
                Text(widget.blog.blogContent,
                    style: TextLook()
                        .normalText(14, ColorPallets.light)
                        .copyWith(
                            letterSpacing: 1,
                            fontWeight: FontWeight.bold,
                            height: 2)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
