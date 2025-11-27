import 'package:aniversariodois/components/personListTile.dart';
import 'package:aniversariodois/core/services/personService.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aniversários"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).restorablePushNamed(Routes.FORM),
            icon: Icon(Icons.add),
          ),
        ],
      ),
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
    );
  }
}
