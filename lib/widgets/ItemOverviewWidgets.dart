import 'package:flutter/material.dart';
import '../constants.dart';

const imgUrl =
    "https://cdn.vox-cdn.com/thumbor/d0jfYnyJ79WTE51N-nNbq8mBJMg=/896x473:7792x5502/1200x800/filters:focal(3649x2201:5039x3591)/cdn.vox-cdn.com/uploads/chorus_image/image/65731015/cz4jwpcaqabnupumbhji.0.jpg";
const title = 'Burger Angus Original';
const description =
    'Whether spicy or mild, our Bonafide Chicken is marinated for at least 12 hours, then hand-battered, hand-breaded and bursting with bold Louisiana flavour.';

Map sections = {
  '8778': {
    'max': 0,
    'title': 'Breakfast',
    'type': 'Checkbox',
    'order': 3,
    'selections': {
      '7888': {'price': 2, 'title': 'Medium Hashbrowns'},
      '8939': {'title': 'Large Hashbrowns', 'price': 3}
    }
  },
  '8779': {
    'max': 2,
    'min': 1,
    'title': 'Lunch',
    'type': 'Checkbox',
    'order': 1,
    'selections': {
      '7888': {'price': 2, 'title': 'Medium Hashbrowns'},
      '8939': {'title': 'Large Hashbrowns', 'price': 3}
    }
  },
  '8378': {
    'max': 2,
    'min': 0,
    'title': 'Dinner',
    'type': 'Radio',
    'order': 2,
    'selections': {
      '7888': {'price': 2, 'title': 'Medium Hashbrowns'},
      '8939': {'title': 'Large Hashbrowns', 'price': 3}
    }
  },
  '8478': {
    'max': 2,
    'min': 0,
    'title': 'Breakfast',
    'type': 'Radio',
    'selections': {
      '7888': {'price': 2, 'title': 'Medium Hashbrowns'},
      '8939': {'title': 'Large Hashbrowns', 'price': 3}
    }
  }
};

class ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        imgUrl.isNotEmpty ? ItemImage() : Spacer(),
        ItemTitle(),
        if (description.isNotEmpty) ItemDescription(),
      ],
    );
  }
}

class Spacer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child:
            Container(height: 56, width: double.infinity, color: Colors.white),
      ),
    );
  }
}

class ItemImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      child: Image.network(
        imgUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
            left: kLeftPadding, right: kRightPadding, top: 15, bottom: 5),
        child: Text(
          title,
          style: TextStyle(
              color: kMainColor, fontSize: 25, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

class ItemDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
            left: kLeftPadding, right: kRightPadding, top: 5, bottom: 15),
        child: Text(
          description,
          style: TextStyle(
              color: kMainColor, fontSize: 15, fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}

class ItemAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      //Place it at the top, and not use the entire screen
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        backgroundColor: Colors.transparent, //No more green
        elevation: 0.0, //Shadow gone
        leading: new IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent, // makes highlight invisible too
          icon: Image.asset(
            'assets/images/backButton.png',
            height: 35.0,
            width: 35.0,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}

class AddToCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        color: Colors.red,
        child: Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            color: Colors.white,
            width: double.infinity,
            height: kBottomButtonContainerHeight,
            child: Container(
              margin: const EdgeInsets.only(
                  bottom: kButtonContainerMargin,
                  left: kButtonContainerMargin,
                  right: kButtonContainerMargin),
              child: MaterialButton(
                color: kMainColor,
                onPressed: () => {printObject()},
                child: Stack(
                  children: <Widget>[
                    Align(
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      alignment: Alignment.center,
                    ),
                    Align(
                      child: Text('\$14.95',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.white)),
                      alignment: Alignment.centerRight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

void printObject() {}

List convertSectionMapIntoArray(map) {
  List sectionArray = [];
  map.forEach((id, section) {
    section['id'] = id;
    sectionArray.add(section);
  });
  sectionArray = sortArray(sectionArray);
  return sectionArray;
}

List convertSelectionMapIntoArray(map) {
  List selectionArray = [];
  map.forEach((id, selection) {
    selection['id'] = id;
    selection['selected'] = false;
    selectionArray.add(selection);
  });
  selectionArray = sortArray(selectionArray);
  return selectionArray;
}

class Header extends StatelessWidget {
  Header({this.section});
  final section;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          color: kSectionColor,
          padding: EdgeInsets.only(left: kLeftPadding, right: kRightPadding),
          height: 65,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(
                    section['title'],
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kMainColor),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  getSectionSubHeader(section),
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: kMainColor),
                ),
              )
            ],
          )),
    );
  }
}



