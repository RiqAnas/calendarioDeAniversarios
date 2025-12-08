import 'package:aniversariodois/components/foldersViewList.dart';

import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/models/transitionArg.dart';
import 'package:aniversariodois/core/services/folderService.dart';
import 'package:aniversariodois/core/services/personService.dart';

import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _selectedIndex = 0;
  Person? _person;
  ScrollController _scrollController = ScrollController();

  void _getPerson() async {
    try {
      final person = await Provider.of<Personservice>(
        context,
        listen: false,
      ).getPerson('home');

      if (mounted) {
        setState(() {
          _person = person;
        });
      }
    } catch (error) {
      throw 'Erro ao tentar carregar pessoa';
    }
  }

  void _navigateAndSelect({
    required BuildContext context,
    required int index,
    required String route,
    Transitionarg? argument,
  }) {
    if (ModalRoute.of(context)?.settings.name == route) {
      Navigator.pop(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pop(context);
      if (argument == null) {
        Navigator.pushReplacementNamed(context, route);
      } else {
        Navigator.pushNamed(context, route, arguments: argument);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getPerson();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRoute = ModalRoute.of(context)?.settings.name;
      setState(() {
        if (currentRoute == Routes.HOME) {
          _selectedIndex = 0;
        } else if (currentRoute == Routes.SETTINGS) {
          _selectedIndex = 1;
        } else if (currentRoute == Routes.NOTEMENU) {
          _selectedIndex = 2;
        } else if (currentRoute == Routes.FAVORITES) {
          _selectedIndex = 3;
        }
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Scrollbar(
        controller: _scrollController,
        radius: const Radius.circular(15),
        thickness: 4,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                height: MediaQuery.heightOf(context) * 0.2,
                color: Theme.of(context).colorScheme.primary,
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note,
                      size: 40,
                      color: Theme.of(context).colorScheme.surface,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "NotesU",
                      style: TextStyle(
                        fontSize: 40,
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.note_outlined),
                title: const Text("Início"),
                selected: _selectedIndex == 0,
                onTap: () => _navigateAndSelect(
                  context: context,
                  index: 0,
                  route: Routes.HOME,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.star),
                title: const Text("Favoritos"),
                selected: _selectedIndex == 3,
                onTap: () => _navigateAndSelect(
                  context: context,
                  index: 3,
                  route: Routes.FAVORITES,
                ),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text("Configurações"),
                selected: _selectedIndex == 1,
                onTap: () => _navigateAndSelect(
                  context: context,
                  index: 1,
                  route: Routes.SETTINGS,
                ),
              ),
              ExpansionTile(
                title: const Text("Pastas"),
                leading: const Icon(Icons.folder_outlined),
                onExpansionChanged: (bool expanded) {
                  if (expanded) {
                    Provider.of<Folderservice>(
                      context,
                      listen: false,
                    ).loadFoldersperPerson('home');
                  }
                },
                children: [
                  const Divider(),

                  if (_person == null)
                    Container()
                  else
                    Foldersviewlist(
                      person: _person!,
                      selectedIndex: _selectedIndex,
                      navigateAndSelect: _navigateAndSelect,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
