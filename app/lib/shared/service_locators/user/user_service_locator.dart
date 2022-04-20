import 'package:app/shared/domain/user/use_cases/get_users_use_case.dart';
import 'package:app/shared/domain/user/use_cases/search_users_use_case.dart';
import 'package:app/shared/service_locators/service_locator.dart';

class UserServiceLocator {
  static void setup() {
    getIt.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase());
    getIt.registerLazySingleton<SearchUsersUseCase>(() => SearchUsersUseCase());
  }
}
