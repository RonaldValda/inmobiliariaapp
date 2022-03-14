import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/venta/inmueble_venta_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:provider/provider.dart';
class MapaRegistroInmueble extends StatefulWidget {
  MapaRegistroInmueble({Key? key,required this.inmueble}) : super(key: key);
  final Inmueble inmueble;
  @override
  _MapaRegistroInmuebleState createState() => _MapaRegistroInmuebleState();
}

class _MapaRegistroInmuebleState extends State<MapaRegistroInmueble> {
  var markerInmueble = <Marker>[];
  var markers=<Marker>[];
  List<Zona> zonas=[];
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
    if(widget.inmueble.coordenadas.length>1){
      markerInmueble.add(
          Marker(
            width: 50,
            height: 50,
            point: LatLng(widget.inmueble.coordenadas[0],widget.inmueble.coordenadas[1]),
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
    }
    /*obtenerZonas().
    listarZonas().then((value) => zonas.addAll(value)).whenComplete((){
      setState(() {
        
      });
    });*/
    //zonas=listarZonas();
    
  }void agregarMarker(Zona zona){
    for(int j=0;j<zona.area.length;j++){
    markers.add(
        Marker(
          //width: 30,
          //height: 30,
          point:LatLng(zona.area[j][0],zona.area[j][1]),
          builder: (cxt){
            return PopupMenuButton(
                elevation: 30,
                offset: const Offset(0, 40),
                color: Colors.white.withOpacity(0.8),
                enableFeedback: false,
                icon: Icon(Icons.location_on,color:colores[indexColor]),
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
                            Text(zona.nombreZona),
                            Text("Latitud: [${zona.area[j][0]}"),
                            Text("Longitud: ${zona.area[j][1]}")
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
  }
  void agregarPunto(LatLng point){
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
                color: Colors.white.withOpacity(0.8),
                enableFeedback: false,
                icon: Icon(Icons.location_on,color:colores[indexColor]),
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
  void agregarPolyline(Zona zona,List<Zona> zonas){
    double latitud1=zona.area[0][0];
    double longitud1=zona.area[0][1];
    double latitud2=zona.area[1][0];
    double longitud2=zona.area[1][1];
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
            isDotted: polylines.length<zonas.length?true:false,    
        )
      );
    }
  }
  Future<List<Polyline>> listarPolylines(List<Zona> zonas) async{
    indexColor=0;
   // markers=[];
    polylines=[];
    for(int i=0;i<zonas.length;i++){
      //agregarMarker(zonas[i]);
      agregarPolyline(zonas[i],zonas);
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
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(inmuebleInfo.getInmuebleTotalCopia.getInmueble.coordenadas.length>1){
      agregarPunto(LatLng(inmuebleInfo.getInmuebleTotalCopia.getInmueble.coordenadas[0],inmuebleInfo.getInmuebleTotalCopia.getInmueble.coordenadas[1]));
    }
    listarPolylines(zonas);
    return  Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 10),
          height:50,
          width: MediaQuery.of(context).size.width,
          //child: Expanded(
            child: Row(
              mainAxisAlignment:MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Seleccione la ubicación del inmueble...",
                      style:TextStyle(
                        fontSize: 16,
                        fontStyle:FontStyle.italic
                      ),
                    ),
                    Text("Zona seleccionada: "+inmuebleInfo.getInmuebleTotalCopia.getInmueble.nombreZona,
                      style:TextStyle(
                        fontSize: 14
                      ),
                    ),
                  ]
                ),
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  }, 
                  icon: Icon(Icons.close)
                )
                //Container(height: 50,width: 50,color:Colors.black12)
              ],
            ),
          //)
        ),
        Expanded(
          child: FlutterMap(
              options: MapOptions(
                allowPanning:  true,
                center: widget.inmueble.getCoordenadas.length>1? LatLng(widget.inmueble.getCoordenadas[0],widget.inmueble.getCoordenadas[1]):LatLng(-19.044622966626424,-65.268857253123),
                zoom: 15,
                onTap: (tapPosition,position){
                  widget.inmueble.coordenadas=[position.latitude,position.longitude];
                  Zona zona=buscarZonaPunto(position,zonas);
                  if(zona.nombreZona==""){
                    zona.nombreZona="Otro";
                  }
                  InmuebleTotal inmuebleTotal=inmuebleInfo.getInmuebleTotalCopia;
                  inmuebleTotal.getInmueble.setNombreZona(zona.nombreZona);
                  inmuebleInfo.setInmuebleTotalCopia(inmuebleTotal);
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
    );
  }
  Zona buscarZonaPunto(LatLng point,List<Zona> zonas){
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
    return Zona.vacio();
  }
}