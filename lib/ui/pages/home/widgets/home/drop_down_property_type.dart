import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/drop_down_overlay.dart';
import '../../../../common/colors_default.dart';
import '../../../../common/size_default.dart';

class DropDownPropertyType extends StatefulWidget {
  DropDownPropertyType({
    Key? key,
    this.dropDownItemsCount=7
  }) : super(key: key);
  final int dropDownItemsCount;
  @override
  State<DropDownPropertyType> createState() => _DropDownPropertyTypeState();
}

class _DropDownPropertyTypeState extends State<DropDownPropertyType> {
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
    final filterMainProvider=context.watch<FilterMainProvider>();
    final width=filterMainProvider.mapFilter["property_type"].length*8.3*SizeDefault.scaleHeight+30*SizeDefault.scaleHeight+SizeDefault.paddingHorizontalText/2+12*SizeDefault.scaleHeight;
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              filterMainProvider.initPropertyTypes();
              sizingOverlay(filterMainProvider.propertyTypes.length);
              dropDownOverlay.showOverlay(
                context: context, 
                layerLink: layerLink,
                width: 170*SizeDefault.scaleWidth,
                onTapBarrierDismissible: (){
                  dropDownOverlay.hideOverlay();
                }, 
                widgetOverlay: wOverlay(context)
              );
            },
            child: Container(
              width: width,
              height: SizeDefault.heightDropDown,
              decoration: BoxDecoration(
                color:ColorsDefault.colorBackgroud,
                border: Border(
                  bottom: BorderSide(
                    width: 1*SizeDefault.scaleHeight,
                    color: ColorsDefault.colorBorderBottomDropDownAppBar
                  ),
                )
              ),
              //decoration: accountState.selectedValues[widget.attribute]==""?Styles.boxDecorationDropDown2:Styles.boxDecorationDropDownSelected2,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: SizeDefault.paddingHorizontalText/2),
              child: Stack(
                children: [
                  Container(
                    width: width-30*SizeDefault.scaleHeight-SizeDefault.paddingHorizontalText/2,
                    height: SizeDefault.heightDropDown,
                    child: Center(
                      child: Icon(
                        Icons.house,
                        color: ColorsDefault.colorIconBackgroundAppBar,
                        size: SizeDefault.heightDropDown,
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    height: SizeDefault.heightDropDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: wDropDownItem(filterMainProvider.mapFilter["property_type"])
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: ColorsDefault.colorText,
                          size: 30*SizeDefault.scaleHeight,
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Column wOverlay(BuildContext contextMain) {
    final filterMainProvider=contextMain.read<FilterMainProvider>();
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
              itemCount: filterMainProvider.propertyTypes.length,
              itemBuilder: (context,index){
                final item=filterMainProvider.propertyTypes[index];
                return InkWell(
                  onTap: (){
                    setState(() {
                      context.read<FilterMainProvider>().setMapFilterItem("property_type",item,context:context);
                      dropDownOverlay.hideOverlay();
                      if(item!="Terreno"&&item!="Otros"){
                        
                      }else{
                        sizingOverlay(filterMainProvider.propertyTypes.length);
                        dropDownOverlay.showOverlay(
                          context: contextMain, 
                          layerLink: layerLink,
                          width: 170*SizeDefault.scaleWidth,
                          onTapBarrierDismissible: (){
                            dropDownOverlay.hideOverlay();
                          }, 
                          widgetOverlay: wOverlay(context)
                       );
                      }
                    });
                    
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth),
                    child: wDropDownItem(item)
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