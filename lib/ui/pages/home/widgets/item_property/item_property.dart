import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/item_property_header.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/item_property_images.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:provider/provider.dart';
import 'item_property_foot.dart';
class ItemProperty extends StatefulWidget {
  final PropertyTotal propertyTotal;
  final int index;
  ItemProperty({Key? key,required this.propertyTotal,required this.index}) : super(key: key);

  @override
  _ItemPropertyState createState() => _ItemPropertyState();
}

class _ItemPropertyState extends State<ItemProperty> {
  bool verticalMode=false;
  Color _colorPro=Color.fromARGB(255, 75, 146, 227);
  Color _colorPro360=Color.fromRGBO(212, 175, 55, 1);
  Color _colorFree=Color.fromRGBO(236, 236, 236, 1);
  @override
  Widget build(BuildContext context) {
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context);
    if(widgetStatusProvider.seeMap){
      verticalMode=true;
    }else{
      if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
        verticalMode=true;
      }else{
        verticalMode=false;
      }
    }
    final String category=widget.propertyTotal.property.category;
    return Card(
      semanticContainer: true,
      borderOnForeground: false,
      elevation: 2,
      margin: EdgeInsets.all(5*SizeDefault.scaleWidth),
      shadowColor:  category=="Pro360"?_colorPro360:category=="Pro"?_colorPro:_colorFree,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: category=="Pro360"?_colorPro360:category=="Pro"?_colorPro:_colorFree,
          width: 2*SizeDefault.scaleWidth
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
            alignment: AlignmentDirectional.topCenter,
            padding: EdgeInsets.all(2*SizeDefault.scaleWidth),
            child: verticalMode
            ?Column(
              children: [
                ItemPropertyHeader(propertyTotal: widget.propertyTotal,index: widget.index),
                ItemPropertyImages(propertyTotal: widget.propertyTotal,index: widget.index),
                ItemPropertyFoot(propertyTotal: widget.propertyTotal,index: widget.index)
              ],
            ):Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  children: [
                    ItemPropertyHeader(propertyTotal: widget.propertyTotal,index: widget.index),
                    ItemPropertyImages(propertyTotal: widget.propertyTotal,index: widget.index),
                  ],
                ),
                ItemPropertyFoot(propertyTotal: widget.propertyTotal,index: widget.index)
              ],
            ),
          ),
        ]
      ),
    );
  }
}


