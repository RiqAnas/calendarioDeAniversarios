import 'package:aniversariodois/components/foldersViewList.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/folderService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Folderdialog extends StatefulWidget {
  final Person person;
  final Function func;

  Folderdialog({required this.person, required this.func});

  @override
  State<Folderdialog> createState() => _FolderdialogState();
}

class _FolderdialogState extends State<Folderdialog> {
  @override
  void initState() {
    super.initState();
    Provider.of<Folderservice>(
      context,
      listen: false,
    ).loadFoldersperPerson(widget.person.id);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
        ),
        height: MediaQuery.heightOf(context) * 0.6,
        width: MediaQuery.widthOf(context) * 0.65,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Foldersviewlist(
                    person: widget.person,
                    navigateAndSelect: widget.func,
                    isEdit: true,
                  ),
                  ListTile(
                    leading: Icon(Icons.folder_outlined, color: Colors.grey),
                    title: Text("Sem pasta"),
                    onTap: () {
                      widget.func(null);
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
