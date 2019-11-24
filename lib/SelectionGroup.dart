import 'package:flutter/material.dart';
import 'package:iamrich/constants.dart';

class CheckboxGroup extends StatefulWidget {
  CheckboxGroup({this.selections, this.sectionId, this.type});
  final selections;
  final sectionId;
  final type;

  @override
  CheckboxGroupState createState() => new CheckboxGroupState();
}

class CheckboxGroupState extends State<CheckboxGroup> {
  var radioSelected;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.selections.map<Widget>((selection) {
        return InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
            onTap: () {
              setState(() {
                if (widget.type == 'Checkbox') selection['selected'] = !selection['selected'];
                if (widget.type == 'Radio') radioSelected = selection['id'];
              });
            },
            child: new SelectionContainer(type: widget.type, selection: selection, radioSelected: radioSelected));
      }).toList(),
    );
  }
}

class SelectionContainer extends StatelessWidget {
  SelectionContainer({this.selection, this.radioSelected, this.type});
  final selection;
  final radioSelected;
  final type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      width: double.infinity,
      child: Stack(
        children: <Widget>[
          Align(alignment: Alignment.centerRight, child: Padding(
            padding: const EdgeInsets.all(18),
            child: Text('\$ ${selection['price'].toString()}', style: TextStyle(fontSize: 16, color: kMainColor),),
          )),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: <Widget>[
                (type == 'Checkbox') ? SingleCheckbox(selection: selection) : SingleRadio(radioSelected: radioSelected, selection: selection),
                Text(selection['title'], style: TextStyle(fontSize: 16, color: kMainColor)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SingleCheckbox extends StatelessWidget {
  const SingleCheckbox({this.selection});
  final selection;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: selection['selected'],
      onChanged: (bool value) {},
    );
  }
}


class SingleRadio extends StatelessWidget {
  const SingleRadio({
    this.radioSelected,
    this.selection
  });

  final radioSelected;
  final selection;

  @override
  Widget build(BuildContext context) {
    return Radio(
      groupValue: radioSelected,
      value: selection['id'],
      onChanged: (selected) {},
    );
  }
}