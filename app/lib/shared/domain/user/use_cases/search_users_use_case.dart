import 'package:app/shared/data/user/search_users_response.dart';
import 'package:app/shared/service_locators/service_locator.dart';
import 'package:dio/dio.dart';

class SearchUsersUseCase {
  Future execute(String query) async {
    final dio = getIt.get<Dio>();
    final response = await dio.get("https://api.github.com/search/users",
        queryParameters: {"q": query});
    return SearchUsersResponse.fromJson(response.data);
  }
}
