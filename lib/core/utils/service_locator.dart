import 'package:get_it/get_it.dart';
import 'package:openbn/core/services/dio_interceptor_handler.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // Register DioInterceptorHandler as a singleton
  getIt.registerSingleton<DioInterceptorHandler>(DioInterceptorHandler());

}