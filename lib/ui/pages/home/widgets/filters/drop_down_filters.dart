import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/widgets/drop_down_overlay.dart';

class DropDownFilters extends StatefulWidget {
  DropDownFilters({
    Key? key,
    required this.attribute,
    required this.mapData,
    required this.mapFilter,
    required this.onChanged,
    required this.text,
    this.dropDownItemsCount=4
  }) : super(key: key);
  final String attribute;
  final Map<String,dynamic> mapData;
  final Map<String,dynamic> mapFilter;
  final Function onChanged;
  final String text;
  final int dropDownItemsCount;
  
  @override
  State<DropDownFilters> createState() => _DropDownFiltersState();
}

class _DropDownFiltersState extends State<DropDownFilters> {
  final LayerLink layerLink=LayerLink();
  double heightOverlay=40;
  double heightDropDownItem=40*SizeDefault.scaleHeight;
  DropDownOverlay dropDownOverlay=DropDownOverlay();
  @override
  void initState() {
    super.initState();
  }
  void sizingOverlay(int length){
    heightOverlay=length<widget.dropDownItemsCount?heightDropDownItem*length+20:heightDropDownItem*widget.dropDownItemsCount+20;
    dropDownOverlay.sHeightOverlay=heightOverlay;
    dropDownOverlay.sHeightDropDownItem=heightDropDownItem;
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: TextStandard(text: widget.text,fontSize: SizeDefault.fSizeStandard,fontWeight:FontWeight.w300,)),
        CompositedTransformTarget(
          link: layerLink,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  sizingOverlay(widget.mapData[widget.attribute].length);
                  dropDownOverlay.showOverlay(
                    context: context, 
                    layerLink: layerLink,
                    width: 130*SizeDefault.scaleWidth,
                    onTapBarrierDismissible: (){
                      dropDownOverlay.hideOverlay();
                    }, 
                    widgetOverlay: wOverlay(context)
                  );
                },
                child: Container(
                  width: 130*SizeDefault.scaleWidth,
                  height: SizeDefault.heightDropDown,
                  decoration: BoxDecoration(
                    color:ColorsDefault.colorTextFieldBackground,
                    borderRadius: BorderRadius.circular(7),
                    border: Border.all(
                      width: 1*SizeDefault.scaleHeight,
                      color: ColorsDefault.colorPrimary
                    )
                  ),
                  //decoration: accountState.selectedValues[widget.attribute]==""?Styles.boxDecorationDropDown2:Styles.boxDecorationDropDownSelected2,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalText),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: wDropDownItem(widget.mapFilter[widget.attribute+"_sel"])
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
            ],
          ),
        ),
      ],
    );
  }

  Column wOverlay(BuildContext context) {
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
              itemCount: widget.mapData[widget.attribute].length,
              itemBuilder: (context,index){
                final e=widget.mapData[widget.attribute][index];
                return InkWell(
                  onTap: (){
                    setState(() {
                      widget.onChanged(e);
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