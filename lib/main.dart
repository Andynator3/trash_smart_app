import 'package:flutter/material.dart';
import 'package:trash_smart_app/ui/pages/home.page.dart';
import 'package:trash_smart_app/ui/pages/trash.page.dart';
import 'package:trash_smart_app/ui/pages/trashcan.page.dart';
import 'package:trash_smart_app/ui/pages/users.page.dart';

// This is the entry point of the application
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return const RootView();
  }

}

class RootView extends StatelessWidget {
  const RootView({Key? key}) : super(key: key);

  //the roots of the pages.
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.lightBlue
      ),
      routes: {
        "/" : (context)=> const HomePage(),
        "/users" : (context)=> const UsersPage(),
        "/trashcan" : (context)=> const TrashCanPage(),
        "/trash" : (context)=> const TrashPage(),
      },
      initialRoute: "/",
    );
  }
}





