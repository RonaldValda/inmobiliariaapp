import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../domain/entities/property.dart';
import '../../../../common/buttons.dart';
import '../../../../common/colors_default.dart';
import '../../../../common/size_default.dart';
import '../../../../common/texts.dart';
class ContainerUbicationPropertyMap extends StatefulWidget {
  ContainerUbicationPropertyMap({Key? key}) : super(key: key);

  @override
  State<ContainerUbicationPropertyMap> createState() => _ContainerUbicationPropertyMapState();
}

class _ContainerUbicationPropertyMapState extends State<ContainerUbicationPropertyMap> {
  @override
  Widget build(BuildContext context) {
    final property=context.read<PropertiesProvider>().propertyTotalLast.property;
    var markers=<Marker>[];
    markers=[];
    markers.add(
      Marker(
        point: LatLng(property.coordinates[0],property.coordinates[1]),
        builder: (cxt){
          return Icon(Icons.location_on,color:Colors.red);
        }
      )
    );
    return  Container(
      width: double.infinity,
      height: 700*SizeDefault.scaleHeight,
      padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroud,
        borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25),),
      ),
      child: Column(
        children: [
          _wHeader(property),
          SizedBox(height: 20*SizeDefault.scaleHeight,),
          Expanded(
            child: FlutterMap(
                options: MapOptions(
                  allowPanning:  true,
                  center: property.coordinates.length>1? LatLng(property.coordinates[0],property.coordinates[1]):LatLng(-19.044622966626424,-65.268857253123),
                  zoom: 15,
                ),
                layers: [
                  TileLayerOptions(
                    urlTemplate:
                        'https://api.mapbox.com/styles/v1/franzreynaldo98/ckq1b02o817ht18qvb6lzr7lv/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZnJhbnpyZXluYWxkbzk4IiwiYSI6ImNrcHpuejRlaDBwOHYybnBjcWt3dmJxenkifQ.c-ODMICHvf2Mr7vYAiufqA',
                    //subdomains: ['a', 'b', 'c'],
                    additionalOptions: {
                      'accessToken':'pk.eyJ1IjoiZnJhbnpyZXluYWxkbzk4IiwiYSI6ImNrcHpuejRlaDBwOHYybnBjcWt3dmJxenkifQ.c-ODMICHvf2Mr7vYAiufqA',
                      'id':'mapbox.mapbox-streets-v8'
                      
                    },
                    tileProvider: NonCachingNetworkTileProvider(),
                  ),
                  MarkerLayerOptions(markers: markers),
                ],
              ),
          ),
        ],
      ),
    );
  }
  Row _wHeader(Property property) {
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left:10*SizeDefault.scaleWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextStandard(
                text: "Ubicación del inmueble", 
                fontSize: 16*SizeDefault.scaleHeight,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  TextStandard(
                    text: "Zona: ",
                    fontSize: 14*SizeDefault.scaleHeight,
                    fontWeight: FontWeight.w600,
                  ),
                  TextStandard(
                    text: property.zoneName,
                    fontSize: 14*SizeDefault.scaleHeight,
                  ),
                ],
              ),
            ]
          ),
        ),
        FXButton()
      ],
    );
  }
}