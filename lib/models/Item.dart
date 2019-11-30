import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

Future fetchSelection() async {
    final response = await rootBundle.loadString('assets/mock/Item.json').then((itemData) {
    return itemData;
  });

  return json.decode(response);
}


class Item extends ChangeNotifier {
  String id;
  double basePrice;
  String title;
  String description;
  String imgUrl;
  List<Section> sections;
  int itemCount = 1;
  double selectionPrice = 0;
  bool disableCart = true;
  List selections = [];

  Item({this.id,this.basePrice = 0, this.title, this.description, this.imgUrl, this.sections});

  reset() {
    id = null;
    basePrice = 0;
    title = null;
    description = null;
    imgUrl = null;
    sections = null;
    itemCount = 1;
    selectionPrice = 0;
    disableCart = true;
  }
  

  checkIfItemMeetsAllConditions() {
    // var exitLoop = false;
    for (var section in sections) {
      final selectionsLength = (section.selections.where((i) => i.selected).toList()).length;
      if (section.type == "Radio") {
        if ( selectionsLength < 1 ) {
        disableCart = true;
        return;
        }
      } else if (section.min != null) {
        if (section.min > 0) {
        if (!(selectionsLength >= section.min)){
          disableCart = true;
          return;
        }
        }

      }
    }
    disableCart = false;
  }

  get totalPrice {
   return ((basePrice+selectionPrice)*itemCount);
  }

  void selectCheckbox(Selection selection) {
    selection.selected = !selection.selected;
    getTotalPrice();
    checkIfItemMeetsAllConditions();
    notifyListeners();
  }

  selectRadio(selection, section) {
    section.selections.map((_selection){
      _selection.selected = false;
    });
    selection.selected = true;
    section.radioSelected = selection.id;
    getTotalPrice();
    checkIfItemMeetsAllConditions();
    notifyListeners();
  }

  getTotalPrice() {
    List price = [];
    List selected = [];
    sections.map((section) {
      section.selections.map((selection){
          if (selection.selected) {
            selected.add(selection);
            selections = selected;
            if(selection.price != null) {
            price.add(selection.price);
          }
        }
      }).toList();
    }).toList();
    if (price.isNotEmpty) {
      selectionPrice = price.reduce((a, b) => a + b);
    } else {
      selectionPrice = 0;
    }

  }
  

  increment() {
    itemCount = itemCount + 1;
    getTotalPrice();
    notifyListeners();
  }

    
  decrement() {
    if (itemCount > 1) {
    itemCount = itemCount - 1;
    getTotalPrice();
    notifyListeners();
    }
  }

  
  fromSelectionJson(Map<String,dynamic> json, Item itemFromMenu) {

      id= itemFromMenu.id;
      basePrice = itemFromMenu.basePrice;
      title= itemFromMenu.title;
      description= itemFromMenu.description;
      imgUrl= itemFromMenu.imgUrl;
      sections= getSection(json['sections']);
  }

  static List<Section> getSection(sectionsJson) {
    List<Section> sectionArray = [];
    sectionsJson.forEach((final String id, final section) {
      sectionArray.add(Section(
        id: id.toString(), 
        max: section['max'] ,
        min: section['min'], 
        order: section['order'],
        type: section['type'], 
        title: section['title'],
        selections: getSelection(section['selections'])
        ));
    }); 
    sectionArray = sortArray(sectionArray);
    return sectionArray;
  }
    static List<Selection> getSelection(selectionsJson)  {
    List<Selection> selectionArray = [];
    selectionsJson.forEach((id, selection) {
      selectionArray.add(
        Selection(id: id.toString(), title: selection['title'], price: selection['price'].toDouble()));
    });
    selectionArray = sortArray(selectionArray);
    return selectionArray;
  }
    
static List sortArray(map) {
  map.sort((a, b) {
    return a.order
        .toString()
        .toLowerCase()
        .compareTo(b.order.toString().toLowerCase());
  });
  return map;
}
}

class Section {
  final String id;
  final int max;
  final int min;
  final String title;
  final int order;
  final String type;
  final List<Selection> selections;
  String radioSelected;

  Section({@required this.id, this.max, this.min = 0,@required this.title, this.type, this.selections, this.order});

String getSectionConditionString() {
  var min = this.min ?? 0;
  var max = this.max;
  var type = this.type;
  String requiredText = min > 0 ? "Required" : "Optional";
  String conditionText = "";

  if (type == "Radio"){
    requiredText = "Required";
    conditionText = "- Choose 1";
  }
  else if (max != null) {
    if (min == max && max != 0)  {
      conditionText = "- Choose $max";
    } else if (max > min && min == 0) {
      conditionText = "- Choose up to $max";
    } else if (max > min && min > 0) {
      conditionText = "- Choose $min to $max";
    } else if (max != 0){
      conditionText = "- Choose up to $max";
    } else {
    if (this.selections != null) {
        var selectionLength = this.selections.length;
        conditionText = "- Choose up to $selectionLength";
    }
    }
  } else {
    if (this.selections != null) {
        var selectionLength = this.selections.length;
        conditionText = "- Choose up to $selectionLength";
    }
  }
  return '$requiredText $conditionText';
}

}

class Selection {
  final String id;
  final double price;
  final String title;
  final int order;
  bool selected;
  Selection({@required this.id, this.price,@required this.title, this.order, this.selected = false});
}