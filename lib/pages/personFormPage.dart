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
  final TextEditingController _telcontroller = TextEditingController();

  DateTime? _nascimento;
  bool _initialized = false;
  bool _edit = false;
  Person? _pessoa;

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
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      Object? editInd = ModalRoute.of(context)!.settings.arguments;
      if (editInd != null) {
        _pessoa = editInd as Person;
        _edit = true;
        _nascimento = _pessoa?.nascimento ?? DateTime.now();
        _controller.text = _pessoa?.nome ?? '';
        _telcontroller.text = _pessoa?.telefone ?? '';
      }

      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(_edit ? "Editar" : "Adicionar"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              if (_controller.text.isEmpty && _nascimento == null) {
                return;
              }

              Person person = Person(
                id: _edit ? _pessoa!.id : Random().nextDouble().toString(),
                nome: _controller.text,
                nascimento: _nascimento,
                telefone: " 55${_telcontroller.text}",
                idade: Calc.ageCalc(_nascimento!),
                ativa: 1,
              );

              _edit
                  ? Provider.of<Personservice>(
                      context,
                      listen: false,
                    ).updatePerson(person)
                  : Provider.of<Personservice>(
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: BoxBorder.all(color: Colors.black, width: 2),
                      color: Colors.grey,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const Text("+55"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _telcontroller,
                      decoration: InputDecoration(
                        label: Text("Telefone"),
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ],
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
