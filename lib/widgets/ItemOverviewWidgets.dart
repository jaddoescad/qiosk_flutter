import 'package:flutter/material.dart';
import 'package:iamrich/models/Item.dart';
import 'package:iamrich/models/cart.dart';
import 'package:iamrich/widgets/addCart.dart';
import 'package:provider/provider.dart';
import '../constants.dart';



class ItemHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    return Column(
      children: <Widget>[
        item.imgUrl.isNotEmpty ? ItemImage(imgUrl: item.imgUrl) : ItemSelectionSpacer(),
        ItemTitle(title: item.title),
        if (item.description.isNotEmpty) ItemDescription(description: item.description),
      ],
    );
}
  }

class ItemSelectionSpacer extends StatelessWidget {
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
  ItemImage({this.imgUrl});
  final imgUrl;
  @override
  Widget build(BuildContext context) {
      return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(imgUrl),
      ),
      ),
    );
  }
}

class ItemTitle extends StatelessWidget {
  ItemTitle({this.title});
  final title;
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
  ItemDescription({this.description});
  final description;

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

class SelectionCartButton extends StatelessWidget {

  @override

  Widget build(BuildContext context) {
    
    final item = Provider.of<Item>(context);
    final buttonTextColor = !item.disableCart ? Colors.white : Color(0xFF879FB0);


    return Container(
      height: 70,
      padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(
            color: Colors.grey,
            blurRadius: 6.0,
          ),
          ]
      ),
      child: RaisedButton(
        disabledColor: kMainColor,
        child: CartButtonChildren(title: "Add To Cart", price: item.totalPrice.toStringAsFixed(2), color: buttonTextColor),
        // Text('Add To Cart \$ ${item.totalPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 15, color: buttonTextColor),),
        color: Color(0xFF365e7a),
        onPressed: item.disableCart ? null : () => {addtocart(context)},
      ),
    );
  }

    void addtocart(context) {
    final cart = Provider.of<Cart>(context);
    final item = Provider.of<Item>(context);

    cart.addItem(item.id, item.totalPrice, item.title, item.itemCount, item.selections);
    Navigator.of(context).pop();
  }

}

// class AddToCartButton extends StatelessWidget {

//   @override
//   Widget build(BuildContext context) {
//     final item = Provider.of<Item>(context);
//     final buttonTextColor = !item.disableCart ? Colors.white : Colors.grey;
//     return Container(
//         width: double.infinity,
//         color: Colors.red,
//         child: Align(
//           alignment: FractionalOffset.bottomCenter,
//           child: Container(
//             color: Colors.white,
//             width: double.infinity,
//             height: kBottomButtonContainerHeight,
//             child: Container(
//               margin: const EdgeInsets.only(
//                   bottom: kButtonContainerMargin,
//                   left: kButtonContainerMargin,
//                   right: kButtonContainerMargin),
//               child: MaterialButton(
//                 color: kMainColor,
//                 disabledColor: kMainColor,
//                 onPressed: item.disableCart ? null : () => {addtocart(context)},
//                 child: Stack(
//                   children: <Widget>[
//                     Align(
//                       child: Text(
//                         'Add To Cart',
//                         style: TextStyle(
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16,
//                             color: buttonTextColor),
//                       ),
//                       alignment: Alignment.center,
//                     ),
//                     Align(
//                       child: Text('\$ ${item.totalPrice.toStringAsFixed(2)}',
//                           style: TextStyle(
//                               fontWeight: FontWeight.w400,
//                               fontSize: 14,
//                               color: buttonTextColor)),
//                       alignment: Alignment.centerRight,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ));
//   }




void printObject() {}

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
                    section.title,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: kMainColor),
                  )),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  section.getSectionConditionString(),
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

class Section extends StatelessWidget {

  Section({this.section});
  final section;


  @override
  Widget build(BuildContext context) {
    final String type = section.type ?? "Radio";
    final selections = section.selections;
    return Column(children: <Widget>[
    Header(section: section),
    if (selections != null) SelectionGroup(type: type, section: section),
    ],);  
  }
}

class ItemBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
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
              ...item.sections.map((section) => Section(section: section)),
              ItemCounter()
            ],
          ),
        ),
      ],
    ));
  }
}


class ItemCounter extends StatelessWidget{
//  int _defaultValue =1;
  @override
  Widget build(BuildContext context) {
    final Item item = Provider.of<Item>(context);

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
        item.decrement();
      }),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('${item.itemCount}', style: TextStyle(color: kMainColor),),
      ),
      InkWell( 
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        
        child: Stack( alignment: Alignment.center,
        children: <Widget> [
          counterButtonContainer(), 
          Icon(Icons.add, color: kMainColor,)
        ]), onTap: () {
          item.increment();
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



class SelectionGroup extends StatelessWidget{

  SelectionGroup({this.type, this.section});
  final section;
  final type;
  @override
  Widget build(BuildContext context) {
    final item = Provider.of<Item>(context);
    return Column(
      children: section.selections.map<Widget>((selection) {
        return Container(
          height: 65,
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              SelectionContainer(type: type, selection: selection, section: section),
              InkWell(                
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                  onTap: () {
                    if (type == 'Checkbox') item.selectCheckbox(selection);
                    if (type == 'Radio') item.selectRadio(selection, section);

                    // setState(() {
                      // if (widget.type == 'Checkbox') selectCheckBox(selection);
                      // if (widget.type == 'Radio') radioSelected = selectRadio(selection, widget.selections);
                    // });
                  },
                  )],
          ),
        );
      }).toList(),
    );
  }
}



  



class SelectionContainer extends StatelessWidget {
  SelectionContainer({this.selection, this.section, this.type});
  final selection;
  final section;
  final type;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(alignment: Alignment.centerRight, child: Padding(
          padding: const EdgeInsets.all(18),
          child: Text('\$ ${selection.price.toString()}', style: TextStyle(fontSize: 16, color: kMainColor),),
        )),
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              (type == 'Checkbox') ? SingleCheckbox(selection: selection) : SingleRadio(section: section,selection: selection),
              Text(selection.title, style: TextStyle(fontSize: 16, color: kMainColor)),
            ],
          ),
        ),
      ],
    );
  }
}

class SingleCheckbox extends StatelessWidget {
  SingleCheckbox({this.selection});
  final selection;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: selection.selected,
      onChanged: (bool value) {
      },
    );
  }
}

class SingleRadio extends StatelessWidget {
  SingleRadio({this.section, this.selection});
  final section;
  final selection;

  @override
  Widget build(BuildContext context) {
    return Radio(
      groupValue: section.radioSelected,
      value: selection.id,
      onChanged: (selected) {},
    );
  }
}
