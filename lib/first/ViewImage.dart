import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scout/image/viewpage.dart';


class ViewImagePublic extends StatefulWidget {
  const ViewImagePublic({Key? key }) : super(key: key);

  @override
  State<ViewImagePublic> createState() => _ViewImagePublicState();
}

class _ViewImagePublicState extends State<ViewImagePublic> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("public");
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
        body: ListView.builder(
                    itemCount:users.length ,
                    itemBuilder: (context , i){
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            return ViewPage(notes: users[i]);
                          }));
                        },
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Image.network('${users[i]['imageurl']}',
                                  fit: BoxFit.fill,
                                  height: 80,),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: ListTile(
                                    title: Text('${users[i]['title']}'),
                                    subtitle: Text('${users[i]['note']}\n${users[i]['date']}'),
                                  ))
                            ],
                          ),
                        ),
                      );
                    })
    );
  }
}
