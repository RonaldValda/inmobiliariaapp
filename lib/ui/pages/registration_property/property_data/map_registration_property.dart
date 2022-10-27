import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../../../common/buttons.dart';
import '../../../common/colors_default.dart';
class MapRegistrationProperty extends StatefulWidget {
  MapRegistrationProperty({Key? key}) : super(key: key);
  @override
  _MapRegistrationPropertyState createState() => _MapRegistrationPropertyState();
}

class _MapRegistrationPropertyState extends State<MapRegistrationProperty> {
  var markerInmueble = <Marker>[];
  var markers=<Marker>[];
  List<Zone> zones=[];
  MapController? mapController;
  var polylines=<Polyline>[];
  int indexColor=0;
  List<Color> colores=[
    Colors.blue,Colors.brown,
    Colors.cyan,Colors.deepOrange,
    Colors.deepPurple,Colors.green,
    Colors.blueGrey,Colors.indigo,
    Colors.lightBlue,Colors.lightGreen,
    Colors.lime,Colors.orange,
    Colors.pink,Colors.purple,
    Colors.red,Colors.teal
  ];
  @override
  void initState() {
    super.initState();
    mapController=MapController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String city=context.read<RegistrationPropertyProvider>().mapSelectedData["city"];
      final property=context.read<RegistrationPropertyProvider>().propertyTotalCopy.property;
      zones=context.read<GeneralDataProvider>().zonesCityOrigin(city);
      listarPolylines(zones);
      if(property.coordinates.length>0){
        addPoint(LatLng(property.coordinates[0],property.coordinates[1]),);
      }
      
      setState(() {
        
      });
    });
  }
  void addPoint(LatLng point){
    markers=[];
    markers.add(
        Marker(
          //width: 30,
          //height: 30,
          point:point,
          builder: (cxt){
            return PopupMenuButton(
                elevation: 30,
                offset: const Offset(0, 40),
                color: Colors.red.withOpacity(0.8),
                enableFeedback: false,
                icon: Icon(Icons.location_on,color:Colors.red),
                padding: EdgeInsets.zero,
                itemBuilder: (context){
                  return [
                    PopupMenuItem<int>(
                      padding: EdgeInsets.zero,
                      value: 0, 
                      child: Container(
                        height:150,
                        width:200,
                        child: Column(
                          children: [
                            Text(point.toString()),
                          ],
                        ),
                      ),
                    ),
                  ];
                }
              );
          }
        )
      );
    
  }
  void addPolyline(Zone zone,List<Zone> zones){
    double latitud1=zone.area[0][0];
    double longitud1=zone.area[0][1];
    double latitud2=zone.area[1][0];
    double longitud2=zone.area[1][1];
    if(latitud2!=longitud2){
      var points=<LatLng>[
        new LatLng(latitud1,longitud1),
        new LatLng(latitud2,longitud1),
        new LatLng(latitud2,longitud2),
        new LatLng(latitud1,longitud2),
        new LatLng(latitud1,longitud1),
      ];
      polylines.add(
        new Polyline(
            points: points,
            strokeWidth: 3,
            color: colores[indexColor],
            isDotted: polylines.length<zones.length?true:false,    
        )
      );
    }
  }
  Future<List<Polyline>> listarPolylines(List<Zone> zonas) async{
    indexColor=0;
    polylines=[];
    for(int i=0;i<zonas.length;i++){
      //agregarMarker(zonas[i]);
      addPolyline(zonas[i],zonas);
      if(indexColor<colores.length){
        indexColor++;
      }else{
        indexColor=0;
      }
    }
    return polylines;
  }
  @override
  Widget build(BuildContext context) {
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    final property=registrationPropertyProvider.propertyTotalCopy.property;
    if(property.coordinates.length>1){
      addPoint(LatLng(property.coordinates[0],property.coordinates[1]));
    }//listarPolylines(zones);
    print(zones.length);
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
                  onTap: (tapPosition,position){
                    property.coordinates=[position.latitude,position.longitude];
                    Zone zona=buscarZonaPunto(position,zones);
                    if(zona.zoneName==""){
                      zona.zoneName="Otro";
                    }
                    //PropertyTotal inmuebleTotal=inmuebleInfo.getInmuebleTotalCopia;
                    property.zoneName=zona.zoneName;
                    //inmuebleInfo.setInmuebleTotalCopia(inmuebleTotal);
                    markers=[];
                    print(position);
                    setState(() {
                      markers.add(
                        Marker(
                          width: 50,
                          height: 50,
                          point: LatLng(position.latitude,position.longitude),
                          builder: (cxt)=>Container(
                            child:IconButton(
                            color: Colors.red,
                              mouseCursor: MouseCursor.uncontrolled,
                              onPressed: (){
                                
                              }, 
                            icon:Icon(Icons.location_on,size: 50,)
                            ),
                          )
                        )
                      );
                    });
                  }
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
                  PolylineLayerOptions(polylines: polylines),
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
                text: "Seleccione la ubicación del inmueble...", 
                fontSize: 16*SizeDefault.scaleHeight,
                fontWeight: FontWeight.bold,
              ),
              Row(
                children: [
                  TextStandard(
                    text: "Zona seleccionada: ",
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
  Zone buscarZonaPunto(LatLng point,List<Zone> zonas){
    for(int i=0;i<zonas.length;i++){
      List<List<dynamic>> area=zonas[i].area;
      //print(area);
      bool izquierdaDerecha=area[0][1]<area[1][1];
      bool abajoArriba=area[0][0]<area[1][0];
        if(izquierdaDerecha){
          if(point.longitude>=area[0][1]&&point.longitude<=area[1][1]){
            if(abajoArriba){
              if(point.latitude>=area[0][0]&&point.latitude<=area[1][0]){
                return zonas[i];
              }
            }else{
              if(point.latitude<=area[0][0]&&point.latitude>=area[1][0]){
                return zonas[i];
              }
            }
          }
        }else{
          if(point.longitude>=area[1][1]&&point.longitude<=area[1][0]){
            if(abajoArriba){
              if(point.latitude>=area[1][0]&&point.latitude<=area[0][0]){
                return zonas[i];
              }
            }else{
              if(point.latitude<=area[1][0]&&point.latitude>=area[0][0]){
                return zonas[i];
              }
            }
          }
        }
    }
    return Zone.empty();
  }
}