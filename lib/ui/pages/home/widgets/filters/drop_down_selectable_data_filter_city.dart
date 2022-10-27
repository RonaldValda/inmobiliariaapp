import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:inmobiliariaapp/widgets/drop_down_overlay.dart';
import 'package:provider/provider.dart';
class DropDownSelectableDataFilterCity extends StatefulWidget {
  DropDownSelectableDataFilterCity({
    Key? key,
    required this.text,
    this.dropDownItemsCount=3
  }) : super(key: key);
  final String text;
  final int dropDownItemsCount;
  @override
  State<DropDownSelectableDataFilterCity> createState() => _DropDownSelectableDataFilterCityState();
}

class _DropDownSelectableDataFilterCityState extends State<DropDownSelectableDataFilterCity> {
  final LayerLink layerLink=LayerLink();
  double heightOverlay=45;
  double heightDropDownItem=45*SizeDefault.scaleHeight;
  DropDownOverlay dropDownOverlay=DropDownOverlay();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) { 
      final cities=context.read<GeneralDataProvider>().cities;
      heightOverlay=cities.length<widget.dropDownItemsCount?heightDropDownItem*cities.length+20:heightDropDownItem*widget.dropDownItemsCount+20;
      dropDownOverlay.sHeightOverlay=heightOverlay;
      dropDownOverlay.sHeightDropDownItem=heightDropDownItem;
    });
    
    super.initState();
  }
  Color _colorEnabledBorder=ColorsDefault.colorBorder;
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
                  color: filterMainProvider.mapFilter["city"]!=""
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
                  filterMainProvider.mapFilter["city"]==""
                  ?TextHint(text: "Seleccione")
                  :Expanded(
                    child: wDropDownItem(filterMainProvider.mapFilter["city"])
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
              itemCount: generalDataProvider.cities.length,
              itemBuilder: (context,index){
                final c=generalDataProvider.cities[index];
                return InkWell(
                  onTap: (){
                      context.read<FilterMainProvider>().setMapFilterItemCity(context: context ,value: c.cityName,indexCity: index);
                      dropDownOverlay.hideOverlay();
                    
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth),
                    child: wDropDownItem(c.cityName),
                  )
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Container wDropDownItem(String cityName) {
    return Container(
      width: double.infinity,
      height: heightDropDownItem,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            cityName,
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