import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomPopUpMenu extends StatelessWidget {
  const CustomPopUpMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: ColorPallets.light,
      iconColor: ColorPallets.light,
      itemBuilder: (context) => <PopupMenuEntry>[
        PopupMenuItem(
            onTap: () {
            },
            child: Text('Saved',
                style: TextLook().normalText(18, ColorPallets.dark))),
        PopupMenuItem(
          onTap: () {
            context.read<AuthBloc>().add(AuthLogOutRequested());
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
