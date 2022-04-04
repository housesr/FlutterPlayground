import 'package:app/shared/data/user/UserResponse.dart';
import 'package:app/user/UserListView.dart';
import 'package:app/user/UserSearch.dart';
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/material.dart';

class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserListState();
}

class UserListState extends State<UserList> {
  List<UserResponse> _userResponseList = [];

  @override
  void initState() {
    super.initState();
    _getUsers();
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
                    builder: (context) => const UserSearch(),
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

  // TODO(Separation of concerns & DI)
  void _getUsers() async {
    try {
      final dio = Dio();
      dio.interceptors.add(dioLoggerInterceptor);
      final response = await dio.get("https://api.github.com/users");
      setState(() {
        _userResponseList = (response.data as List)
            .map((e) => UserResponse.fromJson(e))
            .toList();
      });
    } catch (e) {
      // TODO(Show error)
    }
  }
}
