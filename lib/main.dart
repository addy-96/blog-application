// The app follows features first approach eg. in features the first folder is auth and 3 sub folders data domain presentaion and again the presentaion has 3 sub folders pages , widgets and bloc

import 'package:blog_app/core/common/cubits/auth_cubit/auth_current_user_cubit.dart';
import 'package:blog_app/core/common/cubits/blog_image_cubit/cubit/blog_image_cubit.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/pages/login_page.dart';
import 'package:blog_app/features/blog/presentation/bloc/fetch_blog_bloc/fetch_blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/upload_blog_bloc/upload_blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_app/init_dependecies.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    DevicePreview(
      builder: (context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => serviceLocator<AuthBloc>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<AuthCurrentUserCubit>(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<FetchBlogBloc>(),
          ),
          BlocProvider(
            create: (_) => BlogImageCubit(),
          ),
          BlocProvider(
            create: (_) => serviceLocator<BlogBloc>(),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState(); // add get current user state
    context.read<AuthBloc>().add(GetCurrentUser());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Blog App',
        debugShowCheckedModeBanner: false,
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              final User? user = snapshot.data;

              if (user == null) {
                // User is NOT logged in
                return const LoginPage();
              } else {
                // User IS logged in
                return const BlogPage();
              }
            }
            return Container();
          },
        ));
  }
}
