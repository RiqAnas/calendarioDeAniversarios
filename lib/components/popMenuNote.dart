import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/exports/pdfUtil.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Popmenunote extends StatelessWidget {
  final Note _note;

  Popmenunote(this._note);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) async {
        if (value == 'excluir') {
          Provider.of<Noteservice>(context, listen: false).deleteNote(_note);
          Navigator.of(context).pop();
        }
        if (value == 'configuracoes') {}
        if (value == 'export') {
          await exportToPdf(note: _note, wcontext: context);
        }
      },
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem(value: 'excluir', child: Text("Excluir nota")),
          const PopupMenuItem(
            value: 'configuracoes',
            child: Text("Configurações"),
          ),
          const PopupMenuItem(value: 'export', child: Text("Exportar para")),
        ];
      },
    );
  }
}
