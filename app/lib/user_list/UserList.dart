import 'package:app/shared/data/user_list/UserResponse.dart';
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
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final list = _userResponseList;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: ListView.separated(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                  item.avatarUrl ?? "",
                ),
              ),
              title: Text(
                item.login ?? "",
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
        ));
  }
}
