import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/utils/generate_text.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';
import 'package:provider/provider.dart';

class FeaturesInfoDetail extends StatefulWidget {
  FeaturesInfoDetail({Key? key,required this.propertyTotal}) : super(key: key);
  final PropertyTotal propertyTotal;
  @override
  _FeaturesInfoDetailState createState() => _FeaturesInfoDetailState();
}

class _FeaturesInfoDetailState extends State<FeaturesInfoDetail> {
  List<Widget> children=<Widget>[];
  @override
  Widget build(BuildContext context) {
    final propertiesWidgetProvider=context.read<PropertiesWidgetProvider>();
    children=childrenInfo(widget.propertyTotal,propertiesWidgetProvider);
    return Container(
      child: Column(
        children: [
          TextStandard(
            text: titulo(propertiesWidgetProvider),
            fontSize: 18*SizeDefault.scaleHeight,
            color: ColorsDefault.colorText,
            fontWeight: FontWeight.bold,
          ),
          Column(
            children: [
              Wrap(
                children: children
                
              )
            ],
          )
        ],
      ),
    );
  }
  String titulo(PropertiesWidgetProvider propertiesWidgetProvider){
    if(propertiesWidgetProvider.featuresSelected==0){
      return "Internas";
    }else if(propertiesWidgetProvider.featuresSelected==1){
      return "Comunidad";
    }else if(propertiesWidgetProvider.featuresSelected==2){
      return "Generales";
    }else{
      return "";
    }
  }
  List<Widget> childrenInfo(PropertyTotal propertyTotal,PropertiesWidgetProvider propertiesWidgetProvider){
    List<Widget> children=<Widget>[];
    if(propertiesWidgetProvider.featuresSelected==0){
      PropertyInternal propertyInternal=propertyTotal.propertyInternal;
      Map<String,dynamic> map=generateTextInternal(propertyTotal,propertiesWidgetProvider);
      int i=0;
      while(i<map["categories"].length){
        children.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              propertiesWidgetProvider.searchPositionCategory(map["keys"][i])<propertyTotal.property.categoriesKeys.length
              ?_wChildButton(i, propertiesWidgetProvider, map, propertyTotal)
              :_wChild(map, i, width: SizeDefault.swidth/3.1),
              (i+1)<map["categories"].length
              ?propertiesWidgetProvider.searchPositionCategory(map["keys"][i+1])<propertyTotal.property.categoriesKeys.length
              ?_wChildButton(i+1, propertiesWidgetProvider, map, propertyTotal)
              :_wChild(map, i+1, width: SizeDefault.swidth/3.1):SizedBox(width: SizeDefault.swidth/3.1),
              (i+2)<map["categories"].length
              ?propertiesWidgetProvider.searchPositionCategory(map["keys"][i+2])<propertyTotal.property.categoriesKeys.length
              ?_wChildButton(i+2, propertiesWidgetProvider, map, propertyTotal)
              :_wChild(map, i+2, width: SizeDefault.swidth/3.1):SizedBox(width: SizeDefault.swidth/3.1),
            ],
          )
        );
        i+=3;
      }
      children.add(
        Container(
          padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
          width:MediaQuery.of(context).size.width/1.2,
          child:TextStandard(
            text: "Detalles: ${propertyInternal.internalDetails}", 
            fontSize: 14*SizeDefault.scaleHeight,
            color: ColorsDefault.colorText
          ),
        ),
      );
    }else if(propertiesWidgetProvider.featuresSelected==1){
      PropertyCommunity propertyCommunity=widget.propertyTotal.propertyCommunity;
      Map<String,dynamic> map=generateTextCommunity(propertyCommunity);
      int i=0;
      while(i<map["categories"].length){
        children.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _wChild(map, i, width: SizeDefault.swidth/3.1),
              (i+1)<map["categories"].length?_wChild(map, i+1, width: SizeDefault.swidth/3.1):SizedBox(width: SizeDefault.swidth/3.1),
              (i+2)<map["categories"].length?_wChild(map, i+2, width: SizeDefault.swidth/3.1):SizedBox(width: SizeDefault.swidth/3.1)
            ],
          )
        );
        i+=3;
      }
      children.add(
        Container(
          padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
          width:MediaQuery.of(context).size.width/1.2,
          child:TextStandard(
            text: "Detalles: ${propertyCommunity.communityDetails}", 
            fontSize: 14*SizeDefault.scaleHeight,
            color: ColorsDefault.colorText
          ),
        ),
      );
    }
    else if(propertiesWidgetProvider.featuresSelected==2){
      Property property=widget.propertyTotal.property;
      Map<String,dynamic> map=generateTextGeneral(property);
      int i=0;
      while(i<map["categories"].length){
        children.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _wChild(map, i, width: SizeDefault.swidth/3.1),
              (i+1)<map["categories"].length?_wChild(map, i+1, width: SizeDefault.swidth/3.1):SizedBox(width: SizeDefault.swidth/3.1),
              (i+2)<map["categories"].length?_wChild(map, i+2, width: SizeDefault.swidth/3.1):SizedBox(width: SizeDefault.swidth/3.1)
            ],
          )
        );
        i+=3;
      }
      children.add(
        Container(
          padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
          width:MediaQuery.of(context).size.width/1.2,
          child:TextStandard(
            text: "Detalles: ${property.generalDetails}", 
            fontSize: 14*SizeDefault.scaleHeight,
            color: ColorsDefault.colorText
          ),
        ),
      );
      PropertyOthers propertyOthers=widget.propertyTotal.propertyOthers;
      Map<String,dynamic> mapOtros=generateTextOthers(propertyOthers, property);
      i=0;
      while(i<mapOtros["categories"].length){
        children.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _wChild(mapOtros, i, width: SizeDefault.swidth/3.1),
              (i+1)<mapOtros["categories"].length?_wChild(mapOtros, i+1, width: SizeDefault.swidth/3.1):SizedBox(width: SizeDefault.swidth/3.1),
              (i+2)<mapOtros["categories"].length?_wChild(mapOtros, i+2, width: SizeDefault.swidth/3.1):SizedBox(width: SizeDefault.swidth/3.1)
            ],
          )
        );
        i+=3;
      }
      children.add(
        Container(
          padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
          width:MediaQuery.of(context).size.width/1.2,
          child:TextStandard(
            text: "Otros detalles: ${propertyOthers.othersDetails}", 
            fontSize: 14*SizeDefault.scaleHeight,
            color: ColorsDefault.colorText
          ),
        ),
      );
    }
    return children;
  }

  InkWell _wChildButton(int i, PropertiesWidgetProvider propertiesWidgetProvider, Map<String, dynamic> map, PropertyTotal propertyTotal) {
    return InkWell(
      onTap: (){
        int index=propertiesWidgetProvider.searchPositionCategory(map["keys"][i]);
        if(index<propertyTotal.property.categoriesKeys.length){
          propertiesWidgetProvider.setChangeSliding(false);
          propertiesWidgetProvider.onCategorySelected(index);
        }
      },
      child: _wChild(map, i, width: SizeDefault.swidth/3.1),
    );
  }

  Container _wChild(Map<String, dynamic> mapData, int i,{required double width}) {
    return Container(
      width: width,
      padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
        child: Column(
          children: [
            mapData["icons"][i],
            TextStandard(
              textAlign: TextAlign.center,
              text: mapData["categories"][i], 
              fontSize: 11*SizeDefault.scaleHeight,
              color: mapData["icons"][i].color,
            ),
          ],
        )
    );
  }
}
