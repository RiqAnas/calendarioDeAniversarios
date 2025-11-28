import 'package:aniversariodois/components/noteGridTile.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notesmenupage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Person person = ModalRoute.of(context)!.settings.arguments as Person;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Notas de ${person.nome}"), centerTitle: true),
      body: FutureBuilder(
        future: Provider.of<Noteservice>(context).loadNotesperPerson(person.id),
        builder: (context, notes) {
          if (notes.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (!notes.hasData || notes.data!.isEmpty) {
            return const Center(child: Text("Sem notas"));
          } else {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.widthOf(context) * 0.5,
                  mainAxisExtent: MediaQuery.heightOf(context) * 0.22,
                  childAspectRatio: 3 / 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 10,
                ),
                itemCount: notes.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pushNamed(
                      Routes.NOTEFORM,
                      arguments: {'person': person, 'note': notes.data![index]},
                    ),
                    child: Notegridtile(note: notes.data![index]),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
