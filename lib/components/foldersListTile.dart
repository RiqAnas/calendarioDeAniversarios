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
        padding: const EdgeInsets.only(top: 10.0, right: 3),
        child: SizedBox(
          width: 80,
          height: 80,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double maxWidth = constraints.maxWidth;
              final double maxHeight = constraints.maxHeight;

              return Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -(maxHeight * 0.1),
                    child: Container(
                      width: maxWidth * 0.85,
                      height: maxHeight * 0.25,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(maxWidth * 0.05),
                          topRight: Radius.circular(maxWidth * 0.05),
                        ),
                        color: Colorsmap.getColor(folder.color),
                      ),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      height: maxHeight * 0.6,
                      width: maxWidth * 0.9,
                      decoration: BoxDecoration(
                        border: BoxBorder.fromLTRB(
                          left: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          right: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          bottom: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(maxWidth * 0.05),
                          bottomRight: Radius.circular(maxWidth * 0.05),
                          topRight: Radius.circular(maxWidth * 0.05),
                        ),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          folder.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: maxHeight * 0.15,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    top: -(maxHeight * 0.2),
                    child: Container(
                      width: maxWidth * 0.40,
                      height: maxHeight * 0.3,
                      decoration: BoxDecoration(
                        border: BoxBorder.fromLTRB(
                          left: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          right: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                          top: BorderSide(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(maxWidth * 0.05),
                          topRight: Radius.circular(maxWidth * 0.20),
                        ),
                        color: Theme.of(context).colorScheme.surfaceContainer,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
