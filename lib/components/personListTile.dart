import 'package:aniversariodois/components/personDialog.dart';
import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/personService.dart';
import 'package:aniversariodois/core/utils/calc.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Personlisttile extends StatelessWidget {
  final Person? person;

  Personlisttile({required this.person});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return Persondialog(person: person!);
          },
        );
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(person!.nome!),
                  Text(
                    "Idade: ${person!.idade} anos",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              if (Calc.birthday(person!.nascimento!))
                Icon(Icons.cake, color: Colors.pinkAccent),
              IconButton(
                onPressed: () => Navigator.of(
                  context,
                ).pushNamed(Routes.FORM, arguments: person),
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  Provider.of<Personservice>(
                    context,
                    listen: false,
                  ).deletePerson(person!);
                },
                icon: Icon(Icons.delete, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
