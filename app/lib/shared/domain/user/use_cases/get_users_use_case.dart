import 'package:app/shared/data/user/user_response.dart';
import 'package:app/shared/service_locators/service_locator.dart';
import 'package:dio/dio.dart';

class GetUsersUseCase {
  Future execute() async {
    final dio = getIt.get<Dio>();
    final response = await dio.get("https://api.github.com/users");
    return (response.data as List)
        .map((e) => UserResponse.fromJson(e))
        .toList();
  }
}
