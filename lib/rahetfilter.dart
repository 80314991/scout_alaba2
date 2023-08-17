import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scout/Social/social_view.dart';
import 'package:scout/image/View_for_another_leader.dart';
import 'package:scout/vector/Vectore_view.dart';
import 'package:scout/image/viewimage.dart';
import 'image/view_for_leader.dart';

class rahetfilter extends StatelessWidget {
  const rahetfilter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var rahet , role , name;
    final user = FirebaseAuth.instance.currentUser;
    CollectionReference users = FirebaseFirestore.instance.collection('user');
            return Scaffold(
              body: FutureBuilder<DocumentSnapshot>(
                future: users.doc(user?.uid).get(),
                builder:
                    (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Something went wrong");
                  }
                  if (snapshot.hasData && !snapshot.data!.exists) {
                    return const Text("Document does not exist");
                  }
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                    role = data['role'];
                    rahet = data['rahet'];
                    name = data['name'];
                    if(role == 'vectore')
                    {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Vectore_View()));
                      });}
                    else if(role == 'leader_of_secertaria')
                      {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => View_for_another_leader(rahet: rahet, role: role, name: name,)));
                      });}
                    else if(role == 'social')
                    {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const social_View()));
                      });}
                    else if(role == 'leader')
                    {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => View_for_leader(rahet: rahet, role: role, name: name,)));
                      });}
                    else{{
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => ViewImage(rahet: rahet, role: role, name: name,)));
                        });
                      }
                    }
                  }

                  return const Text("loading");
                },
              ),
            );
          }
  }
