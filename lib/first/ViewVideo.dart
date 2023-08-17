import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../Login.dart';
import '../../vidoeplayer/display_vidoe.dart';

class ViewVideo extends StatefulWidget {
  const ViewVideo({Key? key ,}) : super(key: key);

  @override
  State<ViewVideo> createState() => _ViewVideoState();
}

class _ViewVideoState extends State<ViewVideo> {
  late String url;
  CollectionReference notesref = FirebaseFirestore.instance.collection("public_v");
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
    return WillPopScope(onWillPop: () async => false,
      child:
      Scaffold(
          body:ListView.builder(itemCount: users.length ,
            itemBuilder:(context , i){
              return InkWell(
                onTap: (){
                  url = users[i]['URL'];
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) =>  Display_video(url: url,)));
                },
                child: Card(
                  child: Row(
                    children: [
                      Expanded(
                          flex: 3,
                          child: ListTile(
                            title: Text("${users[i]['title']}"),
                            subtitle: Text(" ${users[i]['note']}"),
                          )
                      )
                    ],
                  ),
                ),
              );
            },
          )
      ),
    );
  }
}