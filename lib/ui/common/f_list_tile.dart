import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';

import 'colors_default.dart';
import 'size_default.dart';
class FListTile extends StatefulWidget {
  FListTile({
    Key? key,
    required this.title,
    this.height,
    required this.onTap, 
    required this.colorText,
    this.widgetTrailing,
    this.errorText=""
  }) : super(key: key);
  final double? height;
  final String title;
  final Function onTap;
  final Color colorText;
  final Widget? widgetTrailing;
  final String errorText;
  @override
  State<FListTile> createState() => _FListTileState();
}

class _FListTileState extends State<FListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: ColorsDefault.colorSplashListTile.withOpacity(0.2),
          borderRadius: BorderRadius.circular(7),
          child: InkWell(
            borderRadius: BorderRadius.circular(7),
            splashColor: ColorsDefault.colorSplashListTile,
            onTap: (){
              widget.onTap();
            },
            child: Container(
              width: double.infinity,
              height: widget.height??SizeDefault.heightTextField,
              //color: !widget.isActivate?ColorsDefault.colorBackgroud:Colors.amber.shade100,
              padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalText),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  width: 1*SizeDefault.scaleHeight,
                  color: widget.errorText!=""?ColorsDefault.colorTextError:ColorsDefault.colorSplashListTile.withOpacity(0.2),
                )
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStandard(
                          text: widget.title, 
                          fontSize: SizeDefault.fSizeStandard,
                          color: ColorsDefault.colorText,
                        )
                      ],
                    ),
                  ),
                  widget.widgetTrailing??Container()
                ],
              ),
            ),
          ),
        ),
        widget.errorText!=""?TextError(textLabel: widget.errorText):Container()
      ],
    );
  }
}

class FListTileCommon extends StatefulWidget {
  FListTileCommon({
    Key? key,
    required this.title,
    this.subtitle,
    this.colorBackground,
    required this.onTap, 
    this.widgetTrailing,
    this.errorText="",
    this.height,
    this.colorTitle,
    this.fontWeightTitle,
    this.fontWeightSubtitle
  }) : super(key: key);
  final String? subtitle;
  final String title;
  final Color? colorBackground;
  final Function onTap;
  final Widget? widgetTrailing;
  final String errorText;
  final double? height;
  final Color? colorTitle;
  final FontWeight? fontWeightTitle;
  final FontWeight? fontWeightSubtitle;
  @override
  State<FListTileCommon> createState() => _FListTileCommonState();
}

class _FListTileCommonState extends State<FListTileCommon> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: widget.colorBackground??ColorsDefault.colorBackgroud,
          child: InkWell(
            splashColor: ColorsDefault.colorBackgroud,
            onTap: (){
              widget.onTap();
            },
            child: Container(
              width: double.infinity,
              height: widget.height??60*SizeDefault.scaleHeight,
              
              //color: !widget.isActivate?ColorsDefault.colorBackgroud:Colors.amber.shade100,
              padding: EdgeInsets.symmetric(horizontal: 12*SizeDefault.scaleWidth),
              
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextStandard(
                          text: widget.title, 
                          fontSize: SizeDefault.fSizeListTileTitle,
                          color: widget.colorTitle??ColorsDefault.colorTextListTileTitle,
                          fontWeight: widget.fontWeightTitle??FontWeight.w500,
                        ),
                        widget.subtitle!=null
                        ?Column(
                          children:[
                            SizedBox(height:7*SizeDefault.scaleHeight),
                            TextStandard(
                              text: widget.subtitle!, 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: widget.colorTitle??ColorsDefault.colorTextListTileSubtitle,
                              fontWeight:widget.fontWeightSubtitle?? FontWeight.w400,
                            )
                          ]
                        ):SizedBox()
                      ],
                    ),
                  ),
                  widget.widgetTrailing??Container()
                ],
              ),
            ),
          ),
        ),
        widget.errorText!=""?TextError(textLabel: widget.errorText):Container()
      ],
    );
  }
}

class FListTileFull extends StatefulWidget {
  FListTileFull({
    Key? key,
    this.colorBackground,
    required this.onTap, 
    this.onLongPress,
    this.widgetLeading,
    required this.widgetContent,
    this.widgetTrailing,
    this.height
  }) : super(key: key);
  final Color? colorBackground;
  final Function onTap;
  final Function? onLongPress;
  final Widget? widgetLeading;
  final Widget widgetContent;
  final Widget? widgetTrailing;
  final double? height;
  @override
  State<FListTileFull> createState() => _FListTileFullState();
}

class _FListTileFullState extends State<FListTileFull> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: widget.colorBackground??ColorsDefault.colorBackgroud,
          child: InkWell(
            splashColor: ColorsDefault.colorBackgroud,
            onTap: (){
              widget.onTap();
            },
            onLongPress: (){
              if(widget.onLongPress!=null) widget.onLongPress!();
            },
            child: Container(
              width: double.infinity,
              height: widget.height??60*SizeDefault.scaleHeight,
              alignment: Alignment.centerLeft,
              //color: !widget.isActivate?ColorsDefault.colorBackgroud:Colors.amber.shade100,
              padding: EdgeInsets.symmetric(horizontal: 12*SizeDefault.scaleWidth),
              
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  widget.widgetLeading??SizedBox(),
                  widget.widgetContent,
                  widget.widgetTrailing??SizedBox()
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

