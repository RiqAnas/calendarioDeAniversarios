import 'package:aniversariodois/core/models/note.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Notegridtile extends StatelessWidget {
  final Note note;

  Notegridtile({required this.note});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            width: double.maxFinite,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      note.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Text(
          note.title,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          DateFormat('dd/MM/yyyy hh:mm').format(note.createdAt),
          style: TextStyle(fontSize: 10, color: Colors.grey),
        ),
      ],
    );
  }
}
