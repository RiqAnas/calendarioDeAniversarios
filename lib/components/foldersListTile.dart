import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/utils/colorsMap.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';

class Folderslisttile extends StatelessWidget {
  final Folder folder;
  final Person person;

  Folderslisttile(this.folder, this.person);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          Routes.NOTEMENU,
          arguments: {'person': person, 'folder': folder},
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(maxHeight: 50, minWidth: 70),
              decoration: BoxDecoration(
                border: BoxBorder.all(color: Colorsmap.getColor(folder.color)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(folder.name, textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
