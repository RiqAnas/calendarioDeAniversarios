import 'package:aniversariodois/components/notesGrid.dart';
import 'package:aniversariodois/components/sideBar.dart';
import 'package:aniversariodois/core/services/personService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favoritespage extends StatefulWidget {
  @override
  State<Favoritespage> createState() => _FavoritespageState();
}

class _FavoritespageState extends State<Favoritespage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Notas favoritas"), centerTitle: true),
      drawer: Sidebar(),
      body: FutureBuilder(
        future: Provider.of<Personservice>(context).getPerson('home'),
        builder: (context, person) {
          if (person.connectionState == ConnectionState.waiting) {
            return Container();
          }

          if (!person.hasData || person.data == null) {
            return Container();
          }

          return Notesgrid(person: person.data!, favorite: true);
        },
      ),
    );
  }
}
