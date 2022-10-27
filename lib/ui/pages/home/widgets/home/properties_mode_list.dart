
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/publicity.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/item_property.dart';
import 'package:inmobiliariaapp/ui/provider/generals/publicities_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/widget_status_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:provider/provider.dart';
class PropertiesModeList extends StatefulWidget {
  PropertiesModeList({Key? key}) : super(key: key);

  @override
  _PropertiesModeListState createState() => _PropertiesModeListState();
}

class _PropertiesModeListState extends State<PropertiesModeList> {
  var rng = new Random();
  @override
  Widget build(BuildContext context) {
    final widgetStatusProvider=Provider.of<WidgetStatusProvider>(context);
    final propertiesProvider=context.read<PropertiesProvider>();
    final publicitiesProvider=Provider.of<PublicitiesProvider>(context);
    return Container(
      child: RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.anywhere,
        color: ColorsDefault.colorPrimary,
        strokeWidth: 2*SizeDefault.scaleWidth,

        onRefresh: ()async{
          context.read<FilterMainProvider>().cleanAllFilters(context: context);
        },
        child: CustomScrollView(
          controller: widgetStatusProvider.scrollControllerProperties,
          dragStartBehavior: DragStartBehavior.down,
         //semanticChildCount: propertiesProvider.propertiesFilter.length,
          
          primary: false,
          scrollDirection: Axis.vertical,
         // scrollBehavior: ScrollBehavior(),
         physics: ScrollPhysics(),
          shrinkWrap: true,
          slivers: [
            SliverList(

              delegate: SliverChildBuilderDelegate(
                (context,i){
                  final propertyTotal=propertiesProvider.propertiesFilter[i];
                  if(propertyTotal.property.index<0){
                    if(i==propertiesProvider.propertiesFilter.length-1){
                      return Column(
                        children: [
                          _wPublicity(
                            property: propertyTotal.property, 
                            publicitiesSquare: publicitiesProvider.publicitiesSquare, 
                            publicitiesRectangle: publicitiesProvider.publicitiesRectangle
                          ),
                          _wButtonClear(widgetStatusProvider, context),
                        ],
                      );
                    }
                    return _wPublicity(
                      property: propertyTotal.property, 
                      publicitiesSquare: publicitiesProvider.publicitiesSquare, 
                      publicitiesRectangle: publicitiesProvider.publicitiesRectangle
                    );
                  }
                  if(i==propertiesProvider.propertiesFilter.length-1){
                    return Column(
                      children: [
                        ItemProperty(propertyTotal: propertyTotal,index: i,),
                        _wButtonClear(widgetStatusProvider, context),
                      ],
                    );
                  }
                  return ItemProperty(propertyTotal: propertyTotal,index: i,);
                },
                childCount: propertiesProvider.propertiesFilter.length,
                addSemanticIndexes: true,
                addAutomaticKeepAlives: true,
                addRepaintBoundaries: true,
                
              ),
            )
          ],
        )
      ),
      );
  }

  Container _wButtonClear(WidgetStatusProvider widgetStatusProvider, BuildContext context) {
    return Container(
      width: 250*SizeDefault.scaleWidth,
      margin: EdgeInsets.only(top: 30*SizeDefault.scaleHeight,bottom: 100*SizeDefault.scaleHeight),
      child: ButtonOutlinedPrimary(
        text: "Limpiar filtros y volver al principio",
        onPressed: (){
          widgetStatusProvider.reiniciarScroll();
          context.read<FilterMainProvider>().cleanAllFilters(context: context);
          
        }, 
      ),
      /*child: ElevatedButton(
        onPressed: (){
          widgetStatusProvider.reiniciarScroll();
          context.read<FilterMainProvider>().clenAllFilters(context: context);
          
        }, 
        child: Text("Limpiar filtros y volver al principio")
      ),*/
    );
  }

  Widget _wPublicity({required Property property, required List<Publicity> publicitiesSquare, required List<Publicity> publicitiesRectangle}){
    Publicity publicidad=Publicity.empty();
    if(property.category=="Cuadrado"){
      if(publicitiesSquare.length>0){
        int numeroAleatorio=rng.nextInt(publicitiesSquare.length);
        publicidad=publicitiesSquare[numeroAleatorio];
      }
    }else{
      if(publicitiesRectangle.length>0){
        int numeroAleatorio=rng.nextInt(publicitiesRectangle.length);
        publicidad=publicitiesRectangle[numeroAleatorio];
      }
    }
    return publicidad.id!=""
    ?Column(
      children: [
        Container(
          height: publicidad.publicityType=="Cuadrado"?250*SizeDefault.scaleWidth:40*SizeDefault.scaleWidth,
          width: 250*SizeDefault.scaleWidth,
          color: Colors.blue,
          child:CachedNetworkImage(
            imageUrl: publicidad.publicityImageLink,
          )
        ),
        Container(
          height: 32*SizeDefault.scaleWidth,
          child: TextButton(
            onPressed: (){},
            child: Text("Web: ${publicidad.publicityWebLink}",
              style: TextStyle(
                decoration: TextDecoration.underline
              ),
            )
          ),
        )
      ],
    ):Container();
  }
}