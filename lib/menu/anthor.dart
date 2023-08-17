import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:scout/image/image_anthore.dart';
import 'package:scout/posts/posts_anthore.dart';
import '../Login.dart';
import '../image/View_for_another_leader.dart';
import '../posts/another_leader_posts.dart';
import '../upload/anuthor_image.dart';
import '../upload/anuthor_post.dart';

class Navigatedrawer_leader_anthor extends StatefulWidget {
  var rahet , role , name;
   Navigatedrawer_leader_anthor({Key? key ,required this.name,required this.role,required this.rahet}) : super(key: key);

  @override
  State<Navigatedrawer_leader_anthor> createState() => _Navigatedrawer_leader_anthorState(rahet , role , name);
}

class _Navigatedrawer_leader_anthorState extends State<Navigatedrawer_leader_anthor> {
  var rahet , role , name;
  _Navigatedrawer_leader_anthorState(this.rahet, this.role, this.name);
  var _latitude,_longitude;

  signout()
  async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) =>
      Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              buildHeader(context),
              buildMenuItem(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) =>
      Container(
        color: Colors.blue[300],
        padding: EdgeInsets.only(top: MediaQuery
            .of(context)
            .padding
            .top),
      );

  Widget buildMenuItem(BuildContext context){
    CollectionReference noteref =FirebaseFirestore.instance.collection("Attendance");
    AlertDialog alert = AlertDialog(
      content: const Text('Attendance is Recorded'),
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
    AlertDialog alert2 = AlertDialog(
      content: const Text('Sorry you is not in location .. Please Try Again '),
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
    return Container(
      padding: const EdgeInsets.all(24),
      child: Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.post_add_rounded),
            title: const Text('Add Post'),
            onTap: () {
              Navigator.of(context).
              push(MaterialPageRoute(
                  builder: (context) => Anuthor_post(rahet: rahet, role: role, name: name,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.upload_file),
            title: const Text('Add Image'),
            onTap: () {
              Navigator.of(context).
              push(MaterialPageRoute(
                  builder: (context) => Anuthor_Upload_Image(rahet: rahet, role: role, name: name,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('View Post'),
            onTap: () {
              Navigator.of(context).
              push(MaterialPageRoute(builder: (context) =>
                  View_for_another_leader_posts(rahet: rahet, role: role, name: name,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.image),
            title: const Text('View Image'),
            onTap: () {
              Navigator.of(context).
              push(MaterialPageRoute(builder: (context) =>
                  View_for_another_leader(rahet: rahet, role: role,name: name,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.my_library_add_outlined),
            title: const Text('View My Image'),
            onTap: () {
              Navigator.of(context).
              push(MaterialPageRoute(builder: (context) =>
                  Image_anthoe(rahet: rahet, role: role, name: name,)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.portrait_sharp),
            title: const Text('View My Posts'),
            onTap: () {
              Navigator.of(context).
              push(MaterialPageRoute(builder: (context) =>
                  Posts_anthor(rahet: rahet, role: role, name: name,)));
            },
          )
          ,const Divider(color: Colors.black,),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Record Attendance'),
            onTap: () async {
              var position = await Geolocator.getCurrentPosition(desiredAccuracy : LocationAccuracy.high);
              var lastposition = await Geolocator.getLastKnownPosition();
              print(lastposition);
              setState(() {
                _latitude = position.latitude;
                _longitude = position.longitude;
              });
              if(_latitude>=28.086780 && _latitude<=28.086950 &&
                  _longitude>=30.763090&&_longitude<=30.762650 )
              {
                await noteref.add({
                  "name" : '$name',
                  "role" :'$role',
                  "rahet": '$rahet',
                  "bool" : true,
                  "time" : TimeOfDay.now().format(context),
                  "date" : DateFormat.yMMMd().format(DateTime.now())
                }).then((value) => {showDialog(
                    context: context,
                    builder: (context) {
                      return alert;
                    })
                });
              }
              else{
                showDialog(
                    context: context,
                    builder: (context) {
                      return alert2;
                    });
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.output_outlined),
            title: const Text('Sign Out'),
            onTap: () {
              signout();
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
            },
          ),
        ],
      ),
    );
  }
}
