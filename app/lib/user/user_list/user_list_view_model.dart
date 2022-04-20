import 'dart:collection';

import 'package:app/shared/data/user/entities/user_response.dart';
import 'package:app/shared/domain/user/use_cases/get_users_use_case.dart';
import 'package:app/shared/service_locators/service_locator.dart';
import 'package:flutter/material.dart';

class UserListViewModel extends ChangeNotifier {
  final GetUsersUseCase _getUsersUseCase = getIt.get();

  List<UserResponse> _userList = [];

  UnmodifiableListView<UserResponse> get userList =>
      UnmodifiableListView(_userList);

  void init() {
    _getUsersUseCase.execute().then((value) {
      _userList = value;
      notifyListeners();
    }).catchError((error) {
      debugPrint("get users error:$error");
      // TODO(show error)
      notifyListeners();
    });
  }
}
