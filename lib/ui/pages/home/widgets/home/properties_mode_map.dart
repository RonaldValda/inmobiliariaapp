import 'package:flutter/material.dart';

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/item_property.dart';
import 'package:inmobiliariaapp/ui/provider/generals/general_data_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:fluttericon/mfg_labs_icons.dart' as iconmfg;
import 'package:fluttericon/typicons_icons.dart' as icontyp;
import 'package:fluttericon/web_symbols_icons.dart' as iconweb;
class MapaListado extends StatefulWidget {
  MapaListado({Key? key}) : super(key: key);
  @override
  _MapaListadoState createState() => _MapaListadoState();
}

class _MapaListadoState extends State<MapaListado> {
  var markers = <Marker>[];
  final Location location = Location();
  var _loading = false;
  double? longitudeInicial;
  double? latitudeInicial;
  LocationData? _location;
  String? _error;
  var polylines=<Polyline>[];
  Zone zonaActual=Zone.empty();
  late final MapController mapController;
  @override
  void initState() { 
    super.initState();
    //listarMakers(widget.inmueblesTotal);
    /*if(_location==null){
        _getLocation();
    }*/
    mapController=new MapController();
    
    
  }
  Future<void> _getLoc2ation() async {
    setState(() {
      _error = null;
      _loading = true;
    });
    try {
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _loading = false;
        _location = _locationResult;
        longitudeInicial=_location!.longitude;
        latitudeInicial=_location!.latitude;
        //print("hi"+_location!.latitude.toString());
        //print("hi"+_location!.longitude.toString());
      });
    } on PlatformException catch (err) {
      setState(() {
        _error = err.code;
        _loading = false;
        latitudeInicial=-19.1865;
        longitudeInicial=-65.2673;
      });
    }
  }
  List<Marker>listarMakers(List<PropertyTotal> _inmueblesFiltrado,User usuario) {

    int mayorVistos=0;
    int mayorDobleVistos=0;
    markers=[];
    /*if(_inmueblesFiltrado.length>0){
      if(usuario.userType=="Gerente"){
        
        inmueblesTotalGeneral.sort((b,a)=>a.property.viewedQuantity.compareTo(b.property.viewedQuantity));
        mayorVistos=inmueblesTotalGeneral[0].property.viewedQuantity;
        inmueblesTotalGeneral.sort((b,a)=>a.property.viewedDoubleQuantity.compareTo(b.property.viewedDoubleQuantity));
        mayorDobleVistos=inmueblesTotalGeneral[0].property.viewedDoubleQuantity;
        _inmueblesFiltrado.mayorVistos=mayorVistos;
        _inmueblesFiltrado.mayorDobleVistos=mayorDobleVistos;
        _inmueblesFiltrado.clasificarIndicadores();
      }
    }*/
    for(int i=0;i<_inmueblesFiltrado.length;i++){
      if(_inmueblesFiltrado[i].property.index>0){
        Widget? icono;
        /*if(usuario.userType=="Gerente"){
          Icon iconoRelleno=Icon(icontyp.Typicons.location,size: 40,color: _inmueblesFiltrado.getColorValor(_inmueblesFiltrado[i].property.viewedDoubleQuantity, _inmueblesFiltrado.limitesDobleVistos));
          Icon iconoBorde=Icon(icontyp.Typicons.location,size: 45,color: _inmueblesFiltrado.getColorValor(_inmueblesFiltrado[i].property.viewedDoubleQuantity, _inmueblesFiltrado.limitesDobleVistos));
          icono=IconoUbicacion(
            iconoBorde: iconoBorde,
            iconoPrincipal: iconoRelleno,
            colorRelleno: _inmueblesFiltrado.getColorValor(_inmueblesFiltrado[i].property.viewedDoubleQuantity, _inmueblesFiltrado.limitesDobleVistos),
            inmuebleTotal: _inmueblesFiltrado[i],
          );
        }*/
        //else{
          Icon iconoRelleno;
          if(_inmueblesFiltrado[i].property.category=="Pro360"){
            iconoRelleno=Icon(icontyp.Typicons.location,size:50,color: Color.fromRGBO(212, 175, 55, 0.5));
          }else if(_inmueblesFiltrado[i].property.category=="Pro"){
            iconoRelleno=Icon(iconmfg.MfgLabs.location,size: 50,color: Colors.blue.withOpacity(0.5));
          }else{
             iconoRelleno=Icon(iconweb.WebSymbols.location,size: 35,color:Colors.grey.withOpacity(0.4));
          }
          icono=IconoUbicacion(
            colorRelleno: _inmueblesFiltrado[i].property.category=="Pro360"?Color.fromRGBO(212, 175, 55, 0.5): _inmueblesFiltrado[i].property.category=="Pro"?Colors.blue.withOpacity(0.5):Colors.grey.withOpacity(0.4),
            iconoBorde: iconoRelleno,
            iconoPrincipal: iconoRelleno,
            inmuebleTotal: _inmueblesFiltrado[i],
          );
        //}
        markers.add(
          Marker(
            width: 50,
            height: 50,
            point: LatLng(_inmueblesFiltrado.elementAt(i).property.coordinates[0],_inmueblesFiltrado.elementAt(i).property.coordinates[1]),
            builder: (cxt){
              return PopupMenuButton(
                  elevation: 30,
                  offset: const Offset(0, 40),
                  color: Colors.white.withOpacity(0.8),
                  enableFeedback: true,
                  icon: icono,
                  padding: EdgeInsets.zero,
                  itemBuilder: (context){
                    return [
                      PopupMenuItem<int>(
                        padding: EdgeInsets.zero,
                        value: 0, 
                        //child: Container(width: 10,height: 20,color: Colors.blue,),
                        child: ItemProperty(propertyTotal:_inmueblesFiltrado.elementAt(i),index: i,),
                        //SizedBox(width: 400,height: 600,)
                        
                      ),
                    ];
                  }
                );
            }
          )
        );
      }
    }
    print(markers.length);
    return markers;
  }
  @override
  Widget build(BuildContext context) {
    final filterMainProvider=context.watch<FilterMainProvider>();
    final generalDataProvider=context.watch<GeneralDataProvider>();
    try{
      if(zonaActual.zoneName!=filterMainProvider.mapFilter["zone"]){
        zonaActual=Zone.empty();
        generalDataProvider.zonesCity.forEach((element) { 
          if(element.zoneName==filterMainProvider.mapFilter["zone"]){
            zonaActual=Zone.copyWith(element);
          }
        });
        polylines=[];
        if(zonaActual.zoneName!="Cualquiera"){
          double latitud1=zonaActual.area[0][0];
          double longitud1=zonaActual.area[0][1];
          double latitud2=zonaActual.area[1][0];
          double longitud2=zonaActual.area[1][1];
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
                color: Colors.blue,
                isDotted: true,    
            )
          );
          //mapController.move(points[0], 15);
        }
      }
    }catch(e){
      print(e);
    }
    final _usuario=Provider.of<UserProvider>(context);
    final _inmueblesFiltrado=context.watch<PropertiesProvider>().propertiesFilter;
    markers=[];
    listarMakers(_inmueblesFiltrado,_usuario.user);
    /*if(_usuario.getUsuarioInmuebleBases[0].id==""){
      longitudeInicial=-65.2405;
      latitudeInicial=-19.1865;
    }else{*/
      if(_inmueblesFiltrado.length>0){
        print("aqui ${_inmueblesFiltrado[0].property.coordinates[0]}");
        latitudeInicial=_inmueblesFiltrado[0].property.coordinates[0]; 
        longitudeInicial=_inmueblesFiltrado[0].property.coordinates[1];
        print("object123");
      }else{
        latitudeInicial=-19.1865;
        longitudeInicial=-65.2673;
      }
      print(latitudeInicial);
    return 
    //latitudeInicial==null?Container():
     Column(
       children: [
         Expanded(
           child: FlutterMap(
                /*children: [
                  Container(
                    width: 360,
                    height: 360,
                    color: Colors.blue,
                  )
                ],*/
                mapController: mapController,
                  options: MapOptions(
                    //center: LatLng(-19.1865, -65.2673),
                    
                    center: LatLng(latitudeInicial!, longitudeInicial!),
                    zoom: 15,
                    maxZoom: 16.0,
                    minZoom: 5.0,
                    onTap: (x,t){
                      print(t);
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
                      tileProvider: const CachedTileProvider(),
                    ),
                    
                    /*TileLayerOptions(
                      urlTemplate:
                        'https://api.mapbox.com/styles/v1/ronaldvalda/cl0nsxp5b000y15mtm0jvtjru/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1Ijoicm9uYWxkdmFsZGEiLCJhIjoiY2wwbnFyaDF6MHhjOTNqdGt4MXJ3NnVxMiJ9.-LsN1tRopXny-p4EdoBScA',
                      additionalOptions: {
                        'accessToken':'pk.eyJ1Ijoicm9uYWxkdmFsZGEiLCJhIjoiY2wwbnFyaDF6MHhjOTNqdGt4MXJ3NnVxMiJ9.-LsN1tRopXny-p4EdoBScA',
                        'id':'mapbox.mapbox-streets-v8'
                        
                      },
                      tileProvider: const CachedTileProvider(),
                    ),*/
                    PolylineLayerOptions(polylines: polylines),
                    MarkerLayerOptions(markers: markers),
                    PolygonLayerOptions(
                      
                    ),
                    
                  ],
                ),
         ),
       ],
     );
  }
}
class IconoUbicacion extends StatefulWidget {
  IconoUbicacion({Key? key,required this.iconoPrincipal,required this.iconoBorde,required this.colorRelleno,required this.inmuebleTotal}) : super(key: key);
  final Icon iconoPrincipal;
  final Icon iconoBorde;
  final Color colorRelleno;
  final PropertyTotal inmuebleTotal;
  @override
  _IconoUbicacionState createState() => _IconoUbicacionState();
}

class _IconoUbicacionState extends State<IconoUbicacion> {
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UserProvider>(context);
    return Container(
      width: 50,
      height: 50,
      child: Stack(
        //fit: StackFit.expand,
        children: [
          
          Center(
            child:widget.iconoBorde
          ),
          Center(
            child: widget.iconoPrincipal
          ),
          if(_usuario.user.userType=="Gerente")
          Positioned(
            top: 12,
            left: 18,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 15,
                height: 15,
                color: widget.colorRelleno,
              ),
            ),
          ),
          Positioned(
            top: 13,
            left: 20,
            child: Text(_usuario.user.userType=="Gerente"?widget.inmuebleTotal.property.favoritesQuantity.toString():"",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12
              ),
            )
          )
        ],
      ),
    );
  }
}
class CachedTileProvider extends TileProvider {
  const CachedTileProvider();
  @override
  ImageProvider getImage(Coords<num> coords, TileLayerOptions options) {
    return CachedNetworkImageProvider(
      getTileUrl(coords, options),
      //Now you can set options that determine how the image gets cached via whichever plugin you use.
    );
  }
}

