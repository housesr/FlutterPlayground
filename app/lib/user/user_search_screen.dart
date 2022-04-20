import 'package:app/shared/data/user/search_users_response.dart';
import 'package:app/shared/domain/user/use_cases/search_users_use_case.dart';
import 'package:app/shared/service_locators/service_locator.dart';
import 'package:app/shared/util/debouncer.dart';
import 'package:app/user/user_list_view.dart';
import 'package:flutter/material.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserSearchScreenState();
}

class UserSearchScreenState extends State<UserSearchScreen> {
  final Debouncer _debouncer = Debouncer();
  SearchUsersResponse? _searchUsersResponse;

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
        getIt.get<SearchUsersUseCase>().execute(text).then((value) {
          setState(() {
            _searchUsersResponse = value;
          });
        }).catchError((error) {
          debugPrint("search users error:$error");
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
