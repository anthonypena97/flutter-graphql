import 'package:flutter/material.dart';
import 'package:flutter_graphql/views/update_user_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({Key? key}) : super(key: key);
  
  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List users = [];
  final String _query = """
  query{
    users{
      name
      profession
      age
    }
  }
  """;
  
  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(document: gql(_query),fetchPolicy: FetchPolicy.noCache),
      builder: (result, {fetchMore, refetch}) {
        if(result.isLoading){
          return const CircularProgressIndicator();
        }
        users = result.data!["users"];
        
        return (users.isNotEmpty) ? ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
          final user = users[index];
          
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${user["name"]}',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.greenAccent,
                                  ),
                                  onTap: () async {
                                    final route = MaterialPageRoute(builder: (context) {
                                      return UpdateUser(
                                        id: user["id"],
                                        name: user["name"],
                                        age: user["age"],
                                        profession: user["profession"]
                                      );
                                    },
                                   );
                                   await Navigator.push(context, route);
                                  },
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.redAccent,
                                    ),
                                    onTap: () async {
                                        debugPrint('delete');
                                    },
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                'Occupation: ${user["profession"] ?? 'N/A'}'
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                              child: Text(
                                'Age: ${user["age"] ?? 'N/A'}'
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ) : const Center(
          child: Text("No users found"),
        );
        
      },
    );
  }
}