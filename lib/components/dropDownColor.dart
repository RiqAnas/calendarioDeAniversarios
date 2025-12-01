import 'package:aniversariodois/core/utils/colorsMap.dart';
import 'package:flutter/material.dart';

class Dropdowncolor extends StatefulWidget {
  final Function corSelecionada;

  Dropdowncolor(this.corSelecionada);

  @override
  State<Dropdowncolor> createState() => _DropdowncolorState();
}

class _DropdowncolorState extends State<Dropdowncolor> {
  String? _cor;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: DropdownButtonFormField(
        initialValue: _cor,
        decoration: const InputDecoration(
          labelText: "cor",
          border: OutlineInputBorder(),
        ),
        hint: const Text("Selecione a cor"),
        items: Colorsmap.colorMap.entries.map((cor) {
          return DropdownMenuItem(
            value: cor.key,
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: BoxBorder.all(color: Colors.black),
                    color: cor.value,
                  ),
                  constraints: BoxConstraints(maxHeight: 10, maxWidth: 10),
                ),
                const SizedBox(width: 20),
                Text(cor.key),
              ],
            ),
          );
        }).toList(),
        onChanged: (c) => setState(() {
          _cor = c;

          widget.corSelecionada(_cor);
        }),
        validator: (c) => c == null ? 'Obrigatório' : null,
      ),
    );
  }
}
