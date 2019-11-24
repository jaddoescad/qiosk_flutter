import 'package:flutter/material.dart';
import 'package:iamrich/constants.dart';

class SelectionGroup extends StatefulWidget {
  SelectionGroup({this.selections, this.sectionId, this.type, this.selectedList});
  final selections;
  final sectionId;
  final type;
  final selectedList;

  @override
  SelectionGroupState createState() => new SelectionGroupState();
}

class SelectionGroupState extends State<SelectionGroup> {
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
                if (widget.type == 'Checkbox') selectCheckBox(widget.sectionId, widget.selections, selection, widget.selectedList);
                if (widget.type == 'Radio') selectRadio(widget.sectionId, selection, widget.selectedList);
              });
            },
            child: new SelectionContainer(type: widget.type, selection: selection, radioSelected: radioSelected));
      }).toList(),
    );
  }

  selectRadio(sectionId, selection, selectedList) {
    radioSelected = selection['id'];
    selectedList[sectionId] = selection;
    
  }
}

void selectCheckBox(sectionId, selections, selection, selectedList){
  selection['selected'] = !selection['selected'];
  //loop thru selections and return array of section_id and selection_id
  var checkSelected = selections.where((selection) {
    return selection['selected'] == true ;
  }).toList();
  selectedList[sectionId] = checkSelected;
  print(selectedList);
}

void selectRadio(radioSelected, selection) {
// radioSelected = selection['id'];
// selectedList[sectionId] = selections[radioSelected];
// print(selectedList);
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