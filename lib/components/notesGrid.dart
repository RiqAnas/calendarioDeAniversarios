import 'package:aniversariodois/components/noteGridTile.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Notesgrid extends StatefulWidget {
  final Person person;

  Notesgrid({required this.person});

  @override
  State<Notesgrid> createState() => _NotesgridState();
}

class _NotesgridState extends State<Notesgrid> {
  @override
  void initState() {
    super.initState();
    Provider.of<Noteservice>(
      context,
      listen: false,
    ).loadNotesperPerson(widget.person.id);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
      stream: Provider.of<Noteservice>(context, listen: false).notes,
      builder: (context, notes) {
        if (notes.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (!notes.hasData || notes.data!.isEmpty) {
          return const Center(child: Text("Sem notas"));
        } else {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: MediaQuery.heightOf(context) * 0.25,
              childAspectRatio: 3 / 2,
              mainAxisSpacing: 8,
              crossAxisSpacing: 10,
            ),
            itemCount: notes.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await Navigator.of(context).pushNamed(
                    Routes.NOTEFORM,
                    arguments: {
                      'person': widget.person,
                      'note': notes.data![index],
                    },
                  );
                },
                child: Notegridtile(note: notes.data![index]),
              );
            },
          );
        }
      },
    );
  }
}
