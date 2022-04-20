import 'package:app/shared/utils/debouncer.dart';
import 'package:app/user/user_search/user_search_view_model.dart';
import 'package:app/user/widgets/user_list_view.dart';
import 'package:flutter/material.dart';

class UserSearchScreen extends StatefulWidget {
  const UserSearchScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserSearchScreenState();
}

class UserSearchScreenState extends State<UserSearchScreen> {
  final UserSearchViewModel _userSearchViewModel = UserSearchViewModel();
  late final Function() _userSearchListener;
  final Debouncer _debouncer = Debouncer();

  @override
  void initState() {
    super.initState();
    _userSearchListener = () => setState(() {});
    _userSearchViewModel.addListener(_userSearchListener);
  }

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
              userResponseList:
                  _userSearchViewModel.searchUsersResponse?.items ?? [],
              onUserTap: () => {},
            ),
          ),
        ],
      ),
    );
  }

  void _onTextChanged(text) {
    _debouncer.start(const Duration(milliseconds: 300), () {
      _userSearchViewModel.search(text);
    });
  }

  @override
  void dispose() {
    _userSearchViewModel.removeListener(_userSearchListener);
    _debouncer.cancel();
    super.dispose();
  }
}
