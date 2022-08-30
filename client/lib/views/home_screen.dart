import 'package:flutter/material.dart';
import 'package:flutter_graphql/views/users_page.dart';
import 'add_user_page.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({Key? key}) : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  
  @override
  Widget build(BuildContext context){
    Widget content = const UsersPage();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Users and Hobbies",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
      ),
      body: Center(
        child: content,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final route = MaterialPageRoute(builder: (context) => const AddUserPage());
          await Navigator.push(context, route);
        },
        backgroundColor: Colors.lightGreenAccent,
        child: const Icon(Icons.group_add),
      ), 
    );
  }
}