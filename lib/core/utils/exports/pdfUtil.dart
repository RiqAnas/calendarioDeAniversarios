import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/utils/exports/filesHandler.dart';
import 'package:flutter/material.dart';

import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

Future<void> exportToPdf({
  required Note note,
  required BuildContext wcontext,
  bool share = false,
}) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Column(
          children: [
            pw.Header(level: 0, child: pw.Text(note.title)),
            pw.SizedBox(height: 20),
            pw.Text(note.description),
          ],
        );
      },
    ),
  );

  if (share) {
    shareFile(note: note, bits: pdf.save(), wcontext: wcontext);
  } else {
    saveAs(note: note, bits: pdf.save(), wcontext: wcontext);
  }
}
