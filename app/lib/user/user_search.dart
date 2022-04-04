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
  void _searchUsers(String query) async {
    try {
      final dio = Dio();
      dio.interceptors.add(dioLoggerInterceptor);
      final response = await dio.get("https://api.github.com/search/users",
          queryParameters: {"q": query});
      setState(() {
        _searchUsersResponse = SearchUsersResponse.fromJson(response.data);
      });
    } catch (e) {
      // TODO(Show error)
    }
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
          TextField(
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.search,
            decoration: const InputDecoration(
              label: Text("User name"),
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: (text) => {
              _debouncer.start(
                  const Duration(milliseconds: 300), () => _searchUsers(text))
            },
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

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }
}
