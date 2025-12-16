import 'dart:io';
import 'dart:typed_data';

import 'package:aniversariodois/core/models/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareFile({
  required Note note,
  required Future<Uint8List> bits,
  required BuildContext wcontext,
}) async {
  try {
    final dir = await getApplicationDocumentsDirectory();

    final file = File(
      '${dir.path}/${note.title.replaceAll(' ', '_')}_nota.pdf',
    );

    await file.writeAsBytes(await bits);

    final result = await SharePlus.instance.share(
      ShareParams(
        files: [XFile(file.path)],
        text: 'Nota: ${note.title}',
        subject: 'Pdf',
      ),
    );

    if (result.status == ShareResultStatus.success) {
      ScaffoldMessenger.of(wcontext).showSnackBar(
        const SnackBar(content: Text("Nota compartilhada como pdf!")),
      );
    }
  } catch (error) {
    throw 'Impossibilitado de compartilhar pdf';
  }
}

Future<void> saveAs({
  required Note note,
  required Future<Uint8List> bits,
  required BuildContext wcontext,
}) async {
  try {
    final temp = await getTemporaryDirectory();

    final String fileName = '${note.title.replaceAll(' ', '_')}.pdf';
    final tempName = '${temp.path}/$fileName';

    final file = File(tempName);
    await file.writeAsBytes(await bits);

    final params = SaveFileDialogParams(sourceFilePath: tempName);
    final path = await FlutterFileDialog.saveFile(params: params);

    if (path != null) {
      ScaffoldMessenger.of(
        wcontext,
      ).showSnackBar(const SnackBar(content: Text("Nota salva como pdf!")));
    }
  } catch (error) {
    throw 'Impossibiltado de salvar como pdf';
  }
}
