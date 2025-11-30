import 'package:aniversariodois/core/services/personService.dart';
import 'package:aniversariodois/pages/notesMenuPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Mainpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _personProvider = Provider.of<Personservice>(
      context,
    ).getPerson('home');
    // TODO: implement build
    return Scaffold(
      body: FutureBuilder(
        future: _personProvider,
        builder: (context, home) {
          if (home.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!home.hasData || home.data == null) {
            return Center(
              child: Text(
                "Houve algum erro ao criar banco de dados, por favor reinstale o app",
              ),
            );
          } else {
            return Notesmenupage(persona: home.data);
          }
        },
      ),
    );
  }
}
