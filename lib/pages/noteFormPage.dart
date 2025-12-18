import 'dart:math';

import 'package:aniversariodois/components/detailsNote.dart';
import 'package:aniversariodois/components/popMenuNote.dart';
import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/models/transitionArg.dart';
import 'package:aniversariodois/core/services/folderService.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/markdownView.dart';

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
  bool _canChange = false;
  bool _markdown = false;

  void selectedFolder(Folder? folder) {
    setState(() {
      _folder = folder;
    });
  }

  void turnToFavorite(bool favState) {
    setState(() {
      _favorite = !favState;
    });
  }

  void markview(bool togglemark) {
    setState(() {
      _canChange = togglemark;
    });
  }

  void getFolder(String? id) async {
    var result = await Provider.of<Folderservice>(
      context,
      listen: false,
    ).getFolder(id);

    if (mounted && result != null) {
      setState(() {
        _folder = result;
      });
    }
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
        getFolder(_note?.folderid);
        _favorite = arg.note?.favorite ?? false;
        _canChange = arg.note?.markview ?? false;
        _isEdit = true;
        _titleController.text = _note?.title != "Nova nota"
            ? _note?.title ?? ''
            : '';
        _descriptionController.text = _note?.description ?? '';
      }

      _initialized = true;
    }
  }

  void updateOrSave(BuildContext context) async {
    final note = Note(
      id: _isEdit ? _note!.id : Random().nextDouble().toString(),
      personid: _person!.id,
      folderid: _folder?.id == 'nulo' ? null : _folder?.id,
      title: _titleController.text.isEmpty
          ? "Nova nota"
          : _titleController.text.trim(),
      description: _descriptionController.text,
      mark: _isMark ? 1 : 0,
      date: _isMark ? _markedAt : null,
      createdAt: DateTime.now(),
      marked: _isMark ? 0 : null,
      color: _isEdit ? _note!.color : null,
      textcolor: _isEdit ? _note!.textcolor : null,
      markview: _canChange,
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
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(!_isEdit ? 'Adicionar Nota' : 'Nota'),
        centerTitle: true,
        leading: IconButton(
          onPressed: _isEdit
              ? () {
                  updateOrSave(context);
                }
              : () {
                  Navigator.of(context).pop();
                },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [
          if (_isEdit) Popmenunote(_note!, markview, _canChange),
          if (!_isEdit)
            IconButton(
              onPressed: () {
                updateOrSave(context);
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
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
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
              !_canChange
                  ? Detailsnote(
                      note: _note,
                      person: _person!,
                      favorite: turnToFavorite,
                      favState: _favorite,
                      selectedFolder: selectedFolder,
                      newFolder: _folder,
                    )
                  : Row(
                      children: [
                        Detailsnote(
                          note: _note,
                          person: _person!,
                          favorite: turnToFavorite,
                          favState: _favorite,
                          selectedFolder: selectedFolder,
                          newFolder: _folder,
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _markdown = !_markdown;
                            });
                          },
                          icon: Icon(
                            !_markdown
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ],
                    ),
              const SizedBox(height: 10),
              !_markdown
                  ? TextField(
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
                    )
                  : Markdownview(
                      _titleController.text,
                      _descriptionController.text,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
