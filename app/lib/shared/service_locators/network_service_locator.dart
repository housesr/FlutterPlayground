import 'package:app/shared/service_locators/service_locator.dart';
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';

class NetworkServiceLocator {
  static void setup() {
    getIt.registerLazySingleton<Dio>(() {
      final dio = Dio();
      dio.interceptors.add(dioLoggerInterceptor);
      return dio;
    });
  }
}
