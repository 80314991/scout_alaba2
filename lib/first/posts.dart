import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Posts extends StatefulWidget {
  const Posts({Key? key}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("public_post");
  List users = [];
  getdata()
  async {
    var res = await notesref.get();
    for (var element in res.docs) {
      setState(() {
        users.add(element.data());
      });
    }
  }

  @override
  void initState()
  {
    getdata();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(itemCount: users.length ,
          itemBuilder:(context , i){
            return ListTile(
              title: Text(" ${users[i]['title']}"),
              subtitle: Text("${users[i]['note']}\n${users[i]['date']}"),
            );
          },
        )
    );
  }
}
