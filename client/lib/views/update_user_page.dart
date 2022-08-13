import 'dart:ffi';

import 'package:flutter/material.dart';

class UpdateUser extends StatefulWidget {
  final String id;
  final String name;
  final int age;
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Update ${widget.name}",
          style: const TextStyle(
            color: Colors.grey, fontSize: 19, fontWeight: FontWeight.bold
          ),
        )
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          margin: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 6.0,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                offset: const Offset(0,10.0),
                blurRadius: 30.0,
              ),
            ],
          ),
          child: Center(child: Text(widget.id))
        )
      ),
    );
  }
}