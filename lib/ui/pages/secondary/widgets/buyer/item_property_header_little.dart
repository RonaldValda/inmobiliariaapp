import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';

import '../../../../../domain/entities/user.dart';
import '../../../../common/colors_default.dart';
import '../../../../common/texts.dart';
import 'item_property_images_little.dart';
class ItemPropertyHeaderLittle extends StatefulWidget {
  ItemPropertyHeaderLittle({Key? key,required this.propertyTotal}) : super(key: key);
  final PropertyTotal propertyTotal;
  @override
  _ItemPropertyHeaderLittleState createState() => _ItemPropertyHeaderLittleState();
}

class _ItemPropertyHeaderLittleState extends State<ItemPropertyHeaderLittle> {
  double imagenHeight=0;
  double imagenWidth=0;
  bool isVertical=true;
  double _fontSizeRequest=9*SizeDefault.scaleHeight;
  @override
  Widget build(BuildContext context) {
    _fontSizeRequest=9*SizeDefault.scaleHeight;
    if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      isVertical=true;
      imagenWidth=MediaQuery.of(context).size.width;
      imagenHeight=imagenWidth*0.7;
    }else{
      isVertical=false;
      imagenHeight=MediaQuery.of(context).size.height*.8;
      imagenWidth=imagenHeight+imagenHeight*0.3;
    }
    return Container(
      color:Colors.transparent,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _wAgency(widget.propertyTotal.creator),
            ],
          ),
          ItemPropertyImagesLittle(propertyTotal: widget.propertyTotal),
        ],
      ),
    );
  }
  Container _wAgency(User creator) {
    return Container(
      height: 13*SizeDefault.scaleHeight,
      padding:EdgeInsets.only(left: 10*SizeDefault.scaleWidth,right: 10*SizeDefault.scaleWidth,),
      child: creator.verified
      ?TextStandard(
        text:creator.agencyName!=""?
        "${creator.agencyName} -> Verificado":"${creator.namesSurnames} -> Verificado",
        fontSize: _fontSizeRequest,
        color: ColorsDefault.colorTextApproved,fontWeight: FontWeight.w600,
      ):TextStandard(
        text: "No verificado",
        fontSize: _fontSizeRequest,
        color: ColorsDefault.colorTextError,fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color:ColorsDefault.colorBackgroundRequestStatus,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomRight:Radius.circular(20)),
      ),
    );
  }
}