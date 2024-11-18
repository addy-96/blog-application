import 'dart:io';

import 'package:blog_app/core/common/cubits/blog_image_cubit/cubit/blog_image_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    super.key,
  });

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        setState(() {
          context.read<BlogImageCubit>().selectImage();
          // Update state correctly
        });
      },
      child: Container(
        height: MediaQuery.of(context).size.width / 2.5,
        width: double.infinity,
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withOpacity(0.3),
              width: 4,
            ),
            borderRadius: BorderRadius.circular(15)),
        child: BlocBuilder<BlogImageCubit, File?>(
          builder: (context, state) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: state == null
                    ? const Icon(
                        CupertinoIcons.camera,
                        color: Colors.grey,
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.file(
                          state,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
