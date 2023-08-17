import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scout/vector/Vectore_view.dart';
import 'package:scout/vector/vectore.dart';
import 'package:scout/vector/public%20image.dart';
import 'package:scout/vector/public%20post.dart';

class Upload_Public extends StatefulWidget {
  const Upload_Public({Key? key}) : super(key: key);

  @override
  State<Upload_Public> createState() => _Upload_PublicState();
}

class _Upload_PublicState extends State<Upload_Public> {
  int currentindex =0;
  List<Widget> screens =[
     Public_Image(),
    Public_Post()
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () async => false,
        child:Scaffold(
          appBar: AppBar(title: const Text('Scouts News'),
              automaticallyImplyLeading: false,
              leading: GestureDetector(
                onTap: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Vectore_View())
                  );
                },
                child: const Icon(
                  Icons.arrow_back_sharp,
                ),
              ),),
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
            ],),
        ));
  }
}
