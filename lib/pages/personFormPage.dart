import 'dart:math';

import 'package:aniversariodois/core/models/person.dart';
import 'package:aniversariodois/core/services/personService.dart';
import 'package:aniversariodois/core/utils/calc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Personformpage extends StatefulWidget {
  @override
  State<Personformpage> createState() => _PersonformpageState();
}

class _PersonformpageState extends State<Personformpage> {
  final TextEditingController _controller = TextEditingController();

  DateTime? _nascimento;

  _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((picked) {
      if (picked != null) {
        setState(() {
          _nascimento = picked;
        });
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Adicionar"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (_controller.text.isEmpty && _nascimento == null) {
                return;
              }

              Person person = Person(
                id: Random().nextDouble().toString(),
                nome: _controller.text,
                nascimento: _nascimento,
                idade: Calc.ageCalc(_nascimento!),
                ativa: 1,
              );

              Provider.of<Personservice>(
                context,
                listen: false,
              ).insertPerson(person);

              Navigator.of(context).pop();
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  label: Text("Nome"),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            GestureDetector(
              onTap: _showDatePicker,
              child: Chip(
                label: _nascimento == null
                    ? Text("Selecione a data")
                    : Text(DateFormat('dd/MM/yyy').format(_nascimento!)),
                elevation: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
