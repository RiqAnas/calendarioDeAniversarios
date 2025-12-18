import 'package:aniversariodois/core/models/functionArg.dart';
import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/models/superFuncArg.dart';
import 'package:aniversariodois/core/services/noteService.dart';
import 'package:aniversariodois/core/utils/exports/pdfUtil.dart';
import 'package:aniversariodois/core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Popmenunote extends StatelessWidget {
  final Note _note;
  final Function _func;
  final bool _value;
  final Function _colorFunc;
  final Function _textColorFunc;

  Popmenunote(
    this._note,
    this._func,
    this._value,
    this._colorFunc,
    this._textColorFunc,
  );

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
        if (value == 'configuracoes') {
          Navigator.of(context).pushNamed(
            Routes.NOTECONFIG,
            arguments: Superfuncarg(
              Functionarg(value: _value, func: _func, note: _note),
              _textColorFunc,
              _colorFunc,
            ),
          );
        }
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
