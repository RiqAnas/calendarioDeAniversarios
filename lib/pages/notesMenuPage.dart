import 'package:aniversariodois/components/notesGrid.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/utils/routes.dart';

import 'package:flutter/material.dart';

class Notesmenupage extends StatefulWidget {
  final Person? persona;

  Notesmenupage({this.persona});

  @override
  State<Notesmenupage> createState() => _NotesmenupageState();
}

class _NotesmenupageState extends State<Notesmenupage> {
  Person? person;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final obj = ModalRoute.of(context)!.settings.arguments;
    if (obj == null) {
      if (widget.persona != null) {
        person = widget.persona;
      }
    } else {
      person = obj as Person;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: widget.persona == null
          ? AppBar(title: Text("Notas de ${person!.nome}"), centerTitle: true)
          : null,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Notesgrid(person: person!),
      ),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          minimumSize: Size(50, 50),
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Theme.of(context).colorScheme.surface,
        ),
        onPressed: () => Navigator.of(context).pushNamed(
          Routes.NOTEFORM,
          arguments: {'person': person, 'note': null},
        ),
        label: Icon(Icons.add_outlined),
      ),
    );
  }
}
