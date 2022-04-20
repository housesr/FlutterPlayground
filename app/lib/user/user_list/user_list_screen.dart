import 'package:app/user/user_list/user_list_view_model.dart';
import 'package:app/user/user_search/user_search_screen.dart';
import 'package:app/user/widgets/user_list_view.dart';
import 'package:flutter/material.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  final UserListViewModel _userListViewModel = UserListViewModel();
  late final Function() _userListListener;

  @override
  void initState() {
    super.initState();
    _userListViewModel.init();
    _userListListener = () => setState(() {});
    _userListViewModel.addListener(_userListListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
        actions: [
          IconButton(
            onPressed: () => _navigateToUserSearchScreen(),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: UserListView(
        userResponseList: _userListViewModel.userList,
        onUserTap: () => {},
      ),
    );
  }

  void _navigateToUserSearchScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UserSearchScreen(),
        ));
  }

  @override
  void dispose() {
    _userListViewModel.removeListener(_userListListener);
    super.dispose();
  }
}
