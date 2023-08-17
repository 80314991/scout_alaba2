import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Attendance extends StatefulWidget {
  const Attendance({Key? key}) : super(key: key);

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("Attendance");
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
        child:Scaffold(
            body:FutureBuilder(
                future: notesref.where("bool" , isEqualTo: true).get() ,
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
                })
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
                  title: Text('${notes['name']}'),
                  subtitle: Text('Arrived in ${notes['time']} at ${notes['date']}'),
                )),
          ],
        ),
      ),
    );
  }
}
