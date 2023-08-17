import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scout/image/viewpage.dart';
import '../menu/menu_leader.dart';
class View_for_leader_post extends StatefulWidget {
  var rahet , role , name;
  View_for_leader_post({Key? key, required this.rahet , required this.role,required this.name}) : super(key: key);

  @override
  State<View_for_leader_post> createState() => _View_for_leader_postState(rahet , role , name);
}

class _View_for_leader_postState extends State<View_for_leader_post> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("posts");

  var rahet , role , name;
  _View_for_leader_postState(this.rahet, this.role , this.name);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, child:Scaffold(
        appBar: AppBar(title: const Text("View Post For Leader"),
        ),
        drawer: Navigatedrawer_leader(rahet: rahet, role: role, name: name,),
        body:Container(
          child: FutureBuilder(
              future: notesref.where("rahet" , isEqualTo:rahet).get() ,
              builder: (context , snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context , i){
                        return Dismissible(
                            onDismissed: (direction) async{
                              await notesref.doc(snapshot.data?.docs[i].id).delete();
                            },
                            key: UniqueKey(),
                            child: ListNotes(notes: snapshot.data?.docs[i],));
                      });
                }
                return const Center(child: CircularProgressIndicator(),);
              }),
        )
    )
    );
  }
}

class ListNotes extends StatelessWidget {
  final storageRef = FirebaseStorage.instance.ref();
  final notes;
  ListNotes({this.notes});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: ListTile(
                  title: Text('${notes['title']}'),
                  subtitle: Text('${notes['note']}\n ${notes['time']} , ${notes['date']}'),
                ))
          ],
        ),
      ),
    );
  }}
