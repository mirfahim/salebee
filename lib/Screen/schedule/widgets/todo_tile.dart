import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatefulWidget {
  final String title;
  final String description;

  const TodoTile({Key? key, required this.title, required this.description}) : super(key: key);

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, left: 20, right: 20),
      height: 200,
      width: 250,
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(widget.title, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14), textAlign: TextAlign.center,),
            const SizedBox(height: 14,),
            Text(widget.description, style: const TextStyle(color: Colors.black, fontSize: 12,), textAlign: TextAlign.center,),
            const SizedBox(height: 12,),
          ],
        ),
      ),
    );
  }

}