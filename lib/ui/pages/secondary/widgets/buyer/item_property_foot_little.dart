import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;

import '../../../../common/texts.dart';
class ItemPropertyFootLittle extends StatefulWidget {
  final PropertyTotal propertyTotal;
  ItemPropertyFootLittle({Key? key,required this.propertyTotal}) : super(key: key);

  @override
  _ItemPropertyFootLittleState createState() => _ItemPropertyFootLittleState();
}

class _ItemPropertyFootLittleState extends State<ItemPropertyFootLittle> {
  double _fontSizePrice=17*SizeDefault.scaleHeight;
  double _fontSizePriceLowered=13*SizeDefault.scaleHeight;
  double _fontSizeSecond=10*SizeDefault.scaleHeight;
  double _fontSizeThird=9*SizeDefault.scaleHeight;
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
       child: Row(
         //crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment:MainAxisAlignment.spaceBetween,
         children: [
           Container(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Align(
                   alignment: Alignment.centerLeft,
                   child: 
                   _wPrice()
                 ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextStandard(
                        text:"${widget.propertyTotal.propertyInternal.bedroomsNumber.toString()} ",
                        fontSize: _fontSizeSecond,
                        fontWeight: FontWeight.w600,
                      ),
                      Tooltip(
                        showDuration: Duration(seconds: 1),
                        waitDuration: Duration(milliseconds: 10),
                        message: "Dormitorios",
                        child: iconc.FaIcon(iconc.FontAwesomeIcons.bed,size: 12*SizeDefault.scaleHeight),
                      ),  
                      TextStandard(
                        text:" | ${(widget.propertyTotal.property.price/widget.propertyTotal.property.landSurface).floor()} ",
                        fontSize: _fontSizeSecond,
                        fontWeight: FontWeight.w600,
                      ),
                      Tooltip(
                        showDuration: Duration(seconds: 1),
                        waitDuration: Duration(milliseconds: 10),
                        message: "Dólares por metro cuadrado",
                        child: TextStandard(
                          text:"DPM",
                          fontSize: _fontSizeSecond,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextStandard(
                        text:" | ${widget.propertyTotal.property.landSurface.toString()}m2 ",
                        fontSize: _fontSizeSecond,
                        fontWeight: FontWeight.w600,
                      ),
                      Tooltip(
                        showDuration: Duration(seconds: 1),
                        waitDuration: Duration(milliseconds: 10),
                        message: "Superficie terreno",
                        child: iconc.FaIcon(iconc.FontAwesomeIcons.vectorSquare,size: 12*SizeDefault.scaleHeight),
                      ),
                    ],
                  ),
                ),
                
                Row(
                  children: [
                    TextStandard(
                      text:"${widget.propertyTotal.property.address} | ${widget.propertyTotal.property.zoneName} | ${widget.propertyTotal.property.city}",
                      fontSize: _fontSizeThird,
                    ),
                  ],
                ),
               ],
             ),
           ),
         ],
       )
    );
  }

 Widget _wPrice() {
    final property=widget.propertyTotal.property;
    return Row(
      children: [
        TextStandard(
          text:"${property.price.toString()}"+r"$",
          fontSize: _fontSizePrice,
          fontWeight: FontWeight.w600
        ),
        property.pricesHistory.length>1?(property.pricesHistory[property.pricesHistory.length-1]<
        property.pricesHistory[property.pricesHistory.length-2]?
        Row(
          children: [
            SizedBox(width: 10*SizeDefault.scaleWidth,),
            TextStandard(
              text:"${property.pricesHistory[property.pricesHistory.length-2].toString()}"+r"$",
              fontSize: _fontSizePriceLowered,
              fontWeight: FontWeight.w500,
              textDecoration: TextDecoration.lineThrough,
              color: ColorsDefault.colorTextError
            ),
          ],
        ):SizedBox()):SizedBox()
      ],
    );
  }
}