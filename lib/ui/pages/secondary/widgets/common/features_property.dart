

import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_widget_provider.dart';
import 'package:provider/provider.dart';
class FeaturesProperty extends StatefulWidget {
  FeaturesProperty({Key? key}) : super(key: key);

  @override
  _FeaturesPropertyState createState() => _FeaturesPropertyState();
}

class _FeaturesPropertyState extends State<FeaturesProperty> {
  @override
  Widget build(BuildContext context) {
    final propertiesWidgetProvider=Provider.of<PropertiesWidgetProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth,vertical: 7*SizeDefault.scaleHeight),
      width: SizeDefault.swidth,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Column(
              children: [
                FeaturePropertyItem(
                  number: 2, 
                  title: "Generales", 
                  onTap: (){
                    if(propertiesWidgetProvider.featuresSelected==2){
                      propertiesWidgetProvider.setFeaturesSelected(-1);
                    }else{
                      propertiesWidgetProvider.setFeaturesSelected(2);
                    }
                  }
                ),
                FeaturePropertyItem(
                  number: 0, 
                  title: "Internas", 
                  onTap: (){
                    if(propertiesWidgetProvider.featuresSelected==0){
                      propertiesWidgetProvider.setFeaturesSelected(-1);
                    }else{
                      propertiesWidgetProvider.setFeaturesSelected(0);
                    }
                  }
                ),
                FeaturePropertyItem(
                  number: 1, 
                  title: "Comunidad", 
                  onTap: (){
                    if(propertiesWidgetProvider.featuresSelected==1){
                      propertiesWidgetProvider.setFeaturesSelected(-1);
                    }else{
                      propertiesWidgetProvider.setFeaturesSelected(1);
                    }
                  }
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class FeaturePropertyItem extends StatefulWidget {
  FeaturePropertyItem({Key? key,
  required this.number,
  required this.title,
  required this.onTap
  }) : super(key: key);
  final int number;
  final String title;
  final VoidCallback onTap;
  @override
  _FeaturePropertyItemState createState() => _FeaturePropertyItemState();
}

class _FeaturePropertyItemState extends State<FeaturePropertyItem> {
  @override
  Widget build(BuildContext context) {
    final propertiesWidgetProvider=Provider.of<PropertiesWidgetProvider>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10*SizeDefault.scaleWidth),
      decoration: BoxDecoration(
        color: propertiesWidgetProvider.featuresSelected==widget.number?ColorsDefault.colorBackgroundSelectedListTile:Colors.transparent,
        border: widget.number==2?
            Border.symmetric(horizontal: BorderSide(color: ColorsDefault.colorSeparated,width: .3*SizeDefault.scaleHeight)):
            Border(bottom: BorderSide(color: ColorsDefault.colorSeparated,width: .3*SizeDefault.scaleHeight))
      ),
      //color: Colors.cyan,
      height: 45*SizeDefault.scaleHeight,
      width: SizeDefault.swidth,
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextStandard(
              text: widget.title, 
              fontSize: 16*SizeDefault.scaleHeight,
              color: ColorsDefault.colorText,
              fontWeight: FontWeight.w700,
            ),
            //Icon(Icons.check),
          ],
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
/*
ListTile(
            selectedTileColor: Colors.lightBlue.withOpacity(0.1),
            
            //selected: inmuebleInfo.caracteristicaSeleccionada==widget.numero,
            title: Text(widget.titulo),
            trailing: Icon(Icons.check),
            onTap: widget.onTap,
          ),

*/