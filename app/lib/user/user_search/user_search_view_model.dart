import 'package:app/shared/data/user/entities/search_users_response.dart';
import 'package:app/shared/domain/user/use_cases/search_users_use_case.dart';
import 'package:app/shared/service_locators/service_locator.dart';
import 'package:flutter/material.dart';

class UserSearchViewModel extends ChangeNotifier {
  final SearchUsersUseCase _searchUsersUseCase = getIt.get();

  SearchUsersResponse? _searchUsersResponse;

  SearchUsersResponse? get searchUsersResponse => _searchUsersResponse;

  void search(String query) {
    if (query.isEmpty) {
      _searchUsersResponse = null;
      notifyListeners();
    } else {
      _searchUsersUseCase.execute(query).then((value) {
        _searchUsersResponse = value;
        notifyListeners();
      }).catchError((error) {
        debugPrint("search users error:$error");
        // TODO(show error)
        notifyListeners();
      });
    }
  }
}
