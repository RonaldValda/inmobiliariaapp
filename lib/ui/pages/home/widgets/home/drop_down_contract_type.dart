import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../widgets/drop_down_overlay.dart';
import '../../../../common/colors_default.dart';
import '../../../../common/size_default.dart';

class DropDownContractType extends StatefulWidget {
  DropDownContractType({
    Key? key,
    this.dropDownItemsCount=3
  }) : super(key: key);
  final int dropDownItemsCount;
  @override
  State<DropDownContractType> createState() => _DropDownContractTypeState();
}

class _DropDownContractTypeState extends State<DropDownContractType> {
  final LayerLink layerLink=LayerLink();
  double heightOverlay=40;
  double heightDropDownItem=40*SizeDefault.scaleHeight;
  DropDownOverlay dropDownOverlay=DropDownOverlay();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      final length=context.read<FilterMainProvider>().contractTypes.length;
      heightOverlay=length<widget.dropDownItemsCount?heightDropDownItem*length+20:heightDropDownItem*widget.dropDownItemsCount+20;
      dropDownOverlay.sHeightOverlay=heightOverlay;
      dropDownOverlay.sHeightDropDownItem=heightDropDownItem;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final filterMainProvider=context.watch<FilterMainProvider>();
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
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
              width: 110*SizeDefault.scaleWidth,
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
                    width: 70*SizeDefault.scaleWidth,
                    height: SizeDefault.heightDropDown,
                    child: Center(
                      child: Icon(
                        Icons.layers,
                        color: ColorsDefault.colorIconBackgroundAppBar,
                        size: SizeDefault.heightDropDown,
                      ),
                    ),
                  ),
                  Container(
                    width: 100*SizeDefault.scaleWidth,
                    height: SizeDefault.heightDropDown,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: wDropDownItem(filterMainProvider.mapFilter["contract_type"])
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

  Column wOverlay(BuildContext context) {
    final filterMainProvider=context.read<FilterMainProvider>();
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
              itemCount: filterMainProvider.contractTypes.length,
              itemBuilder: (context,index){
                final item=filterMainProvider.contractTypes[index];
                return InkWell(
                  onTap: (){
                    setState(() {
                      context.read<FilterMainProvider>().setMapFilterItem("contract_type",item,context:context);
                      dropDownOverlay.hideOverlay();
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