import 'dart:math';

import 'package:aniversariodois/components/folderDialog.dart';
import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/models/transitionArg.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/colorsMap.dart';
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
  bool _favorite = false;

  Person? _person;
  Note? _note;
  Folder? _folder;

  bool _isMark = false;
  bool _initialized = false;
  bool _isEdit = false;

  void selectedFolder(Folder? folder) {
    setState(() {
      _folder = folder;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final arg = ModalRoute.of(context)!.settings.arguments as Transitionarg;

      if (arg.note == null) {
        _person = arg.person;
        _folder = arg.folder;
      } else if (arg.note != null) {
        _person = arg.person;
        _note = arg.note;
        _folder = arg.folder;
        _favorite = arg.note?.favorite ?? false;
        _isEdit = true;
        _titleController.text = _note?.title != "Nova nota"
            ? _note?.title ?? ''
            : '';
        _descriptionController.text = _note?.description ?? '';
      }

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(!_isEdit ? 'Adicionar Nota' : 'Nota'),
        centerTitle: true,
        actions: [
          if (_isEdit)
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.delete, color: Colors.red),
            ),
          IconButton(
            onPressed: () async {
              final note = Note(
                id: _isEdit ? _note!.id : Random().nextDouble().toString(),
                personid: _person!.id,
                folderid: _folder?.id,
                title: _titleController.text.isEmpty
                    ? "Nova nota"
                    : _titleController.text.trim(),
                description: _descriptionController.text,
                mark: _isMark ? 1 : 0,
                date: _isMark ? _markedAt : null,
                createdAt: DateTime.now(),
                marked: _isMark ? 0 : null,
                color: null,
                favorite: _favorite,
              );

              _isEdit
                  ? await Provider.of<Noteservice>(
                      context,
                      listen: false,
                    ).updateNote(note)
                  : await Provider.of<Noteservice>(
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
              SizedBox(
                height: MediaQuery.heightOf(context) * 0.03,
                child: LayoutBuilder(
                  builder: (context, constraints) => Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    spacing: 3,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _favorite = !_favorite;
                          });
                        },
                        child: Icon(
                          _favorite ? Icons.star : Icons.star_outline,
                          size: constraints.maxHeight * 0.8,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '|',
                        style: TextStyle(fontSize: constraints.maxHeight * 0.8),
                      ),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.folder_outlined,
                        size: constraints.maxHeight * 0.8,
                        color: _folder == null
                            ? Theme.of(context).colorScheme.onSurface
                            : Colorsmap.getColor(_folder!.color),
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Folderdialog(
                                person: _person!,
                                func: selectedFolder,
                              );
                            },
                          );
                        },
                        child: Text(
                          _folder == null ? "Sem pasta" : _folder!.name,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text("|"),
                      const SizedBox(width: 10),
                      Icon(
                        Icons.person_outline,
                        size: constraints.maxHeight * 0.8,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(_person!.id == 'home' ? "Sua nota" : _person!.nome!),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
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
