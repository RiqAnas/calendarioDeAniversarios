import 'package:aniversariodois/components/foldersList.dart';
import 'package:aniversariodois/components/notesGrid.dart';
import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/models/transitionArg.dart';
import 'package:aniversariodois/core/utils/colorsMap.dart';
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
  Folder? folder;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final obj = ModalRoute.of(context)!.settings.arguments;
    if (obj == null) {
      if (widget.persona != null) {
        person = widget.persona;
      }
    } else {
      final arg = obj as Transitionarg;
      if (arg.folder == null) {
        person = arg.person;
      } else {
        person = arg.person;
        folder = arg.folder;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: widget.persona == null
          ? AppBar(
              title: folder == null
                  ? Text("Notas de ${person!.nome}")
                  : Text("Notas em ${folder!.name}"),
              centerTitle: true,
              shape: folder == null
                  ? null
                  : BorderDirectional(
                      bottom: BorderSide(
                        width: 4,
                        color: Colorsmap.getColor(folder!.color),
                      ),
                    ),
            )
          : null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      if (folder == null) {
                        Navigator.of(context).pushNamed(
                          Routes.FOLDERFORM,
                          arguments: Transitionarg(person: person!),
                        );
                      } else {
                        Navigator.of(context).pushNamed(
                          Routes.FOLDERFORM,
                          arguments: Transitionarg(
                            person: person!,
                            folder: folder,
                          ),
                        );
                      }
                    },
                    icon: Icon(Icons.add, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Folderslist(person: person!, folders: folder),
              Notesgrid(person: person!, folder: folder),
            ],
          ),
        ),
      ),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          minimumSize: Size(50, 50),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Theme.of(context).colorScheme.surface,
        ),
        onPressed: () {
          if (folder == null) {
            Navigator.of(context).pushNamed(
              Routes.NOTEFORM,
              arguments: Transitionarg(person: person!),
            );
          } else {
            Navigator.of(context).pushNamed(
              Routes.NOTEFORM,
              arguments: Transitionarg(person: person!, folder: folder),
            );
          }
        },
        label: Icon(Icons.add_outlined),
      ),
    );
  }
}
