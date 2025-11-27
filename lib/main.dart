import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/services/personService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:aniversariodois/pages/homePage.dart';
import 'package:aniversariodois/pages/personFormPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Personservice()),
        ChangeNotifierProvider(create: (_) => Noteservice()),
      ],
      child: MaterialApp(
        title: 'Aniversarios',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        ),
        initialRoute: Routes.HOME,
        routes: {
          Routes.HOME: (_) => Homepage(),
          Routes.FORM: (_) => Personformpage(),
        },
      ),
    );
  }
}
