import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 23.0, left: 10.0, right: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.0, 10.0),
                    color: Colors.grey.shade300,
                    blurRadius: 30.0,
                  )
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: InkWell(
                // ignore: avoid_unnecessary_containers
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children:[
                      Row(
                        children: const [
                          Text('Hello'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}