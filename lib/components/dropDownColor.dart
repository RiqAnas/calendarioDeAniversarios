import 'package:aniversariodois/core/models/settings.dart';
import 'package:aniversariodois/core/services/settingsService.dart';
import 'package:aniversariodois/core/utils/colorsMap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dropdowncolor extends StatefulWidget {
  final Function corSelecionada;
  final Settings? isSettings;

  Dropdowncolor({required this.corSelecionada, this.isSettings});

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
        initialValue: widget.isSettings != null
            ? widget.isSettings!.color
            : _cor,
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
        onChanged: (c) {
          if (widget.isSettings != null) {
            Provider.of<Settingsservice>(context, listen: false).updateSetting(
              Settings(
                id: widget.isSettings!.id,
                color: c!,
                mode: widget.isSettings!.mode,
              ),
            );
          }

          setState(() {
            _cor = c;
            widget.corSelecionada(_cor);
          });
        },
        validator: (c) => c == null ? 'Obrigatório' : null,
      ),
    );
  }
}
