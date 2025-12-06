import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Sidebar extends StatefulWidget {
  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  int _selectedIndex = 0;

  void _navigateAndSelect(BuildContext context, int index, String route) {
    if (ModalRoute.of(context)?.settings.name == route) {
      Navigator.pop(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, route);
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentRoute = ModalRoute.of(context)?.settings.name;
      setState(() {
        if (currentRoute == Routes.HOME) {
          _selectedIndex = 0;
        } else if (currentRoute == Routes.SETTINGS) {
          _selectedIndex = 1;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
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
            onTap: () => _navigateAndSelect(context, 0, Routes.HOME),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text("Configurações"),
            selected: _selectedIndex == 1,
            onTap: () => _navigateAndSelect(context, 1, Routes.SETTINGS),
          ),
        ],
      ),
    );
  }
}
