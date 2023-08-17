import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';

import '../image/viewpage.dart';

class V_Image_P extends StatefulWidget {
  const V_Image_P({Key? key}) : super(key: key);

  @override
  State<V_Image_P> createState() => _V_Image_PState();
}

class _V_Image_PState extends State<V_Image_P> {
  CollectionReference notesref = FirebaseFirestore.instance.collection("public");
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
        child:Scaffold(
            body:Container(
              child: FutureBuilder(
                  future: notesref.where("bool" , isEqualTo: true).get() ,
                  builder: (context , snapshot){
                    if(snapshot.hasData){
                      return ListView.builder(
                          itemCount: snapshot.data?.docs.length,
                          itemBuilder: (context , i){
                            return Dismissible(
                                onDismissed: (direction) async{
                                  await notesref.doc(snapshot.data?.docs[i].id).delete();
                                  await FirebaseStorage.instance.
                                  refFromURL(snapshot.data?.docs[i]['imageurl']).delete();
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
                  subtitle: Text('${notes['note']}\n${notes['date']}'),
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
  }
}
