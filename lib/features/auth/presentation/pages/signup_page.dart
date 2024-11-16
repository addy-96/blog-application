//Todo: to add firebase cloud for storing user data after signUp

import 'package:blog_app/core/color_pallets.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/routes.dart';
import 'package:blog_app/core/text_look.dart';
import 'package:blog_app/core/utils/show_snacbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/auth/presentation/widgets/custom_button.dart';
import 'package:blog_app/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _text = TextLook();
  final themeColor = ColorPallets.postColor[ColorPallets().getRandomIndex()];

  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void onSignUp() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      context.read<AuthBloc>().add(
            AuthSignUpRequested(
              name: usernameController.text.trim(),
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallets.dark,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthFailure) {
                  showSnackbar(
                    context,
                    state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return Loader(
                    color: themeColor,
                  );
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Sign Up',
                        style: _text.normalText(
                          32,
                          ColorPallets.light,
                        ),
                      ),
                      const Gap(15),
                      CustomTextfield(
                        textController: usernameController,
                        hintText: 'Username',
                        themeColor: themeColor,
                      ),
                      const Gap(10),
                      CustomTextfield(
                        textController: emailController,
                        hintText: 'Email',
                        themeColor: themeColor,
                      ),
                      const Gap(10),
                      CustomTextfield(
                        textController: passwordController,
                        hintText: 'Password',
                        themeColor: themeColor,
                      ),
                      const Gap(15),
                      CustomButton(
                        onPressed: onSignUp,
                        themeColor: themeColor,
                        buttonText: 'Sign Up',
                      ),
                      const Gap(15),
                      GestureDetector(
                        onTap: () {
                          MaterialNavigate().pushPage(
                            context,
                            const LoginPage(),
                          );
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an Account ?',
                            style: _text.normalText(
                              18,
                              ColorPallets.light,
                            ),
                            children: [
                              TextSpan(
                                text: ' LogIn ',
                                style: _text
                                    .normalText(
                                      18,
                                      themeColor,
                                    )
                                    .copyWith(
                                      fontWeight: FontWeight.w900,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
