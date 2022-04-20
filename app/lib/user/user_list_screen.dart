import 'package:app/shared/data/user/user_response.dart';
import 'package:app/shared/domain/user/use_cases/get_users_use_case.dart';
import 'package:app/shared/service_locators/service_locator.dart';
import 'package:app/user/user_list_view.dart';
import 'package:app/user/user_search_screen.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  List<UserResponse> _userResponseList = [];

  @override
  void initState() {
    super.initState();
    getIt.get<GetUsersUseCase>().execute().then((value) {
      setState(() {
        _userResponseList = value;
      });
    }).catchError((error) {
      debugPrint("get users error:$error");
      // TODO(Show error)
    });
  }

  // TODO(Empty state)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UserSearchScreen(),
                  ))
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: UserListView(
        userResponseList: _userResponseList,
        onUserTap: () => {},
      ),
    );
  }
}
