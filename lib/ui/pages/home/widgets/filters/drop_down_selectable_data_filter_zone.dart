import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:inmobiliariaapp/widgets/drop_down_overlay.dart';
import 'package:provider/provider.dart';
class DropDownSelectableDataFilterZone extends StatefulWidget {
  DropDownSelectableDataFilterZone({
    Key? key,
    required this.text,
    this.dropDownItemsCount=3
  }) : super(key: key);
  final String text;
  final int dropDownItemsCount;
  @override
  State<DropDownSelectableDataFilterZone> createState() => _DropDownSelectableDataFilterZoneState();
}

class _DropDownSelectableDataFilterZoneState extends State<DropDownSelectableDataFilterZone> {
  final LayerLink layerLink=LayerLink();
  double heightOverlay=45;
  double heightDropDownItem=45*SizeDefault.scaleHeight;
  DropDownOverlay dropDownOverlay=DropDownOverlay();
  @override
  void initState() {
    
    super.initState();
  }
  Color _colorEnabledBorder=ColorsDefault.colorBorder;
  void _selectSizeMenu(List<Zone> zones){
    heightOverlay=zones.length<widget.dropDownItemsCount?heightDropDownItem*zones.length+20:heightDropDownItem*widget.dropDownItemsCount+20;
    dropDownOverlay.sHeightOverlay=heightOverlay;
    dropDownOverlay.sHeightDropDownItem=heightDropDownItem;
  }
  @override
  Widget build(BuildContext context) {
    final filterMainProvider=context.watch<FilterMainProvider>();
    
    return CompositedTransformTarget(
      link: layerLink,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextLabel(textLabel: widget.text),
          InkWell(
            onTap: (){
              _selectSizeMenu(context.read<GeneralDataProvider>().zonesCity);
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
                  width: 1*SizeDefault.scaleHeight,
                  color: filterMainProvider.mapFilter["zone"]!=""
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
                  filterMainProvider.mapFilter["zone"]==""
                  ?TextHint(text: "Seleccione")
                  :Expanded(
                    child: wDropDownItem(filterMainProvider.mapFilter["zone"])
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
    );
  }

  Column wOverlay(BuildContext context) {
    final generalDataProvider=context.read<GeneralDataProvider>();
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
              itemCount: generalDataProvider.zonesCity.length,
              itemBuilder: (context,index){
                final z=generalDataProvider.zonesCity[index];
                return InkWell(
                  onTap: (){
                    setState(() {
                      context.read<FilterMainProvider>().setMapFilterItem("zone", z.zoneName,context:context);
                      dropDownOverlay.hideOverlay();
                    });
                    
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth),
                    child: wDropDownItem(z.zoneName),
                  )
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Container wDropDownItem(String zoneName) {
    return Container(
      width: double.infinity,
      height: heightDropDownItem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            zoneName,
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