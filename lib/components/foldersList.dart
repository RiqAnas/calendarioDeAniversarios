import 'package:aniversariodois/components/foldersListTile.dart';
import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/folderService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Folderslist extends StatefulWidget {
  final Person person;
  final Folder? folders;

  Folderslist({required this.person, this.folders});

  @override
  State<Folderslist> createState() => _FolderslistState();
}

class _FolderslistState extends State<Folderslist> {
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
    Widget _addButton() {
      return IconButton(
        onPressed: () {
          if (widget.folders == null) {
            Navigator.of(context).pushNamed(
              Routes.FOLDERFORM,
              arguments: {'person': widget.person, 'folder': null},
            );
          } else {
            Navigator.of(context).pushNamed(
              Routes.FOLDERFORM,
              arguments: {'person': widget.person, 'folder': widget.folders},
            );
          }
        },
        icon: Icon(Icons.add),
      );
    }

    // TODO: implement build
    return StreamBuilder(
      stream: Provider.of<Folderservice>(context, listen: false).folders,
      builder: (context, folders) {
        if (folders.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!folders.hasData || folders.data!.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [_addButton()],
          );
        } else {
          List<Folder> folder = folders.data!
              .where((folder) => folder.folderId == widget.folders?.id)
              .toList();
          return SizedBox(
            width: double.infinity,
            height: 60,
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: folder
                        .map((fol) => Folderslisttile(fol, widget.person))
                        .toList(),
                  ),
                ),
                const Spacer(),
                _addButton(),
              ],
            ),
          );
        }
      },
    );
  }
}
