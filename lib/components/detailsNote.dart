import 'package:aniversariodois/components/folderDialog.dart';
import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/utils/colorsMap.dart';
import 'package:flutter/material.dart';

class Detailsnote extends StatelessWidget {
  final Note? note;
  final Person person;
  final Function favorite;
  final bool favState;
  final Function selectedFolder;
  final Folder? newFolder;

  Detailsnote({
    required this.note,
    required this.person,
    required this.favorite,
    required this.favState,
    required this.selectedFolder,
    required this.newFolder,
  });

  Widget detailsRow({
    required BuildContext context,
    required Folder? folderdata,
  }) {
    if (folderdata?.id == 'nulo') {
      folderdata = null;
    }

    return SizedBox(
      height: MediaQuery.heightOf(context) * 0.03,
      child: LayoutBuilder(
        builder: (context, constraints) => Row(
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 3,
          children: [
            GestureDetector(
              onTap: () {
                favorite(favState);
              },
              child: Icon(
                favState ? Icons.star : Icons.star_outline,
                size: constraints.maxHeight * 0.8,
              ),
            ),
            const SizedBox(width: 10),
            Text('|', style: TextStyle(fontSize: constraints.maxHeight * 0.8)),
            const SizedBox(width: 10),
            Icon(
              Icons.folder_outlined,
              size: constraints.maxHeight * 0.8,
              color: folderdata == null
                  ? Theme.of(context).colorScheme.onSurface
                  : Colorsmap.getColor(folderdata.color),
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Folderdialog(person: person, func: selectedFolder);
                  },
                );
              },
              child: Text(folderdata == null ? "Sem pasta" : folderdata.name),
            ),
            const SizedBox(width: 10),
            Text("|"),
            const SizedBox(width: 10),
            Icon(
              Icons.person_outline,
              size: constraints.maxHeight * 0.8,
              color: Theme.of(context).colorScheme.primary,
            ),
            Text(person.id == 'home' ? "Sua nota" : person.nome!),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return detailsRow(context: context, folderdata: newFolder);
  }
}
