import 'package:flutter/material.dart';

/// Widget that returns an unordered list with proper formatting.
class UnorderedList extends StatelessWidget {
  final List<String> texts;
  final TextStyle style;
  final double spacing;

  UnorderedList({@required this.texts, this.style, this.spacing});

  @override
  Widget build(BuildContext context) {
    var widgetList = <Widget>[];
    for (String text in texts) {
      // Add list item
      widgetList.add(UnorderedListItem(text, style));
      // Add space between items
      widgetList.add(SizedBox(height: spacing));
    }

    return Column(children: widgetList);
  }
}

class UnorderedListItem extends StatelessWidget {
  final String text;
  final TextStyle style;

  UnorderedListItem(this.text, this.style);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("• "),
        Expanded(
          child: Text(text, style: style, textAlign: TextAlign.justify),
        ),
      ],
    );
  }
}