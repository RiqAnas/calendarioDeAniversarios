import 'package:aniversariodois/components/dropDownColor.dart';
import 'package:aniversariodois/components/sideBar.dart';
import 'package:aniversariodois/core/models/settings.dart';
import 'package:aniversariodois/core/services/settingsService.dart';
import 'package:aniversariodois/core/utils/colorsMap.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settingspage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Settings config = Provider.of<Settingsservice>(context).setting!;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text('Configurações'), centerTitle: true),
      drawer: Sidebar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Dropdowncolor(corSelecionada: () {}, isSettings: config),
            Container(
              width: 300,
              height: 10,
              decoration: BoxDecoration(
                color: Colorsmap.getColor(config.color),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              value: !config.mode,
              title: Text(
                "Modo escuro",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                "Ativar modo escuro",
                style: TextStyle(color: Colors.grey),
              ),
              onChanged: (value) {
                value = config.mode;
                Provider.of<Settingsservice>(
                  context,
                  listen: false,
                ).updateSetting(
                  Settings(id: config.id, color: config.color, mode: !value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
