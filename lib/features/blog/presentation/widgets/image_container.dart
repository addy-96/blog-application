import 'dart:io';

import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/common/cubits/blog_image_cubit/cubit/blog_image_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImageContainer extends StatefulWidget {
  const ImageContainer({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  State<ImageContainer> createState() => _ImageContainerState();
}

class _ImageContainerState extends State<ImageContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogImageCubit, File?>(
      builder: (context, state) {
        return state == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        context.read<BlogImageCubit>().selectImage();
                      });
                    },
                    icon: Icon(
                      CupertinoIcons.photo_on_rectangle,
                      color: widget.color,
                      weight: 100,
                      size: 40,
                    ),
                  )
                ],
              )
            : InkWell(
                onTap: () {
                  setState(() {
                    context.read<BlogImageCubit>().selectImage();
                  });
                },
                child: Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 3,
                          )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          state,
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              context.read<BlogImageCubit>().resetImage();
                            });
                          },
                          icon: const Icon(
                            CupertinoIcons.xmark_circle,
                            color: ColorPallets.light,
                            size: 40,
                          )),
                    )
                  ],
                ),
              );
      },
    );
  }
}
