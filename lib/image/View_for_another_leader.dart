import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:scout/image/viewpage.dart';
import 'package:scout/menu/anthor.dart';
import 'viewimage.dart';

class View_for_another_leader extends StatefulWidget {
  var rahet , role , name;
  View_for_another_leader({Key? key, required this.rahet , required this.role , required this.name}) : super(key: key);

  @override
  State<View_for_another_leader> createState() => _View_for_another_leaderState(rahet , role, name);
}

class _View_for_another_leaderState extends State<View_for_another_leader> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("notes");

  var rahet , role , name;
  _View_for_another_leaderState(this.rahet, this.role , this.name);
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false, child: Scaffold(
        appBar: AppBar(title: const Text("View Image"),
        ),
        drawer: Navigatedrawer_leader_anthor(rahet: rahet, role: role, name: name,),
        body:Container(
          child: FutureBuilder(
              future: notesref.where("role" , isEqualTo: "secretariat").get() ,
              builder: (context , snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data?.docs.length,
                      itemBuilder: (context , i){
                        return Dismissible(
                            onDismissed: (direction) async{
                              await notesref.doc(snapshot.data?.docs[i].id).delete();
                              await FirebaseStorage.instance.
                              refFromURL(snapshot.data?.docs[i]['imageurl']).delete().then((value) => print('delete'));
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
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context){
          return ViewPage(notes: notes);
        }));
      },
      child: Card(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Image.network('${notes['imageurl']}',
                fit: BoxFit.fill,
                height: 80,),
            ),
            Expanded(
                flex: 3,
                child: ListTile(
                  title: Text('${notes['title']}'),
                  subtitle: Text('${notes['note']}\n ${notes['time']} , ${notes['date']}'),
                  trailing: IconButton(
                    onPressed: () async {
                      var par = "${notes['imageurl']}";
                      await GallerySaver.saveImage(par , toDcim: true);
                    },
                    icon: const Icon(Icons.download),
                  ),
                ))
          ],
        ),
      ),
    );
  }}

