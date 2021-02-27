import 'package:flutter/material.dart';

class EventList extends StatefulWidget {
  @override
  _EventListState createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 12,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0),
            child: ListTile(
              title: Text('List Item: $index'),
              subtitle: Text('event active'),
              onTap: (){
                print("Item $index Clicked!");
              },
            ),
          );
        },
      ),
    );
  }
}
