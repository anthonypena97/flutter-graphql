import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final dynamic user;
  const DetailsPage({
    Key? key,
    this.user,
    }) : super(key: key);

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  List _hobbies = [];
  List _posts = [];
  
  bool _isHobbies = false;
  bool _isPosts = false;
  
  void _toggleHobbiesBtn(){
    setState((){
      _isHobbies = true;
      _isPosts = false;
      
    });
  }
  
  void _togglePostsBtn(){
    setState((){
      _isPosts = true;
      _isHobbies = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          widget.user["name"],
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 19.0,
            fontWeight: FontWeight.bold
          )
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            fit: FlexFit.loose,
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 10),
                    color: Colors.grey.shade300,
                    blurRadius: 30,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${widget.user["name"].toUpperCase() ?? "N/A"}",
                        style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 8.0,
                      top: 8.0
                      ),
                    child: Text(
                      "Occupation: ${widget.user["profession"]}"
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Age: ${widget.user["age"]}"
                    )
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TextButton(
                  onPressed: (){
                    setState((){
                    _hobbies = widget.user["hobbies"];
                    });
                    _toggleHobbiesBtn();
                  },
                  style: buildButtonStyle(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 12
                      ),
                    child: Text(
                      "Hobbies",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      )
                      ),
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.loose,
                child: TextButton(
                  onPressed: (){
                    setState((){
                    _posts = widget.user["posts"];
                    });
                    _togglePostsBtn();
                  },
                  style: buildButtonStyle(),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 36,
                      vertical: 12
                      ),
                    child: Text(
                      "Posts",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      )
                      ),
                  ),
                ),
              ),
            ],
          ),
          Visibility(
            visible: true,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              child: ListView.builder(
                itemCount: _isHobbies ? _hobbies.length : _posts.length,
                itemBuilder: (context, index) {
                  var data = _isHobbies ? _hobbies[index] : _posts[index];
                  return Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          bottom: 30,
                          left: 10,
                          right: 10,
                          top: 22,
                         ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              offset: const Offset(0,10),
                              color: Colors.grey.shade300,
                              blurRadius: 30,
                            )
                          ]
                        ),
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    _isHobbies 
                                    ? "Hobby: ${data["title"]}" 
                                    : "${data["comment"]}",
                                    ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                              ),
                              child: Text(_isHobbies ? "Description: ${data["description"]}" : ""),
                            ),
                          ],
                        )
                      ),
                    ],
                  );
                }
              ),
            ),
          ),
        ],
      )
    );
  }

  ButtonStyle buildButtonStyle() {
    return ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.greenAccent),
                );
  }
}