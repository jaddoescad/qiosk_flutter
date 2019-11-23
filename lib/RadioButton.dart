//   @override
//   Widget build(BuildContext context) {
//     var _selected;
//     return Column(
//         children: radioValues.map((radioValue) {
//           var index = radioValues.indexOf(radioValue);
//           print(index);
//           return new RadioListTile<int>(
//             title: Text(radioValues[index]['foo']),
//             value: index,
//             groupValue: _selected ,
//             onChanged: (int value) {
//               setState(() {
//                 print(value);
//                 _selected = value;
//               });
//             },
//           );
//         }).toList(),
//       );
//   }
// }

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
                  return RadioListTile(
                    groupValue: _selected,
                    title: Text(selection['title']),
                    value: selection['id'],
                    secondary: Text("\$2.55"),
                    onChanged: (selected) {
                        setState(() {
                            debugPrint('VAL = $selected');
                            _selected = selected;
                        });
                    },
                );
                }).toList(),
            ),
        );
    }
}

// class CheckboxGroupState extends State<CheckboxGroup> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//         children: widget.selections.map<Widget>((selection) {
//           return new CheckboxListTile(
//             title: new Text(selection['title']),
//             value: selection['selected'],
//             secondary: Text("\$2.55"),
//             onChanged: (bool value) {
//               setState(() {
//                 selection['selected']= value;
//               });
//             },
//           );
//         }).toList(),
//       );
//   }
// }