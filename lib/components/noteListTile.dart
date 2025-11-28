import 'package:aniversariodois/core/models/note.dart';
import 'package:flutter/material.dart';

class Notelisttile extends StatelessWidget {
  final Note note;

  Notelisttile({required this.note});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Column(
              children: [
                Text(note.title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(note.description, style: TextStyle(color: Colors.grey)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
