import 'package:aniversariodois/core/services/folderService.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/services/personService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:aniversariodois/pages/folderFormPage.dart';
import 'package:aniversariodois/pages/noteFormPage.dart';
import 'package:aniversariodois/pages/notesMenuPage.dart';
import 'package:aniversariodois/pages/personFormPage.dart';
import 'package:aniversariodois/pages/tabsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Color color = const Color.fromARGB(255, 248, 162, 191);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Personservice()),
        ChangeNotifierProvider(create: (_) => Noteservice()),
        ChangeNotifierProvider(create: (_) => Folderservice()),
      ],
      child: MaterialApp(
        title: 'Aniversarios',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: color,
            primary: color,
            surface: null,
            surfaceContainer: null,
            surfaceContainerLow: null,
            onSurface: null,
          ),
        ),
        initialRoute: Routes.HOME,
        routes: {
          Routes.HOME: (_) => Tabspage(),
          Routes.FORM: (_) => Personformpage(),
          Routes.NOTEFORM: (_) => Noteformpage(),
          Routes.NOTEMENU: (_) => Notesmenupage(),
          Routes.FOLDERFORM: (_) => Folderformpage(),
        },
      ),
    );
  }
}
