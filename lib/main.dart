import 'package:aniversariodois/core/models/settings.dart';
import 'package:aniversariodois/core/services/folderService.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/services/personService.dart';
import 'package:aniversariodois/core/services/settingsService.dart';
import 'package:aniversariodois/core/utils/colorsMap.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:aniversariodois/pages/folderFormPage.dart';
import 'package:aniversariodois/pages/noteFormPage.dart';
import 'package:aniversariodois/pages/notesMenuPage.dart';
import 'package:aniversariodois/pages/personFormPage.dart';
import 'package:aniversariodois/pages/settingsPage.dart';
import 'package:aniversariodois/pages/tabsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Settingsservice()..loadSetting()),
        ChangeNotifierProvider(create: (_) => Personservice()),
        ChangeNotifierProvider(create: (_) => Noteservice()),
        ChangeNotifierProvider(create: (_) => Folderservice()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Settings? setting = Provider.of<Settingsservice>(context).setting;
    Color color = Colorsmap.getColor(setting?.color ?? 'Azul');

    ThemeData _switchTheme(bool theme) {
      if (theme == true) {
        return ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: color,
            primary: color,
            surface: null,
            surfaceContainer: null,
            surfaceContainerLow: null,
            onSurface: null,
          ),
        );
      } else {
        return ThemeData(
          colorScheme: ColorScheme.dark(
            primary: color,
            surface: const Color.fromARGB(255, 29, 28, 28),
            surfaceContainer: Colors.black,
            surfaceContainerLow: Colors.black,
          ),
        );
      }
    }

    return MaterialApp(
      title: 'Aniversarios',
      debugShowCheckedModeBanner: false,
      theme: _switchTheme(setting?.mode ?? true),
      initialRoute: Routes.HOME,
      routes: {
        Routes.HOME: (_) => Tabspage(),
        Routes.FORM: (_) => Personformpage(),
        Routes.NOTEFORM: (_) => Noteformpage(),
        Routes.NOTEMENU: (_) => Notesmenupage(),
        Routes.FOLDERFORM: (_) => Folderformpage(),
        Routes.SETTINGS: (_) => Settingspage(),
      },
    );
  }
}
