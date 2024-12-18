import 'package:flutter/foundation.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/restaurant.dart';
import '../util/helper.dart';

Future<bool> fetchSelection(context, itemID) async {
  final restaurant = Provider.of<Restaurant>(context);
  final item = Provider.of<Item>(context, listen: false);

  var document = await Firestore.instance
      .collection('Restaurants')
      .document(restaurant.id)
      .collection('Selections')
      .document(itemID)
      .get();
  await Future.delayed(const Duration(milliseconds: 700), () {
    if (document.exists) {
      item.fromSelectionJson(document);
      item.checkIfItemMeetsAllConditions();
    } else {
      item.checkIfItemMeetsAllConditions();
    }
  });
  return true;
  // return document.data;
}

class Item extends ChangeNotifier {
  String id;
  double basePrice;
  String title;
  String description;
  String imgUrl;
  List<Section> sections = [];
  int itemCount = 1;
  double selectionPrice = 0;
  bool disableCart = true;
  List selections = [];

  Item(
      {this.id,
      this.basePrice = 0,
      this.title,
      this.description,
      this.imgUrl,
      this.sections});

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
    if (sections?.isNotEmpty ?? false) {
      for (var section in sections) {
        final selectionsLength =
            (section.selections.where((i) => i.selected).toList()).length;
        if (section.type == "Radio") {
          if (selectionsLength < 1) {
            disableCart = true;
            return;
          }
        } else if (section.min != null) {
          if (section.min > 0) {
            if (!(selectionsLength >= section.min)) {
              disableCart = true;
              return;
            }
          }
        }
      }
      disableCart = false;
    } else {
      disableCart = false;
    }
  }

  get totalPrice {
    return ((basePrice + selectionPrice) * itemCount);
  }

  void selectCheckbox(Selection selection, section) {
    if (!selection.disable) {
      selection.selected = !selection.selected;
      getTotalPrice();
      toggleCheckboxSection(section);
      checkIfItemMeetsAllConditions();
      notifyListeners();
    }
  }

  toggleCheckboxSection(Section section) {
    if (section.max != null) {
      if (getNumberofselections(section) == section.max) {
        blockSelections(section);
      } else if (getNumberofselections(section) < section.max) {
        unblockSelections(section);
      }
    }
  }

  int getNumberofselections(Section section) {
    int num = 0;
    for (var selection in section.selections) {
      if (selection.selected) {
        num = num + 1;
      }
    }
    return num;
  }

  blockSelections(Section section) {
    for (var selection in section.selections) {
      if (!selection.selected) {
        selection.disable = true;
      }
    }
  }

    unblockSelections(Section section) {
    for (var selection in section.selections) {
        selection.disable = false;
    }
  }

  selectRadio(selection, section) {
    section.selections.asMap().forEach((index, _selection) {
      section.selections[index].selected = false;
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
    if (sections?.isNotEmpty ?? false) {
      sections.map((section) {
        section.selections.map((selection) {
          if (selection.selected) {
            selected.add(selection);
            selections = selected;
            if (selection.price != null) {
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

  updateHeader(Item itemFromMenu) {
    id = itemFromMenu.id;
    basePrice = itemFromMenu.basePrice;
    title = itemFromMenu.title;
    description = itemFromMenu.description;
    imgUrl = itemFromMenu.imgUrl;
  }

  fromSelectionJson(json) {
    if (json.data?.containsKey('sections') ?? false) {
      sections = getSection(json.data['sections']);
    }
  }

  static List<Section> getSection(Map<dynamic, dynamic> sectionsJson) {
    List<Section> sectionArray = [];
    sectionsJson.forEach((final id, final section) {
      sectionArray.add(Section(
          id: id.toString(),
          max: section['max'],
          min: section['min'],
          order: section.containsKey('order') ? section['order'] : null,
          type: section['type'],
          title: section['title'],
          selections: getSelection(section['selections'])));
    });
    sectionArray = sortArray(sectionArray);
    return sectionArray;
  }

  static List<Selection> getSelection(Map<dynamic, dynamic> selectionsJson) {
    List<Selection> selectionArray = [];
    selectionsJson.forEach((id, selection) {
      selectionArray.add(Selection(
          id: id.toString(),
          order: selection.containsKey('order') ? selection['order'] : null,
          title: selection['title'],
          price: selection['price'].toDouble()));
    });
    selectionArray = sortArray(selectionArray);
    return selectionArray;
  }

  // static List sortArray(map) {
  //   // map.sort((a, b) {

  //   //   return (int.tryParse(a.order) ?? null).compareTo(int.tryParse(b.order) ?? null);
  //   // });
  //   return map;
  // }
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

  Section(
      {@required this.id,
      this.max,
      this.min = 0,
      @required this.title,
      this.type,
      this.selections,
      this.order});

  String getSectionConditionString() {
    var min = this.min ?? 0;
    var max = this.max;
    var type = this.type;
    String requiredText = min > 0 ? "Required" : "Optional";
    String conditionText = "";

    if (type == "Radio") {
      requiredText = "Required";
      conditionText = "- Choose 1";
    } else if (max != null) {
      if (min == max && max != 0) {
        conditionText = "- Choose $max";
      } else if (max > min && min == 0) {
        conditionText = "- Choose up to $max";
      } else if (max > min && min > 0) {
        conditionText = "- Choose $min to $max";
      } else if (max != 0) {
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
  bool disable;
  Selection(
      {@required this.id,
      this.price,
      @required this.title,
      this.order,
      this.selected = false,
      this.disable = false
      });
}
