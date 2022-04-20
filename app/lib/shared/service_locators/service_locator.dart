import 'package:app/shared/service_locators/network_service_locator.dart';
import 'package:app/shared/service_locators/user/user_service_locator.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

class ServiceLocator {
  static void setup() {
    NetworkServiceLocator.setup();
    UserServiceLocator.setup();
  }
}
