import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/utils/show_snacbar.dart';
import 'package:blog_app/features/blog/presentation/bloc/delete_blog_bloc/delete_blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/delete_blog_bloc/delete_blog_event.dart';
import 'package:blog_app/features/blog/presentation/bloc/delete_blog_bloc/delete_blog_state.dart';
import 'package:blog_app/features/blog/presentation/bloc/fetch_blog_bloc/fetch_blog_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteButton extends StatefulWidget {
  const DeleteButton({
    super.key,
    required this.blogID,
  });

  final String blogID;

  @override
  State<DeleteButton> createState() => _DeleteButtonState();
}

class _DeleteButtonState extends State<DeleteButton> {
  void onDelete() {
    context
        .read<DeleteBlogBloc>()
        .add(DeleteBlogRequested(blogID: widget.blogID));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onDelete();
      },
      child: BlocConsumer<DeleteBlogBloc, DeleteBlogState>(
        listener: (context, state) {
          if (state is DeleteBlogSuccessState) {
            showSnackbar(
              context,
              'Deleted Successfully',
            );
            context.read<FetchBlogBloc>().add(FetchBlogRequested());
          }
          if (state is DeleteBlogFailureState) {
            showSnackbar(
              context,
              state.errorMessage,
            );
          }
        },
        builder: (context, state) {
          if (state is DeleteBlogLoadingState) {
            return Loader(color: Colors.white);
          }
          return Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(50),
            color: ColorPallets.dark,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                CupertinoIcons.delete_simple,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
