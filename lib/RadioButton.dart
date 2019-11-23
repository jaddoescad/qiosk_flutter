import 'package:flutter/material.dart';

class TimePreferencesWidget extends StatefulWidget {
  TimePreferencesWidget({this.selections, this.sectionId});
  final selections;
  final sectionId;

  @override
  TimePreferencesWidgetState createState() => TimePreferencesWidgetState();
}

class TimePreferencesWidgetState extends State<TimePreferencesWidget> {
  var _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: widget.selections.map<Widget>((selection) {
          var index = widget.selections.indexOf(selection);
          return Stack(
            children: <Widget>[
              Radio(
                groupValue: _selected,
                value: selection['id'],
                onChanged: (selected) {},
              ),
              InkWell(
                  onTap: () {
                    setState(() {
                      _selected = selection['id'];
                    });
                  },
                  child: Container(
                    color: Colors.red.withAlpha(0),
                    width: double.infinity,
                    height: 100,
                  )),
            ],
          );

          // child:
        }).toList(),
      ),
    );
  }
}