import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';

import '../../../../../widgets/drop_down_overlay.dart';
class DropDownFiltersDirect extends StatefulWidget {
  DropDownFiltersDirect({Key? key,required this.text,required this.textQuery,required this.onTap,required this.fontSize,this.fontWeight,this.widget}) : super(key: key);
  final String text;
  final String textQuery;
  final Function onTap;
  final double fontSize;
  final FontWeight? fontWeight;
  final Widget? widget;

  @override
  State<DropDownFiltersDirect> createState() => _DropDownFiltersDirectState();
}

class _DropDownFiltersDirectState extends State<DropDownFiltersDirect> {
  DropDownOverlay dropDownOverlay=DropDownOverlay();
  final LayerLink layerLink=LayerLink();
  double heightOverlay=90;
  double heightDropDownItem=90*SizeDefault.scaleHeight;

  void _sizing(){
    heightOverlay=20*SizeDefault.scaleHeight+20;
    dropDownOverlay.sHeightOverlay=heightOverlay;
    dropDownOverlay.sHeightDropDownItem=20*SizeDefault.scaleHeight;
  }
  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: layerLink,
      child: InkWell(
        onTap: (){
          _sizing();
          dropDownOverlay.showOverlay(
            context: context, 
            layerLink: layerLink,
            width: widget.textQuery.length*8*SizeDefault.scaleHeight+10*SizeDefault.scaleWidth,
            onTapBarrierDismissible: (){
              dropDownOverlay.hideOverlay();
            }, 
            widgetOverlay: wOverlay(context)
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color:ColorsDefault.colorBackgroud
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 2*SizeDefault.scaleWidth,vertical: 3*SizeDefault.scaleHeight),
          child: widget.widget??TextStandard(
            text: widget.text, 
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight??FontWeight.w400,
          )
        ),
      ),
    );
  }
  
  Widget wOverlay(BuildContext context) {
    return InkWell(
      onTap: (){
        dropDownOverlay.hideOverlay();
        widget.onTap();
      },
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 5*SizeDefault.scaleWidth),
        child: TextStandard(
          textAlign:TextAlign.center,
          text: widget.textQuery, 
          fontSize: widget.fontSize
        ),
      )
    );
  }
}