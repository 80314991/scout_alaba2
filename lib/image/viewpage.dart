import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatefulWidget {
  final notes;
   const ViewPage({Key? key , required this.notes}) : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState(notes);
}

class _ViewPageState extends State<ViewPage> {
  final notes;
  _ViewPageState(this.notes);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View Image'),
      ),
      body:
      Column(
        children: [
          Container( child: Image.network('${notes['imageurl']}',
            width: double.infinity , height: 300,fit: BoxFit.fill,),),
          Padding(padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('${notes['title']}', style: Theme.of(context).textTheme.headlineLarge,),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Text('${notes['note']}\n ${notes['time']} , ${notes['date']}', style: Theme.of(context).textTheme.bodyMedium,),
                )
              ],
            ),)
        ],
      )
    );
  }
}
