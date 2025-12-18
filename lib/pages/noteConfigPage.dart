import 'package:aniversariodois/components/dropDownColor.dart';
import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/models/superFuncArg.dart';
import 'package:flutter/material.dart';

class Noteconfigpage extends StatefulWidget {
  @override
  State<Noteconfigpage> createState() => _NoteconfigpageState();
}

class _NoteconfigpageState extends State<Noteconfigpage> {
  late Function func;
  late Function colorFunc;
  late Function textFunc;
  late Note note;
  bool? markdown;
  bool init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!init) {
      Superfuncarg? arg =
          ModalRoute.of(context)!.settings.arguments as Superfuncarg;

      func = arg.func.func;
      markdown = arg.func.value;
      note = arg.func.note!;
      colorFunc = arg.colorFunc;
      textFunc = arg.textFunc;
      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              value: markdown ?? false,
              title: Text(
                "Visualização markdown",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Ativar modo de visualização de markdown",
                style: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) async {
                setState(() {
                  markdown = value;
                });
                func(value);
              },
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Cor da nota",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Dropdowncolor(corSelecionada: colorFunc, initialColor: note.color),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                "Cor da fonte",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Dropdowncolor(
              corSelecionada: textFunc,
              initialColor: note.textcolor,
            ),
          ],
        ),
      ),
    );
  }
}
