import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:scout/menu/menu_leader.dart';

class Upload_post_leader extends StatefulWidget {
  var rahet , role ,name;
  Upload_post_leader({Key? key, required this.rahet, required this.role , required this.name}) : super(key: key);

  @override
  State<Upload_post_leader> createState() => _Upload_post_leaderState(rahet , role , name);
}

class _Upload_post_leaderState extends State<Upload_post_leader> {
    CollectionReference noteref =FirebaseFirestore.instance.collection("posts");
    late Reference ref;
    var time=  TimeOfDay.now();
    var date =DateTime.now();
    var title ,note ;
    GlobalKey<FormState> formstate = GlobalKey();

    var rahet , role , name;
    _Upload_post_leaderState(this.rahet, this.role , this.name);

    @override
    Widget build(BuildContext context) {
      AlertDialog alert = AlertDialog(
        content: const Text('Uploading has been done'),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Ok",
                style: TextStyle(fontSize: 20),
              ))
        ],
      );
      addnode()
      async {
        var formdata = formstate.currentState;
        if(formdata!.validate()){
          formdata.save();
          await noteref.add({
            "title" : title,
            "note" : note,
            "userid" : FirebaseAuth.instance.currentUser?.uid,
            "role" :'$role',
            "rahet": '$rahet',
            "bool" : true,
            "time" : time.format(context),
            "date" : DateFormat.yMMMd().format(date)
          }).then((value) => {showDialog(
              context: context,
              builder: (context) {
                return alert;
              })
          });
        }
      }
      return Scaffold(
        appBar: AppBar(title: Text('Upload Post'),),
        drawer: Navigatedrawer_leader(rahet: rahet, role: role, name: name,),
        body: Column(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val){
                        if(val!.isEmpty)
                        {
                          return "Node Must Not Be Empty";
                        }
                      },

                      onSaved: (val){
                        title = val;
                      },
                      maxLength: 30,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Title Note",
                          prefixIcon: Icon(Icons.note)),
                    ),
                    TextFormField(
                      validator: (val){
                        if(val!.isEmpty)
                        {
                          return "Node Must Not Be Empty";
                        }
                      },
                      onSaved: (val){
                        note = val;
                      },
                      maxLength: 1000,
                      minLines: 1,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: "Note",
                          prefixIcon: Icon(Icons.note)),
                    ),
                    ElevatedButton(onPressed: () async {
                      await addnode();
                      },
                      child: const Text("Upload"),)
                  ],))
          ],
        ),
      );
    }

  }
