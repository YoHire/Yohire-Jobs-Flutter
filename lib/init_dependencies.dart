import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:openbn/core/services/dio_interceptor_handler.dart';
import 'package:openbn/features/auth/data/datasource/auth_datasource.dart';
import 'package:openbn/features/auth/data/repository/auth_repository_impl.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';
import 'package:openbn/features/auth/domain/usecase/auth_usecase.dart';
import 'package:openbn/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:openbn/features/home/data/datasource/job_api_datasource.dart';
import 'package:openbn/features/home/data/repository/home_repository_impl.dart';
import 'package:openbn/features/home/domain/repository/home_repository.dart';
import 'package:openbn/features/home/domain/usecase/get_jobs_usecase.dart';
import 'package:openbn/features/home/presentation/bloc/home_bloc.dart';
import 'package:openbn/features/prefrences/data/datasource/jobroles_remote_data_source.dart';
import 'package:openbn/features/prefrences/data/repository/prefrence_repository_impl.dart';
import 'package:openbn/features/prefrences/domain/repository/prefrence_repository.dart';
import 'package:openbn/features/prefrences/domain/usecase/create_guest_user.dart';
import 'package:openbn/features/prefrences/domain/usecase/job_roles_usecase.dart';
import 'package:openbn/features/prefrences/domain/usecase/search_job_roles_usecase.dart';
import 'package:openbn/features/prefrences/presentation/bloc/prefrence_bloc.dart';
import 'package:openbn/features/splash/data/repository/splash_repository_impl.dart';
import 'package:openbn/features/splash/domain/repository/splash_repository.dart';
import 'package:openbn/features/splash/domain/usecases/splash_usecase.dart';
import 'package:openbn/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:openbn/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initSplash();
  _initPrefrences();
  _initDioInterceptor();
  _initHome();
  _initFirebaseMessaging();
  _initAuth();
  await _initGetStorage();
  final firebase = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  serviceLocator.registerLazySingleton(() => firebase);
}

_initSplash() {
  serviceLocator
      .registerFactory<SplashRepository>(() => SplashRepositoryImpl());
  serviceLocator.registerFactory(() => SplashUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => SplashBloc(splashUsecase: serviceLocator())..add(SplashLoaded()));
}

_initPrefrences() {
  serviceLocator.registerFactory<JobrolesRemoteDataSource>(
      () => JobrolesRemoteDataSourceImpl());
  serviceLocator.registerFactory<PrefrenceRepository>(
      () => PrefrenceRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => JobRolesUseCase(serviceLocator()));
  serviceLocator.registerFactory(() => SearchJobRolesUsecase(serviceLocator()));
  serviceLocator
      .registerFactory(() => CreateGuestUserUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => PrefrenceBloc(
      jobRolesUseCase: serviceLocator(),
      createGuestUserUsecase: serviceLocator(),
      searchJobRolesUsecase: serviceLocator()));
}

_initHome() {
  serviceLocator
      .registerFactory<JobRemoteDataSource>(() => JobRemoteDataSourceImpl());
  serviceLocator.registerFactory<HomeRepository>(
      () => HomeRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => GetAllJobsUsecase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => HomeBloc(allJobsUsecase: serviceLocator()));
}

_initGetStorage() async {
  await GetStorage.init();
  serviceLocator.registerLazySingleton<GetStorage>(() => GetStorage());
}

_initDioInterceptor() {
  serviceLocator.registerLazySingleton(() => DioInterceptorHandler());
}

_initAuth() {
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => GoogleSignIn());
   serviceLocator
      .registerFactory<AuthDatasource>(() => AuthDatasourceImpl());
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => AuthUsecase(serviceLocator()));
  serviceLocator
      .registerLazySingleton(() => AuthBloc(authUsecase: serviceLocator()));
}

_initFirebaseMessaging() {
  serviceLocator.registerLazySingleton(() => FirebaseMessaging.instance);
}
