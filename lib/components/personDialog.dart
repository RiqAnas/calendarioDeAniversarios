import 'package:aniversariodois/components/noteListTile.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Persondialog extends StatefulWidget {
  final Person person;

  Persondialog({required this.person});

  @override
  State<Persondialog> createState() => _PersondialogState();
}

class _PersondialogState extends State<Persondialog> {
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
                  widget.person.nome!,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  'Data de nascimento: ${DateFormat('dd/MM/yyyy').format(widget.person.nascimento!)}',
                ),
                const SizedBox(height: 15),
                Text('Idade: ${widget.person.idade} anos'),
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
                    TextButton(
                      onPressed: () => Navigator.of(
                        context,
                      ).pushNamed(Routes.NOTEMENU, arguments: widget.person),
                      child: Text("Ver todas"),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: Provider.of<Noteservice>(context).notes,
                  builder: (context, note) {
                    if (note.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (!note.hasData || note.data!.isEmpty) {
                      return Container();
                    } else {
                      return SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: note.data!.length < 4
                              ? note.data!.length
                              : 4,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                Routes.NOTEFORM,
                                arguments: {
                                  'person': widget.person,
                                  'note': note.data![index],
                                },
                              ),
                              child: Notelisttile(note: note.data![index]),
                            );
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
                        onPressed: () => Navigator.of(context).pushNamed(
                          Routes.NOTEFORM,
                          arguments: {'person': widget.person, 'note': null},
                        ),
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
