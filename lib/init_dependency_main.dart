part of 'init_dependecies.dart';

final serviceLocator = GetIt.instance; //step 1 declare get_it inctance

Future<void> initDependencies() async {
  // this func is called in main
  _authInit();
  _initblog();
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

  serviceLocator.registerFactory(
    () => InternetConnectionChecker(),
  );

  //core
  serviceLocator.registerLazySingleton(
    () => AuthCurrentUserCubit(),
  );
  serviceLocator.registerFactory<InternetChecker>(
    () => InternetCheckerImpl(internetConnectionChecker: serviceLocator()),
  );
}

void _authInit() {
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(
      firebaseAuthClient: serviceLocator(),
      firestoreAuthRepoositoryImpl: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      authRemoteDatasource: serviceLocator(),
      firestoreAuthRemoteDatasource: serviceLocator(),
      internetChecker: serviceLocator(),
    ),
  );

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
}
