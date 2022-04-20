import 'package:app/user/user_list/user_list_view_model.dart';
import 'package:app/user/user_search/user_search_screen.dart';
import 'package:app/user/user_search/user_search_view_model.dart';
import 'package:app/user/widgets/user_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => UserListScreenState();
}

class UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserListViewModel>().init();
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
        userResponseList: context.watch<UserListViewModel>().userList,
        onUserTap: () => {},
      ),
    );
  }

  void _navigateToUserSearchScreen() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => UserSearchViewModel(),
            child: const UserSearchScreen(),
          ),
        ));
  }
}
