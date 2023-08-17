import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scout/Login.dart';
import 'package:scout/Social/upload_social.dart';
import 'package:scout/vector/V_Image_P.dart';
import 'package:scout/vector/V_Posts_P.dart';

class social_View extends StatefulWidget {
  const social_View({Key? key}) : super(key: key);

  @override
  State<social_View> createState() => _social_View();
}

class _social_View extends State<social_View> {
  int currentindex =0;
  List<Widget> screens =[
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
            push(MaterialPageRoute(builder: (context)=> const Up_Public()));  },
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
              BottomNavigationBarItem(icon: Icon(Icons.image_not_supported_outlined) , label:"Photos"),
              BottomNavigationBarItem(icon: Icon(Icons.local_post_office_outlined) , label:"posts"),

            ],),
        ));
  }
}
