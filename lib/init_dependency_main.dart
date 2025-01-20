part of 'init_dependecies.dart';

final serviceLocator = GetIt.instance; //step 1 declare get_it inctance

Future<void> initDependencies() async {
  // this func is called in main
  _authInit();
  _initblog();

  final sharedPreferences = await SharedPreferences.getInstance();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  serviceLocator.registerLazySingleton(
    // service locator for firebaseAuth inctance
    () => FirebaseAuth.instance,
  );

  serviceLocator.registerLazySingleton(
    () => FirebaseFirestore.instance,
  );

  serviceLocator.registerLazySingleton(
    () => FirebaseStorage.instance,
  );

  serviceLocator.registerLazySingleton(
    () => InternetConnectionChecker.createInstance(),
  );

  serviceLocator.registerFactory(
    () => Supabase.instance,
  );

  //core
  serviceLocator.registerLazySingleton(
    () => AuthCurrentUserCubit(),
  );
  serviceLocator.registerFactory<InternetChecker>(
    () => InternetCheckerImpl(internetConnectionChecker: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => sharedPreferences,
  );
}

void _authInit() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuthClient: serviceLocator(),
      firestoreAuthRepoositoryImpl: serviceLocator(),
      sharedPref: serviceLocator(),
      blogRemoteDataSource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: serviceLocator(),
      firestoreAuthRemoteDatasource: serviceLocator(),
      internetChecker: serviceLocator(),
    ),
  );

//usecases
  serviceLocator.registerFactory(
    () => UserSignUp(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogin(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserLogout(
      authRepository: serviceLocator(),
    ),
  );

  //bloc

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userLogout: serviceLocator(),
      userSignUp: serviceLocator(),
      userLogin: UserLogin(
        authRepository: serviceLocator(),
      ),
      authCurrentUserCubit: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => FirestoreAuthRepoositoryImpl(
      firestoreAuthRemoteDatasource: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<FirestoreAuthRemoteDatasource>(
    () => FirestoreeAuthRemoteDtaSourceImpl(
      firestore: serviceLocator(),
    ),
  );
}

void _initblog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImpl(
      firestore: serviceLocator(),
      fireStorage: serviceLocator(),
      supabase: serviceLocator(),
      firebaseAuth: serviceLocator(),
      sharedPref: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SaveBlog(
      blogReppsitory: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => DisplaySavedBlogs(
      blogReppsitory: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<BlogReppsitory>(
    () => BlogRepositoryImpl(
      blogRemoteDataSource: serviceLocator(),
      auth: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UploadBlog(
      blogReppsitory: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlog: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => FetchBlog(
      blogReppsitory: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => FetchBlogBloc(
      fetchBlog: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetUsername(
      blogReppsitory: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetUsernameBloc(
      getUsername: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => SaveBlogBloc(
      saveBlog: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => DisplaySavedBlogsBloc(
      displaySavedBlogs: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => DeleteBlog(
      blogReppsitory: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => DeleteBlogBloc(
      deleteBlog: serviceLocator(),
    ),
  );
}
