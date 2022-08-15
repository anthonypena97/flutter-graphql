import 'package:flutter/material.dart';
import 'package:flutter_graphql/views/update_user_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'home_screen.dart';

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
      id
      name
      profession
      age
      posts{
        id
        comment
        user{
          id
        }
      }
      hobbies{
        id
        title
        user{
          id
        }
      }
    }
  }
  """;
  
  List hobbiesIDsToDelete = [];
  List postsIDsToDelete = [];
  
  bool _isRemoveHobbies = false;
  bool _isRemovePosts = false;
  
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
                                  child: Mutation(
                                    options: MutationOptions(
                                      document: gql(removeUser()),
                                      onCompleted: (data){
                                        
                                      },
                                    ),
                                    builder: (runMutation, result){
                                      return  InkWell(
                                        child: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.redAccent,
                                       ),
                                        onTap: () async {
                                          hobbiesIDsToDelete.clear();
                                          postsIDsToDelete.clear();
                                          for (var i = 0; i < user["hobbies"].length; i++){
                                            hobbiesIDsToDelete.add(user["hobbies"][i]["id"]);
                                          }
                                          for (var i = 0; i < user["posts"].length; i++){
                                            postsIDsToDelete.add(user["hobbies"][i]["id"]);
                                          }
                                          // debugPrint("+++${user["name"]} Hobbies to delete ${hobbiesIDsToDelete.toString()}");
                                          // debugPrint("+++${user["name"]} Posts to delete ${postsIDsToDelete.toString()}");
                                          
                                          setState((){
                                            _isRemoveHobbies = true;
                                            _isRemovePosts = true;
                                          });
                                          
                                          runMutation({"id": user["id"]});
                                          Navigator.pushAndRemoveUntil(
                                            context, 
                                            MaterialPageRoute(builder: (context){
                                              return const HomeScreen();
                                            },
                                          ), (route) => false,);
                                        },
                                      );
                                    },
                                  ),
                                ),
                                _isRemoveHobbies
                                ? Mutation(
                                  options: MutationOptions(
                                    document: gql(removeHobbies()),
                                    onCompleted: (data) {},
                                  ),
                                  builder: (runMutation, result) {
                                    if(hobbiesIDsToDelete.isNotEmpty){
                                      debugPrint("Calling deleteHobbies");
                                      runMutation({
                                        'ids': hobbiesIDsToDelete
                                      });
                                    }
                                    return Container();
                                  },
                                ) : Container(),
                                _isRemovePosts
                                ? Mutation(
                                  options: MutationOptions(
                                    document: gql(removePosts()),
                                    onCompleted: (data){},
                                  ),
                                  builder: (runMutation, result){
                                      if(postsIDsToDelete.isNotEmpty){
                                        runMutation({
                                          "ids": postsIDsToDelete
                                        });
                                      }
                                      return Container();
                                    },
                                ) : Container(),
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
  
  String removeUser() {
    return """
    mutation RemoveUser(\$id: String!){
      RemoveUser(id: \$id){
        name
      }
    }
    """;
  }
  
  String removeHobbies() {
    return """
    mutation RemoveHobbies(\$ids: [String]){
      RemoveHobbies(ids: \$ids){
        
      }
    }
    """;
  }
  
  String removePosts() {
    return """
    mutation RemovePosts(\$ids: [String]){
      RemovePosts(ids: \$ids){
        
      }
    }
    """;
  }
}