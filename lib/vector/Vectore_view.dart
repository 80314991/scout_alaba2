import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scout/Login.dart';
import 'package:scout/vector/V_Image_P.dart';
import 'package:scout/vector/V_Posts_P.dart';
import 'package:scout/vector/vectore.dart';
import 'package:scout/vector/vectore_posts.dart';
import 'Upload_public.dart';
import 'attendance.dart';

class Vectore_View extends StatefulWidget {
  const Vectore_View({Key? key}) : super(key: key);

  @override
  State<Vectore_View> createState() => _Vectore_ViewState();
}

class _Vectore_ViewState extends State<Vectore_View> {
  int currentindex =0;
  List<Widget> screens =[
    const Vectore(),
    const Vectore_posts(),
    const Attendance(),
    const V_Image_P(),
    const V_Posts_P()
  ];
  signout()
  async {
    await FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
        child:Scaffold(
          appBar: AppBar(title: const Text('Team Reports'),
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () async {
                signout();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login())
                );
              },
              child: const Icon(
                Icons.arrow_back_sharp,
              ),
            ),),
          floatingActionButton: FloatingActionButton(
            onPressed: () {Navigator.of(context).
            push(MaterialPageRoute(builder: (context)=> const Upload_Public()));  },
            child: const Icon(Icons.add),
          ),
          body: screens[currentindex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentindex,
            onTap: (index){
              setState(() {
                currentindex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.image) , label:"Photos"),
              BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined) , label:"posts"),
              BottomNavigationBarItem(icon: Icon(Icons.person) , label:"Attendance"),
              BottomNavigationBarItem(icon: Icon(Icons.image_not_supported_outlined) , label:"Photos"),
              BottomNavigationBarItem(icon: Icon(Icons.local_post_office_outlined) , label:"posts"),

            ],),
        ));
  }
}
