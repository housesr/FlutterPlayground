import 'package:app/shared/utils/debouncer.dart';
import 'package:app/user/user_search/user_search_view_model.dart';
import 'package:app/user/widgets/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserSearchScreenState();
}

class UserSearchScreenState extends State<UserSearchScreen> {
  final Debouncer _debouncer = Debouncer();

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
              userResponseList: context
                      .watch<UserSearchViewModel>()
                      .searchUsersResponse
                      ?.items ??
                  [],
              onUserTap: () => {},
            ),
          ),
        ],
      ),
    );
  }

  void _onTextChanged(text) {
    _debouncer.start(const Duration(milliseconds: 300), () {
      context.read<UserSearchViewModel>().search(text);
    });
  }

  @override
  void dispose() {
    _debouncer.cancel();
    super.dispose();
  }
}
