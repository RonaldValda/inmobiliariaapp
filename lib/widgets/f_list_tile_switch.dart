import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';

import '../ui/common/colors_default.dart';
class FListTileSwitch extends StatefulWidget {
  FListTileSwitch({
    Key? key,
    required this.title,
    this.subtitle="",
    required this.value,
    required this.onChanged,
    this.isLeadingVisible=false,
    this.leading
  }) : super(key: key);
  final String title;
  final String subtitle;
  final bool value;
  final Function onChanged;
  final bool isLeadingVisible;
  final leading;

  @override
  State<FListTileSwitch> createState() => _FListTileSwitchState();
}

class _FListTileSwitchState extends State<FListTileSwitch> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorsDefault.colorBackgroud,
      child: InkWell(
        child: Container(
          width: double.infinity,
          height: 50*SizeDefault.scaleHeight,
          padding: widget.isLeadingVisible?EdgeInsets.only(right: SizeDefault.paddingHorizontalText) :EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalText),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:[
              if(widget.isLeadingVisible)
              widget.leading??Container(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStandard(
                      text: widget.title, 
                      fontSize: SizeDefault.fSizeStandard,
                      fontWeight: FontWeight.w300,
                    ),
                    if(widget.subtitle!="")
                    TextStandard(
                      text: widget.subtitle, 
                      fontSize: 14*SizeDefault.scaleHeight,
                      color: ColorsDefault.colorTextInfo,
                      fontWeight: FontWeight.w300,
                    ),
                  ],
                ),
              ),
              Transform.scale(
                alignment: Alignment.centerRight,
                scale: 0.8,
                child: CupertinoSwitch(
                  activeColor: ColorsDefault.colorPrimary,
                  value: widget.value, 
                  onChanged: (x){
                    widget.onChanged(x);
                  }
                ),
              ),
            ]
          ),
        ),
      )
    );
  }
}