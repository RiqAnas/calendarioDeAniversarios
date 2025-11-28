import 'package:aniversariodois/components/notesGrid.dart';
import 'package:aniversariodois/core/models/person.dart';

import 'package:flutter/material.dart';

class Notesmenupage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Person person = ModalRoute.of(context)!.settings.arguments as Person;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Notas de ${person.nome}"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Notesgrid(person: person),
      ),
    );
  }
}
