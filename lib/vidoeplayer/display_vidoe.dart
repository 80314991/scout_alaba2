import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'VideoplayerWidget.dart';

class Display_video extends StatefulWidget {
  final String url;
  const Display_video({Key? key, required this.url}) : super(key: key);

  @override
  State<Display_video> createState() => _Display_videoState(url);
}

class _Display_videoState extends State<Display_video> {
  late VideoPlayerController controller;
  late String url;
  _Display_videoState(this.url);

  @override
  void initState()
  {

    print(url);
    super.initState();
    controller = VideoPlayerController.
    network(url)
      ..addListener(()=> setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) => controller.play());
  }

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final isMute = controller.value.volume == 0 ;
    return Scaffold(
      backgroundColor: Colors.black26,
     body:  ListView(
       children: [
         Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             VideoplayerWidget(controller: controller,),
             const SizedBox(height: 32,),
             if(controller != null && controller.value.isInitialized)
               CircleAvatar(radius: 30,
                 backgroundColor: Colors.red,
                 child: IconButton(onPressed: (){
                   controller.setVolume(isMute ? 1: 0);
                 }, icon: Icon(
                   isMute ? Icons.volume_mute :  Icons.volume_up,
                   color: Colors.white,
                 )),)
           ],
         )
       ],
     ),
     );
  }
}