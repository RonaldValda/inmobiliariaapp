import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/drop_down_overlay.dart';
import '../../../common/texts.dart';
class DropDownSelectableDataOverlay extends StatefulWidget {
  DropDownSelectableDataOverlay({
    Key? key,
    required this.attribute,
    required this.text,
    this.dropDownItemsCount=3
  }) : super(key: key);
  final String attribute;
  final String text;
  final int dropDownItemsCount;
  @override
  State<DropDownSelectableDataOverlay> createState() => _DropDownSelectableDataOverlayState();
}

class _DropDownSelectableDataOverlayState extends State<DropDownSelectableDataOverlay> {
  final LayerLink layerLink=LayerLink();
  double heightOverlay=45;
  double heightDropDownItem=45*SizeDefault.scaleHeight;
  DropDownOverlay dropDownOverlay=DropDownOverlay();
  @override
  void initState() {
    super.initState();
  }
  Color _colorEnabledBorder=ColorsDefault.colorBorder;
  void _selectConfig(bool selected,String errorText){
    if(selected){
      _colorEnabledBorder=errorText==""?ColorsDefault.colorPrimary:ColorsDefault.colorTextError;
    }else{
      _colorEnabledBorder=errorText==""?ColorsDefault.colorBorder:ColorsDefault.colorTextError;
    }
  }

  void _sizing(int length){
    heightOverlay=length<widget.dropDownItemsCount?heightDropDownItem*length+20:heightDropDownItem*widget.dropDownItemsCount+20;
    dropDownOverlay.sHeightOverlay=heightOverlay;
    dropDownOverlay.sHeightDropDownItem=heightDropDownItem;
  }
  @override
  Widget build(BuildContext context) {
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    _selectConfig(registrationPropertyProvider.mapSelectedData[widget.attribute]!="",registrationPropertyProvider.mapValidate[widget.attribute]);
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLabel(textLabel: widget.text),
          InkWell(
            onTap: (){
              _sizing(registrationPropertyProvider.mapSelectableData[widget.attribute].length);
              dropDownOverlay.showOverlay(
                context: context, 
                layerLink: layerLink,
                onTapBarrierDismissible: (){
                  dropDownOverlay.hideOverlay();
                }, 
                widgetOverlay: wOverlay(context)
              );
            },
            child: Container(
              width: double.infinity,
              height: SizeDefault.heightDropDown,
              decoration: BoxDecoration(
                color:ColorsDefault.colorTextFieldBackground,
                borderRadius: BorderRadius.circular(7),
                border: Border.all(
                  width: SizeDefault.widthBorderTextEnabled,
                  color: registrationPropertyProvider.mapSelectedData[widget.attribute]!=""
                  ?ColorsDefault.colorPrimary:
                  _colorEnabledBorder,
                )
              ),
              //decoration: accountState.selectedValues[widget.attribute]==""?Styles.boxDecorationDropDown2:Styles.boxDecorationDropDownSelected2,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalText),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  registrationPropertyProvider.mapSelectedData[widget.attribute]==""
                  ?TextHint(text: "Seleccione")
                  :Expanded(
                    child: wDropDownItem(registrationPropertyProvider.mapSelectedData[widget.attribute])
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    color: ColorsDefault.colorText,
                    size: 30*SizeDefault.scaleHeight,
                  ),
                ],
              ),
            ),
          ),
          registrationPropertyProvider.mapValidate[widget.attribute]!=""?TextError(textLabel: registrationPropertyProvider.mapValidate[widget.attribute]):Container()
        ],
      ),
    );
  }

  Column wOverlay(BuildContext context) {
    final registrationPropertyProvider=context.read<RegistrationPropertyProvider>();
    return Column(
      children: [
        Expanded(
          child: Scrollbar(
            radius: Radius.circular(20),
            trackVisibility: false,
            interactive: true,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              separatorBuilder: (context,index){
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15*SizeDefault.scaleWidth),
                  child: Container(
                    width:double.infinity,
                    height: 1*SizeDefault.scaleHeight,
                    color: ColorsDefault.colorSeparatedDropDownItem,
                  ),
                );
              },
              itemCount: registrationPropertyProvider.mapSelectableData[widget.attribute].length,
              itemBuilder: (context,index){
                final e=registrationPropertyProvider.mapSelectableData[widget.attribute][index];
                return InkWell(
                  onTap: (){
                    setState(() {
                      context.read<RegistrationPropertyProvider>().selectOption(widget.attribute, e);
                      dropDownOverlay.hideOverlay();
                    });
                    
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth),
                    child: wDropDownItem(e)
                  )
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Container wDropDownItem(String item) {
    return Container(
      width: double.infinity,
      height: heightDropDownItem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            item,
            style: GoogleFonts.notoSans(
              color: ColorsDefault.colorText,
              fontSize: SizeDefault.fSizeStandard
            ),
          ),
        ],
      )
    );
  }
}