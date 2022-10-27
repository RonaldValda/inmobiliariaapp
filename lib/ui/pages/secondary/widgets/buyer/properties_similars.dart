import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:provider/provider.dart';

import '../../../../provider/home/properties_provider.dart';
import 'item_property_foot_little.dart';
import 'item_property_header_little.dart';

class PropertiesSimilars extends StatelessWidget {
  const PropertiesSimilars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final propertiesSimilars=context.watch<PropertiesProvider>().propertiesSimilars;
    double listaWidth=0.0;
    double listaHeight=0.0;
    double itemWidth=0.0;
    listaHeight=SizeDefault.swidth/1.5;
    listaWidth=MediaQuery.of(context).size.width;
    itemWidth=SizeDefault.swidth/2.2;
    return Container(
      padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth),
      height: listaHeight,
      width: listaWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextStandard(
            text:"   Más inmueble similares....",
            fontSize: 16*SizeDefault.scaleHeight,
            color: ColorsDefault.colorPrimary,
            fontWeight: FontWeight.w600,
          ),
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (propertiesSimilars.length/2).ceil(),
              itemBuilder: (context, index) {
                final indexCurrent=((index+1)*2)-2;
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 10*SizeDefault.scaleWidth),
                  child: Row(
                    mainAxisAlignment:(indexCurrent+1)<propertiesSimilars.length?MainAxisAlignment.center:MainAxisAlignment.start,
                    children: [
                      Card(
                        margin: EdgeInsets.symmetric(horizontal: 5*SizeDefault.scaleHeight),
                        elevation: 10,
                        shadowColor: ColorsDefault.colorShadowCardImage,
                        child: Container(
                          //height: 120,
                          padding: EdgeInsets.all(0),
                          width: itemWidth,
                          child: Column(
                            children: [
                              ItemPropertyHeaderLittle(
                                propertyTotal: propertiesSimilars[indexCurrent],
                              ),
                              ItemPropertyFootLittle(propertyTotal: propertiesSimilars[indexCurrent])
                            ],
                          ),
                        ),
                      ),
                      (indexCurrent+1)<propertiesSimilars.length
                      ?Card(
                        margin: EdgeInsets.symmetric(horizontal: 5*SizeDefault.scaleHeight),
                        elevation: 10,
                        shadowColor: ColorsDefault.colorShadowCardImage,
                        child: Container(
                          //height: 120,
                          padding: EdgeInsets.all(0),
                          width: itemWidth,
                          child: Column(
                            children: [
                              ItemPropertyHeaderLittle(
                                propertyTotal: propertiesSimilars[indexCurrent+1],
                              ),
                              ItemPropertyFootLittle(propertyTotal: propertiesSimilars[indexCurrent+1])
                            ],
                          ),
                        ),
                      ):Container(),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      )
    );
  }
}