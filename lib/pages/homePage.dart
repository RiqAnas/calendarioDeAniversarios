import 'package:aniversariodois/components/personListTile.dart';
import 'package:aniversariodois/core/services/personService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Provider.of<Personservice>(context).loadPersons(),
        builder: (context, person) {
          if (person.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!person.hasData || person.data!.isEmpty) {
            return Center(child: Text("Sem pessoas adicionadas"));
          } else {
            return ListView.builder(
              itemCount: person.data!.length,
              itemBuilder: (context, index) {
                return Personlisttile(person: person.data![index]);
              },
            );
          }
        },
      ),
      floatingActionButton: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          minimumSize: Size(50, 50),
          backgroundColor: const Color.fromARGB(255, 248, 162, 191),
          foregroundColor: Colors.black,
        ),
        onPressed: () => Navigator.of(context).restorablePushNamed(Routes.FORM),
        label: Icon(Icons.add_outlined),
      ),
    );
  }
}
