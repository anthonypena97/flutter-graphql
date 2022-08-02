import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({Key? key}) : super(key: key);

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final _formKey = GlobalKey<FormState>();
  
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _professionController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add a User',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 10),
                  color: Colors.grey.shade300,
                  blurRadius: 30),
            ],
          ),
          child: Column(
            children: [
              Mutation(
                options: MutationOptions(
                  document: gql(insertUser()),
                  fetchPolicy: FetchPolicy.noCache,
                  onError:(error) {
                    debugPrint(error.toString());
                  },
                  onCompleted: (data) {
                    debugPrint(data.toString());
                  },
                ),
                builder: (runMutation, result) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      children:[
                        const SizedBox(height: 12.0),
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Name",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value){
                              if(value!.isEmpty){
                                return "Name cannot be empty";
                              }else{
                                return null;
                              }
                            },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          controller: _professionController,
                          decoration: const InputDecoration(
                            labelText: "Profession",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value){
                              if(value!.isEmpty){
                                return "Profession cannot be empty";
                              }else{
                                return null;
                              }
                            },
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 12.0),
                        TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(
                            labelText: "Age",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          validator: (value){
                              if(value!.isEmpty){
                                return "Age cannot be empty";
                              }else{
                                return null;
                              }
                            },
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 12.0),
                        TextButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                          ),
                          onPressed: (){
                            if(_formKey.currentState!.validate()){
                              runMutation({
                                "name": _nameController.text.trim(),
                                "age": int.parse(_ageController.text.trim()),
                                "profession": _professionController.text.trim(),
                              });
                            }
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 12.0 ),
                            child: Text('Save'),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String insertUser() {
  return """
  mutation CreateUser(\$name: String!, \$age: Int!, \$profession: String!){
    CreateUser(name: \$name, age: \$age, profession: \$profession){
      id
      name
    }
}
  """;
}
