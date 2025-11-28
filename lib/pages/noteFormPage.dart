import 'dart:math';

import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Noteformpage extends StatefulWidget {
  @override
  State<Noteformpage> createState() => _NoteformpageState();
}

class _NoteformpageState extends State<Noteformpage> {
  TextEditingController _titleController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  DateTime? _markedAt;

  bool _isMark = false;

  @override
  Widget build(BuildContext context) {
    Person person = ModalRoute.of(context)!.settings.arguments as Person;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Nota'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              if (_titleController.text.isEmpty ||
                  _descriptionController.text.isEmpty) {
                return;
              }

              final note = Note(
                id: Random().nextDouble().toString(),
                personid: person.id,
                title: _titleController.text.trim(),
                description: _descriptionController.text,
                mark: _isMark ? 1 : 0,
                date: _isMark ? _markedAt : null,
                marked: _isMark ? 0 : null,
              );

              await Provider.of<Noteservice>(
                context,
                listen: false,
              ).insertNote(note);

              Navigator.of(context).pop();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                cursorHeight: 50,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                maxLines: null,
                maxLength: 25,
                clipBehavior: Clip.antiAlias,
                selectAllOnFocus: false,
                autofocus: false,
                decoration: InputDecoration(
                  counterText: '',
                  hint: Text(
                    'Título',
                    style: TextStyle(fontSize: 40, color: Colors.grey),
                  ),
                  border: InputBorder.none,
                ),
              ),
              TextField(
                maxLines: null,
                clipBehavior: Clip.antiAlias,
                keyboardType: TextInputType.multiline,
                controller: _descriptionController,
                style: TextStyle(fontSize: 15),
                decoration: InputDecoration(
                  counterText: '',
                  hint: Text(
                    'Descrição',
                    style: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
