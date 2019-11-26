import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';

Future<Item> fetchSelection(itemFromMenu) async {
    final response = await rootBundle.loadString('assets/mock/Item.json').then((itemData) {
    return itemData;
  });

  return Item.fromSelectionJson(json.decode(response), itemFromMenu);
}


class Item {
  final String id;
  final double basePrice;
  final String title;
  final String description;
  final String imgUrl;
  final List<Section> sections;

  Item({@required this.id,this.basePrice = 0, @required this.title, this.description, this.imgUrl, this.sections});

  factory Item.fromSelectionJson(Map<String,dynamic> json, Item itemFromMenu) {
    getSection(json['sections']);
    return Item(
      id: itemFromMenu.id,
      basePrice: itemFromMenu.basePrice,
      title: itemFromMenu.title,
      description: itemFromMenu.description,
      imgUrl: itemFromMenu.imgUrl,
      sections: getSection(json['sections'])
    );
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

  Section({@required this.id, this.max, this.min = 0,@required this.title, this.type, this.selections, this.order});

String getSectionConditionString() {
  var min = this.min ?? 0;
  var max = this.max;
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