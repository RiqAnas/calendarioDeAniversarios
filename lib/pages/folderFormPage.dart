import 'dart:math';

import 'package:aniversariodois/components/dropDownColor.dart';
import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/folderService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Folderformpage extends StatefulWidget {
  @override
  State<Folderformpage> createState() => _FolderformpageState();
}

class _FolderformpageState extends State<Folderformpage> {
  TextEditingController _controller = TextEditingController();

  String? coloracao;

  Person? person;
  Folder? folder;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final map =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (map['folder'] == null) {
      person = map['person'] as Person;
    } else {
      person = map['person'] as Person;
      folder = map['folder'] as Folder;
    }
  }

  void selectedColor(String cor) {
    setState(() {
      coloracao = cor;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar pasta"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final newFolder = Folder(
                color: coloracao ?? '',
                createdAt: DateTime.now(),
                name: _controller.text,
                id: Random().nextDouble().toString(),
                personId: person!.id,
                folderId: folder?.id,
              );

              await Provider.of<Folderservice>(
                context,
                listen: false,
              ).insertFolder(newFolder);
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.save_outlined),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hint: Text("Nome"),
                  border: OutlineInputBorder(),
                ),
                controller: _controller,
              ),
              const SizedBox(height: 20),
              Dropdowncolor(selectedColor),
            ],
          ),
        ),
      ),
    );
  }
}
