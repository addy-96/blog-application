import 'dart:developer';
import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/features/blog/presentation/bloc/save_blog_bloc/save_blog_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveButton extends StatefulWidget {
  const SaveButton({
    super.key,
    required this.blogId,
  });

  final String blogId;


  @override
  State<SaveButton> createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    _initializeSavedState();
  }

  Future<void> _initializeSavedState() async {
    isSaved = await checkIfSaved();
    setState(() {}); // Trigger UI update after fetching initial state
  }

  Future<bool> checkIfSaved() async {
    final pref = await SharedPreferences.getInstance();
    try {
      final List<String> savedBlogsList =
          pref.getStringList('savedBlogs') ?? [];
      return savedBlogsList.contains(widget.blogId);
    } catch (err) {
      log(err.toString());
      return false;
    }
  }

  Future<void> onSaveUnsave() async {
    context
        .read<SaveBlogBloc>()
        .add(SaveUnsaveBlogRequested(blogId: widget.blogId));

    // Simulate toggling the save state locally for better user experience
    final pref = await SharedPreferences.getInstance();
    final List<String> savedBlogsList = pref.getStringList('savedBlogs') ?? [];

    if (savedBlogsList.contains(widget.blogId)) {
      savedBlogsList.remove(widget.blogId);
      isSaved = false;
    } else {
      savedBlogsList.add(widget.blogId);
      isSaved = true;
    }

    await pref.setStringList('savedBlogs', savedBlogsList);
    setState(() {}); // Trigger UI update after saving
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSaveUnsave,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(50),
        color: ColorPallets.dark,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            isSaved ? CupertinoIcons.bookmark_fill : CupertinoIcons.bookmark,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
