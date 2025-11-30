import 'package:url_launcher/url_launcher.dart';

class Redirect {
  static Future<void> phoneCall(String number) async {
    final Uri launchUri = Uri(scheme: 'tel', path: number);

    if (!await launchUrl(launchUri)) {
      throw "Não foi possível fazer a ligação";
    }
  }

  static Future<void> whatsapp(String number) async {
    final Uri launchUri = Uri.parse("https://wa.me/$number");

    if (!await launchUrl(launchUri, mode: LaunchMode.externalApplication)) {
      throw "Não foi possível acessar whatsapp do número";
    }
  }
}