class Selection extends StatelessWidget {
  Selection({this.selection});
  final selection;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      color: Colors.red,
    );
  }
}


class Section extends StatelessWidget {
  Section({this.section, this.selectedList});
  final section;
  final selectedList;

  @override
  Widget build(BuildContext context) {
    final String type = section['type'] ?? "Radio";
    final selections = section['selections'];
    final sectionId = section['id'];
    return Column(children: <Widget>[
    Header(section: section),
    if (selections != null) SelectionGroup(selectedList: selectedList, sectionId: sectionId, type: type, selections: convertSelectionMapIntoArray(selections)),
    // if (selections != null) if (type=="Radio") TimePreferencesWidget(sectionId: sectionId, selections: convertSelectionMapIntoArray(selections))
    ],);  
  }
}





String getSectionSubHeader(section) {
  var min = section['min'] ?? 0;
  var max = section['max'];
  String requiredText = min > 0 ? "Required" : "Optional";
  String conditionText = "";

  if (max != null) {
    if (min == max && max != 0)  {
      conditionText = "- Choose $max";
    } else if (max > min && min == 0) {
      conditionText = "- Choose up to $max";
    } else if (max > min && min > 0) {
      conditionText = "- Choose $min to $max";
    } else if (max != 0){
      conditionText = "- Choose up to $max";
    } else {
    if (section['selections'] != null) {
        var selectionLength = section['selections'].length;
        conditionText = "- Choose up to $selectionLength";
    }
    }
  } else {
    if (section['selections'] != null) {
        var selectionLength = section['selections'].length;
        conditionText = "- Choose up to $selectionLength";
    }
  }
  return '$requiredText $conditionText';
}

List sortArray(map) {
  map.sort((a, b) {
    return a['order']
        .toString()
        .toLowerCase()
        .compareTo(b['order'].toString().toLowerCase());
  });
  return map;
}

class ItemBody extends StatelessWidget {
  ItemBody({this.selectedList});
  final selectedList;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ItemHeader(),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              ...convertSectionMapIntoArray(sections)
                  .map((section) => Section(section: section, selectedList:selectedList)),
              ItemCounter()
            ],
          ),
        ),
      ],
    ));
  }
}


class ItemCounter extends StatefulWidget {
  @override
  _ItemCounterState createState() => _ItemCounterState();
}


class _ItemCounterState extends State<ItemCounter> {
 int _defaultValue =1;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        
        child: Stack(alignment: Alignment.center, children: <Widget>[
        Icon(Icons.remove, color: kMainColor,), 
        counterButtonContainer()
      ],) , onTap: () {
        if (_defaultValue > 1) {
         setState(() {
           _defaultValue =_defaultValue - 1;
         }); 
        }
      }),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('$_defaultValue', style: TextStyle(color: kMainColor),),
      ),
      
      
      
      InkWell( 
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        
        child: Stack( alignment: Alignment.center,
        children: <Widget> [
          counterButtonContainer(), 
          Icon(Icons.add, color: kMainColor,)
        ]), onTap: () {
        setState(() {
                _defaultValue = _defaultValue +1;
        });
      })
      ]),
    );
}

  Container counterButtonContainer() {
    return Container(width: 50, 
      height: 50, 
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: kMainColor, width: 2)));
  }
}


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
        return Container(
          height: 65,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              SelectionContainer(type: widget.type, selection: selection, radioSelected: radioSelected),
              InkWell(
                child: Container(height: 65, width: double.infinity),
                
                // highlightColor: Colors.transparent,
                // splashColor: Colors.transparent,
                  onTap: () {
                    setState(() {
                      if (widget.type == 'Checkbox') selectCheckBox(widget.sectionId, widget.selections, selection, widget.selectedList);
                      if (widget.type == 'Radio') selectRadio(widget.sectionId, selection, widget.selectedList);
                    });
                  },
                  )          ],
          ),
        );
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



class SelectionContainer extends StatelessWidget {
  SelectionContainer({this.selection, this.radioSelected, this.type});
  final selection;
  final radioSelected;
  final type;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
      onChanged: (bool value) {
        print("hello");
      },
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