import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'first/ViewImage.dart';
import 'first/ViewVideo.dart';
import 'first/posts.dart';
import 'main.dart';

class PublicPeople extends StatefulWidget {
  const PublicPeople({Key? key}) : super(key: key);

  @override
  State<PublicPeople> createState() => _PublicPeopleState();
}

class _PublicPeopleState extends State<PublicPeople> {
  int currentindex =0;
  List<Widget> screens =[
    const ViewImagePublic(),
    const ViewVideo(),
    const Posts()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
        child:Scaffold(
          appBar: AppBar(title: const Text('Scouts News'),
            automaticallyImplyLeading: false,),
          body: screens[currentindex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Mainpage()));
                });
              });
            },
            child: const Icon(Icons.login_outlined),
          ),
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
              BottomNavigationBarItem(icon: Icon(Icons.video_call_outlined) , label:"Videos"),
              BottomNavigationBarItem(icon: Icon(Icons.post_add_outlined) , label:"posts"),
            ],),
        ));
  }
}
