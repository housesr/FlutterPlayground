import 'package:app/shared/data/user/search_users_response.dart';
import 'package:app/shared/util/debouncer.dart';
import 'package:app/user/user_list_view.dart';
import 'package:dio/dio.dart';
import 'package:dio_logger/dio_logger.dart';
import 'package:flutter/material.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserSearchState();
}

class UserSearchState extends State<UserSearch> {
  final Debouncer _debouncer = Debouncer();
  SearchUsersResponse? _searchUsersResponse;

  // TODO(Separation of concerns & DI)
  Future<SearchUsersResponse?> _searchUsers(String query) async {
    final dio = Dio();
    dio.interceptors.add(dioLoggerInterceptor);
    final response = await dio.get("https://api.github.com/search/users",
        queryParameters: {"q": query});
    return SearchUsersResponse.fromJson(response.data);
  }

  // TODO(Empty state)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search for users"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                label: Text("User name"),
                suffixIcon: Icon(Icons.search),
              ),
              onChanged: _onTextChanged,
            ),
          ),
          Expanded(
            child: UserListView(
              userResponseList: _searchUsersResponse?.items ?? [],
              onUserTap: () => {},
            ),
          ),
        ],
      ),
    );
  }

  void _onTextChanged(text) {
    _debouncer.start(const Duration(milliseconds: 300), () {
      if (text.isEmpty) {
        setState(() {
          _searchUsersResponse = null;
        });
      } else {
        _searchUsers(text).then((value) {
          setState(() {
            _searchUsersResponse = value;
          });
        }).catchError((error) {
          print("search users error:$error");
          // TODO(Show error)
        });
      }
    });
  }

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }
}
