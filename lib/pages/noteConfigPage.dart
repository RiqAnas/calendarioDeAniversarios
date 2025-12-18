import 'package:aniversariodois/core/models/functionArg.dart';
import 'package:flutter/material.dart';

class Noteconfigpage extends StatefulWidget {
  @override
  State<Noteconfigpage> createState() => _NoteconfigpageState();
}

class _NoteconfigpageState extends State<Noteconfigpage> {
  late Function func;
  bool? markdown;
  bool init = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!init) {
      Functionarg arg =
          ModalRoute.of(context)!.settings.arguments as Functionarg;

      func = arg.func;
      markdown = arg.value;
      init = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Configurações'), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
