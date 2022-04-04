import 'package:app/shared/data/user/user_response.dart';
import 'package:app/user/user_list_view.dart';
import 'package:app/user/user_search.dart';
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
    _getUsers().then((value) {
      setState(() {
        _userResponseList = value;
      });
    }).catchError((error) {
      print("get users error:$error");
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
  Future _getUsers() async {
    final dio = Dio();
    dio.interceptors.add(dioLoggerInterceptor);
    final response = await dio.get("https://api.github.com/users");
    return (response.data as List)
        .map((e) => UserResponse.fromJson(e))
        .toList();
  }
}
