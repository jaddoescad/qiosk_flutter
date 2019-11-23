import 'package:flutter/material.dart';

class CheckboxGroup extends StatefulWidget {
  CheckboxGroup({this.selections, this.sectionId});
  final selections;
  final sectionId;

  @override
  CheckboxGroupState createState() => new CheckboxGroupState();
}

class CheckboxGroupState extends State<CheckboxGroup> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: widget.selections.map<Widget>((selection) {
          return new CheckboxListTile(
            title: new Text(selection['title']),
            value: selection['selected'],
            secondary: Text("\$2.55"),
            onChanged: (bool value) {
              setState(() {
                selection['selected']= value;
              });
            },
          );
        }).toList(),
      );
  }
}