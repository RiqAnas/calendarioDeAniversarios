import 'package:aniversariodois/components/noteListTile.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Persondialog extends StatelessWidget {
  final Person person;

  Persondialog({required this.person});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Theme.of(context).primaryColor, width: 3),
        ),
        height: MediaQuery.heightOf(context) * 0.6,
        width: MediaQuery.widthOf(context) * 0.9,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.nome!,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  'Data de nascimento: ${DateFormat('dd/MM/yyyy').format(person.nascimento!)}',
                ),
                const SizedBox(height: 15),
                Text('Idade: ${person.idade} anos'),
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text(
                      'Notas',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    TextButton(onPressed: () {}, child: Text("Ver todas")),
                  ],
                ),
                FutureBuilder(
                  future: Provider.of<Noteservice>(
                    context,
                  ).loadNotesperPerson(person.id),
                  builder: (context, note) {
                    if (note.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (!note.hasData || note.data!.isEmpty) {
                      return Container();
                    } else {
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Notelisttile(note: note.data![index]);
                          },
                        ),
                      );
                    }
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () => Navigator.of(
                          context,
                        ).pushNamed(Routes.NOTEFORM, arguments: person),
                        icon: Icon(Icons.add_outlined),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
