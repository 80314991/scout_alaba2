import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:scout/menu/menu_leader.dart';
class Upload_Image_leader extends StatefulWidget {
  var rahet , role ,name;
  Upload_Image_leader({Key? key,required this.rahet ,required this.role , required this.name}) : super(key: key);

  @override
  State<Upload_Image_leader> createState() => _Upload_Image_leaderState( rahet , role , name);
}

class _Upload_Image_leaderState extends State<Upload_Image_leader> {
  CollectionReference noteref =FirebaseFirestore.instance.collection("notes");
late Reference ref;
var time=  TimeOfDay.now();
var date =DateTime.now();
var title ,note ,imageurl;
GlobalKey<FormState> formstate = GlobalKey();
var rahet , role , name;
  _Upload_Image_leaderState(this.rahet , this.role , this.name);
  late File file ;


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
    if(file == null){
      return showDialog(
          context: context,
          builder: (context) {
            return alert;
          });
    }
    else{
      var formdata = formstate.currentState;
      if(formdata!.validate()){
        formdata.save();
        print('done');
        await ref.putFile(file);
        imageurl = await ref.getDownloadURL();
        await noteref.add({
          "title" : title,
          "note" : note,
          "imageurl": imageurl,
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
  }
  return Scaffold(
    appBar: AppBar(title: const Text('Upload Image'),),
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
                    return null;
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
                    return null;
                  },
                  onSaved: (val){
                    note = val;
                  },
                  maxLength: 200,
                  minLines: 1,
                  maxLines: 3,
                  decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Title Note",
                      prefixIcon: Icon(Icons.note)),
                ),
                ElevatedButton(onPressed: () { showbottomsheet(context);},
                  child: const Text("Add Image For Note"),),
                ElevatedButton(onPressed: () async {
                  await addnode();
                  },
                  child: const Text("upload"),)
              ],))
      ],
    ),
  );
}

showbottomsheet(context)
{
  return showModalBottomSheet(
      context : context,
      builder : (context){
        return Container(
          padding: const EdgeInsets.all(20),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(" Please Choose Image",
                style: TextStyle(fontSize: 25 ,
                    fontWeight: FontWeight.bold),),
              InkWell(
                onTap: ()async{
                  var picker = await ImagePicker().getImage(source: ImageSource.gallery);
                  if(picker != null){
                    file = File(picker.path);
                    var rand = Random().nextInt(1000000000);
                    var nameimage ="$rand${basename(picker.path)}";
                    ref = FirebaseStorage.instance.ref("$rahet").child(nameimage);
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    children: [
                      Icon(Icons.photo_outlined,
                        size: 30,),
                      SizedBox(width: 20,),
                      Text("From Gallery",
                        style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: ()async{
                  var picker = await ImagePicker().getImage(source: ImageSource.camera);
                  if(picker != null){
                    file = File(picker.path);
                    var rand = Random().nextInt(1000000000);
                    var nameimage ="$rand${basename(picker.path)}";
                    ref = FirebaseStorage.instance.ref("$rahet").child(nameimage);
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: const Row(
                    children: [
                      Icon(Icons.camera,
                        size: 30,),
                      SizedBox(width: 20,),
                      Text("From Camera",
                        style: TextStyle(fontSize: 20),)
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }
  );
}
}
