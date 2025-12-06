import 'package:aniversariodois/core/models/settings.dart';
import 'package:aniversariodois/core/utils/databaseUtil.dart';
import 'package:flutter/material.dart';

class Settingsservice extends ChangeNotifier {
  Settings? _settings;

  Settings? get setting {
    return _settings;
  }

  Future<void> loadSetting() async {
    try {
      final list = await Databaseutil.loadSingle('settings', '0');
      _settings = Settings.fromJson(list.first);
      notifyListeners();
    } catch (error) {
      throw 'Erro ao tentar carregar configurações';
    }
  }

  Future<void> updateSetting(Settings setting) async {
    try {
      _settings = setting;
      await Databaseutil.update('settings', setting.toJson(), setting.id);
      notifyListeners();
    } catch (error) {
      throw 'Erro ao tentar atualizar configurações';
    }
  }
}
