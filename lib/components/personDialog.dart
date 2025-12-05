//import 'package:aniversariodois/components/dropDownColor.dart';
import 'package:aniversariodois/components/noteListTile.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/models/transitionArg.dart';
import 'package:aniversariodois/core/services/noteService.dart';
//import 'package:aniversariodois/core/utils/colorsMap.dart';
import 'package:aniversariodois/core/utils/redirect.dart';
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
  //String? coloracao;

  @override
  void initState() {
    super.initState();
    Provider.of<Noteservice>(
      context,
      listen: false,
    ).loadNotesperPerson(widget.person.id);
  }

  /*void selectedColor(String cor) {
    setState(() {
      coloracao = cor;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 3,
          ),
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
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Telefone: '),
                    TextButton(
                      onPressed: () =>
                          Redirect.phoneCall(widget.person.telefone),
                      child: Text("+${widget.person.telefone}"),
                    ),
                    IconButton(
                      onPressed: () =>
                          Redirect.whatsapp(widget.person.telefone),
                      icon: Icon(Icons.chat, size: 20),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                      onPressed: () => Navigator.of(context).pushNamed(
                        Routes.NOTEMENU,
                        arguments: Transitionarg(person: widget.person),
                      ),
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
                                arguments: Transitionarg(
                                  person: widget.person,
                                  note: note.data![index],
                                ),
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
                          arguments: Transitionarg(person: widget.person),
                        ),
                        icon: Icon(Icons.add_outlined),
                      ),
                    ),
                  ],
                ),
                /*Dropdowncolor(selectedColor),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.black),
                    color: Colorsmap.getColor(coloracao ?? ''),
                  ),
                  constraints: BoxConstraints(minHeight: 20),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
