import 'package:app/shared/service_locators/service_locator.dart';
import 'package:app/user/user_list/user_list_screen.dart';
import 'package:app/user/user_list/user_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  ServiceLocator.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      home: ChangeNotifierProvider(
        create: (context) => UserListViewModel(),
        child: const UserListScreen(),
      ),
    );
  }
}
