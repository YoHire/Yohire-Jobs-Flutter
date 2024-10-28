import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:openbn/core/navigation/app_router.dart';
import 'package:openbn/core/utils/shared_services/firebase_storage/firebase_storage.dart';
import 'package:openbn/core/utils/shared_services/push_notification/push_notification_service.dart';
import 'package:openbn/core/utils/shared_services/refresh_token/dio_interceptor_handler.dart';
import 'package:openbn/core/utils/shared_services/user/user_api_services.dart';
import 'package:openbn/core/utils/shared_services/user/user_storage_services.dart';
import 'package:openbn/core/widgets/timer/bloc/timer_bloc.dart';
import 'package:openbn/features/auth/data/datasource/auth_datasource.dart';
import 'package:openbn/features/auth/data/repository/auth_repository_impl.dart';
import 'package:openbn/features/auth/domain/repository/auth_repository.dart';
import 'package:openbn/features/auth/domain/usecase/auth_usecase.dart';
import 'package:openbn/features/auth/domain/usecase/check_phone_usecase.dart';
import 'package:openbn/features/auth/domain/usecase/create_user_usecase.dart';
import 'package:openbn/features/auth/domain/usecase/sent_otp_usecase.dart';
import 'package:openbn/features/auth/domain/usecase/verify_otp_usecase.dart';
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
import 'package:openbn/features/profile/data/datasource/profile_datasource.dart';
import 'package:openbn/features/profile/data/repository/profile_repository_impl.dart';
import 'package:openbn/features/profile/domain/repository/profile_repository.dart';
import 'package:openbn/features/profile/domain/usecase/update_personal_details_usecase.dart';
import 'package:openbn/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:openbn/features/splash/data/repository/splash_repository_impl.dart';
import 'package:openbn/features/splash/domain/repository/splash_repository.dart';
import 'package:openbn/features/splash/domain/usecases/splash_usecase.dart';
import 'package:openbn/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:openbn/features/username/data/datasource/username_datasource.dart';
import 'package:openbn/features/username/data/repository/username_repository_impl.dart';
import 'package:openbn/features/username/domain/repository/username_repository.dart';
import 'package:openbn/features/username/domain/usecase/username_update_usecase.dart';
import 'package:openbn/features/username/presentation/bloc/username_bloc.dart';
import 'package:openbn/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  await _initFirebase();
  _initRouter();
  _initSplash();
  _initPrefrences();
  _initDioInterceptor();
  _initFirebaseStorage();
  _initHome();
  await _initFirebaseMessaging();
  _initAuth();
  _initProfile();
  __initUserNameServices();
  await _initGetStorage();
  _initTimer();
  await __initUserApiServices();
  await _setupUserServices();
}

Future<void> _initFirebase() async {
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
  final dioInterceptor = DioInterceptorHandler();
  dioInterceptor.setupDio();
  serviceLocator.registerLazySingleton(() => dioInterceptor);
}

_initAuth() {
  serviceLocator.registerLazySingleton(() => FirebaseAuth.instance);
  serviceLocator.registerLazySingleton(() => GoogleSignIn());
  serviceLocator.registerFactory<AuthDatasource>(() => AuthDatasourceImpl());
  serviceLocator.registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => AuthUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => CheckPhoneUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => SentOtpUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => VerifyOtpUsecase(serviceLocator()));
  serviceLocator.registerFactory(() => CreateUserUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(() => AuthBloc(
      verifyOtpUsecase: serviceLocator(),
      authUsecase: serviceLocator(),
      createUserUsecase: serviceLocator(),
      checkPhoneUsecase: serviceLocator(),
      sendOtpUsecase: serviceLocator()));
}

_initProfile() {
  serviceLocator
      .registerFactory<ProfileDatasource>(() => ProfileDatasourceImpl());
  serviceLocator.registerFactory<ProfileRepository>(
      () => ProfileRepositoryImpl(serviceLocator()));
  serviceLocator
      .registerFactory(() => UpdatePersonalDetailsUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => ProfileBloc(updatePersonalDetailsUsecase: serviceLocator()));
}

__initUserNameServices() {
  serviceLocator.registerFactory<UsernameRemoteDatasource>(
      () => UsernameRemoteDatasourceImpl());
  serviceLocator.registerFactory<UsernameRepository>(
      () => UsernameRepositoryImpl(serviceLocator()));
  serviceLocator.registerFactory(() => UsernameUpdateUsecase(serviceLocator()));
  serviceLocator.registerLazySingleton(
      () => UsernameBloc(usernameUpdateUsecase: serviceLocator()));
}

Future<void> _initFirebaseMessaging() async {
  serviceLocator.registerLazySingleton(() => FirebaseMessaging.instance);
  serviceLocator.registerFactory(() => NotificationService());
  final service = serviceLocator<NotificationService>();
  await service.initialize();
}

_initFirebaseStorage() {
  serviceLocator.registerLazySingleton(() => FirebaseStorage.instance);
  serviceLocator.registerLazySingleton(() => FileUploadService());
}

Future<void> _setupUserServices() async {
  serviceLocator.registerLazySingleton<UserStorageService>(() => UserStorageService());
  await serviceLocator<UserStorageService>().init();
  await serviceLocator<UserStorageService>().updateUser();
}

_initTimer() {
  serviceLocator.registerLazySingleton(() => TimerBloc());
}

void _initRouter() {
  serviceLocator.registerSingleton<GoRouter>(AppRouter.router);
}

__initUserApiServices() async {
  serviceLocator.registerFactory<UserApiServices>(() => UserApiServices());
  await serviceLocator<UserApiServices>().getUser();
}
