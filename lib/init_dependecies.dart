/* this file is used for depenndcy injection using get_it package here getit has many function but 2 are general mostly used ------- .registerLazySingleton ------ when we want to use a inctance only created once and used through out and not everytime a new inctance everytime eg. firebaseAuth.inctance we only want it once also AuthBloc because we want a single inctance for it  , --------------  another is  ---------.registoryfactory------------ which when called create a new inctance everytime and then we use servicelocator() like a function and get_it is smart enough to find the correct service without specifyng in general but sometime we need to specify  using generics < > type lets take a example

as we see below AuthRepositoryImpl but when we need this service the parent service requestiong is requesting a AuthReposistory service ( which at back of scene is a interface and AuthRepositoryImpl is its implementation ) therefore we need to specify <AuthRepository>

  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuthClient: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: serviceLocator(),
    ),
  );





and finally in main we declare  in BlocProvider as : 

serviceLocator<AuthBloc>();


and thats how dependecyinjection works
*/

import 'package:blog_app/core/common/cubits/auth_cubit/auth_current_user_cubit.dart';
import 'package:blog_app/core/internet_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/datasources/firestore_auth_remote_datasource.dart';
import 'package:blog_app/features/auth/data/repository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/data/repository/firestore_auth_repoository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:blog_app/features/auth/domain/usecases/user_logout.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/blog/data/datsources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_reppsitory.dart';
import 'package:blog_app/features/blog/domain/usecases/display_saved_blogs.dart';
import 'package:blog_app/features/blog/domain/usecases/fetch_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/get_username.dart';
import 'package:blog_app/features/blog/domain/usecases/save_blog.dart';
import 'package:blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:blog_app/features/blog/presentation/bloc/display_saved_blogs_bloc/display_saved_blogs_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/fetch_blog_bloc/fetch_blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/get_username_bloc/get_username_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/save_blog_bloc/save_blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/bloc/upload_blog_bloc/upload_blog_bloc.dart';
import 'package:blog_app/firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'init_dependency_main.dart';
