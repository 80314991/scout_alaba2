import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Absence extends StatefulWidget {
  const Absence({Key? key}) : super(key: key);

  @override
  State<Absence> createState() => _AbsenceState();
}

class _AbsenceState extends State<Absence> {
  CollectionReference noteref =FirebaseFirestore.instance.collection("time");
  GlobalKey<FormState> formstate = GlobalKey();
  var time=  TimeOfDay.now();
  var date =DateTime.now();
  addnode()
  async {
        print('done');
        await noteref.add({
          "bool" : true,
          "time" : time.format(context),
          "date" : DateFormat.yMMMd().format(date)
        });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(
      child: ElevatedButton(onPressed: () async {
        print(time);
        print(time.format(context));
        print(DateFormat.yMMMd().format(date));
        await addnode();
      },
        child: const Text("upload"),),
    ),
    );
  }
}
