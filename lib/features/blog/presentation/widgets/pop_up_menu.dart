import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/saved_blogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPopUpMenu extends StatelessWidget {
  const CustomPopUpMenu({super.key});


Future<String> getUserId() async =>
  FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: ColorPallets.light,
      iconColor: ColorPallets.light,
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (ctx) => const SavedBlogs(),
              ),
            );
          },
          child: Text(
            'Saved',
            style: TextLook().normalText(
              18,
              ColorPallets.dark,
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () {
            context.read<AuthBloc>().add(
                  AuthLogOutRequested(),
                );
          },
          child: Text(
            'Log Out',
            style: TextLook().normalText(18, ColorPallets.dark),
          ),
        ),
      ],
    );
  }
}
