import 'package:flutter/widgets.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

class Markdownview extends StatelessWidget {
  final String title;
  final String desc;

  Markdownview(this.title, this.desc);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MarkdownBody(
      data: '''# $title 
$desc''',
      selectable: true,
      listItemCrossAxisAlignment: MarkdownListItemCrossAxisAlignment.start,
      softLineBreak: true,
      styleSheet: MarkdownStyleSheet(textAlign: WrapAlignment.start),
      fitContent: true,
    );
  }
}
