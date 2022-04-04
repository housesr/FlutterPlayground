import 'package:app/shared/data/user/UserResponse.dart';
import 'package:flutter/material.dart';

class UserListView extends StatelessWidget {
  final List<UserResponse> userResponseList;
  final void Function() onUserTap;

  const UserListView({
    Key? key,
    required this.userResponseList,
    required this.onUserTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: userResponseList.length,
      itemBuilder: (context, index) {
        final item = userResponseList[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(
              item.avatarUrl ?? "",
            ),
          ),
          title: Text(
            item.login ?? "",
          ),
          onTap: onUserTap,
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }
}
