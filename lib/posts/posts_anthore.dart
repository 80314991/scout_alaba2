import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../menu/anthor.dart';
import '../image/viewimage.dart';

class Posts_anthor extends StatefulWidget {
  var rahet , role , name;
  Posts_anthor({Key? key, required this.rahet , required this.role,required this.name}) : super(key: key);

  @override
  State<Posts_anthor> createState() => _Posts_anthor(rahet , role ,name);
}

class _Posts_anthor extends State<Posts_anthor> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("posts");

  var rahet , role , name;
  _Posts_anthor(this.rahet, this.role , this.name);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('View Posts For Secretariat'),
        ),
        drawer: Navigatedrawer_leader_anthor(rahet: rahet, role: role, name: name,),
        body:Container(
          child: FutureBuilder(
              future: notesref.where("userid" , isEqualTo: FirebaseAuth.instance.currentUser?.uid).get(),
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

