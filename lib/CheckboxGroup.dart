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
          return Stack(
            children: <Widget>[
          Checkbox(
            value: selection['selected'],
            onChanged: (bool value) {
              setState(() {
                selection['selected']= value;
              });
            },
          ),
          InkWell(
                  onTap: () {
                    setState(() {
                      selection['selected']= !selection['selected'];
                      // _selected = selection['id'];
                    });
                  },
                  child: Container(
                    color: Colors.red.withAlpha(0),
                    width: double.infinity,
                    height: 100,
                  )),
            ]
          );
        }).toList(),
            
        );
  }
}


// Stack(
//             children: <Widget>[
//               Radio(
//                 groupValue: _selected,
//                 value: selection['id'],
//                 onChanged: (selected) {},
//               ),
              
//             ],
//           );