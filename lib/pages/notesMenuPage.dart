import 'package:aniversariodois/components/notesGrid.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/routes.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
      appBar: AppBar(
        title: Text(
          widget.persona != null ? "Suas notas" : "Notas de ${person!.nome}",
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text(
                      "Deseja realmente deletar as notas dessa pessoa?",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    content: const Text(
                      'Todas as notas referente a essa pessoa serão excluídas permanentemente',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancelar"),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Provider.of<Noteservice>(
                            context,
                            listen: false,
                          ).deleteAllNotes(person!.id);
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Excluir",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Notesgrid(person: person!),
      ),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          minimumSize: Size(50, 50),
          backgroundColor: const Color.fromARGB(255, 248, 162, 191),
          foregroundColor: Colors.black,
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
