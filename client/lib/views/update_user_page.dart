import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  final String id;
  final String name;
  final String age;
  final String profession;
  
  const UpdateUser(
    {Key? key, 
    required this.id, 
    required this.name, 
    required this.age, 
    required this.profession
    }) 
    : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateUserState();
}

class _UpdateUserState extends State<UpdateUser> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}