import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/models/transitionArg.dart';
import 'package:aniversariodois/core/services/folderService.dart';
import 'package:aniversariodois/core/utils/colorsMap.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Foldersviewlist extends StatelessWidget {
  final Person person;
  final int? selectedIndex;
  final Function navigateAndSelect;
  final bool isEdit;

  Foldersviewlist({
    required this.person,
    this.selectedIndex,
    required this.navigateAndSelect,
    this.isEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: Provider.of<Folderservice>(context, listen: false).folders,
      builder: (context, folder) {
        if (folder.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (!folder.hasData || folder.data!.isEmpty) {
          return Container();
        }

        List<Folder> mainList = folder.data!
            .where((fol) => fol.folderId == null)
            .toList();

        List<Folder> childrenList(String folderId) {
          return folder.data!.where((fol) => fol.folderId == folderId).toList();
        }

        return ListView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          itemCount: mainList.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.folder_outlined,
                    color: Colorsmap.getColor(mainList[index].color),
                  ),
                  title: Text(mainList[index].name),
                  selected: selectedIndex == 2,
                  onTap: () {
                    if (!isEdit) {
                      navigateAndSelect(
                        context: context,
                        index: 2,
                        route: Routes.NOTEMENU,
                        argument: Transitionarg(
                          person: person,
                          folder: mainList[index],
                        ),
                      );
                    } else {
                      navigateAndSelect(mainList[index]);
                      Navigator.of(context).pop();
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.widthOf(context) * 0.05,
                  ),
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: childrenList(mainList[index].id).length,
                    itemBuilder: (context, subindex) {
                      final children = childrenList(mainList[index].id);

                      return ListTile(
                        leading: Icon(
                          Icons.folder_outlined,
                          color: Colorsmap.getColor(children[subindex].color),
                        ),
                        title: Text(children[subindex].name),
                        selected: selectedIndex == 2,
                        onTap: () {
                          if (!isEdit) {
                            navigateAndSelect(
                              context: context,
                              index: 2,
                              route: Routes.NOTEMENU,
                              argument: Transitionarg(
                                person: person,
                                folder: children[subindex],
                              ),
                            );
                          } else {
                            navigateAndSelect(children[subindex]);
                            Navigator.of(context).pop();
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
