import 'package:aniversariodois/core/models/folder.dart';
import 'package:aniversariodois/core/models/note.dart';
import 'package:aniversariodois/core/models/person.dart';

class Transitionarg {
  Person person;
  Note? note;
  Folder? folder;

  Transitionarg({required this.person, this.folder, this.note});
}
