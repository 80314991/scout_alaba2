import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Public_Post extends StatefulWidget {
  Public_Post({Key? key}) : super(key: key);

  @override
  State<Public_Post> createState() => _Public_PostState();
}

class _Public_PostState extends State<Public_Post> {
  CollectionReference noteref =FirebaseFirestore.instance.collection("public_post");
  late Reference ref;
  var title ,note;
  GlobalKey<FormState> formstate = GlobalKey();
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
          "bool" : true,
          "date": DateFormat.yMMMd().format(DateTime.now()),
        }).then((value) => {showDialog(
            context: context,
            builder: (context) {
              return alert;
            })
        });
      }
    }
    return Scaffold(
      body: Column(
        children: [
          Form(
              key: formstate,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val){
                      if(val!.length> 20)
                      {
                        return "Node lesser than 20 letter";
                      }
                      if(val!.length < 2)
                      {
                        return "Node biger than 2 letter";
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
                      if(val!.length> 1000)
                      {
                        return "Node lesser than 1000 letter";
                      }
                      if(val!.length < 5)
                      {
                        return "Node biger than 5 letter";
                      }
                    },
                    onSaved: (val){
                      note = val;
                    },
                    maxLength: 1000,
                    minLines: 1,
                    maxLines: 10,
                    decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        labelText: "Note",
                        prefixIcon: Icon(Icons.note)),
                  ),
                  ElevatedButton(onPressed: () async {
                    await addnode();
                  },
                    child: const Text("upload"),)
                ],))
        ],
      ),
    );
  }
}
