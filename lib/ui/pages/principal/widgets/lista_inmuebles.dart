
import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/publicidad.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/inmueble_item/inmueble_item.dart';
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/provider/datos_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_comunidad_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_internas_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_por_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:fluttericon/mfg_labs_icons.dart' as iconmfg;
import 'package:fluttericon/typicons_icons.dart' as icontyp;
import 'package:fluttericon/web_symbols_icons.dart' as iconweb;
class ListaInmuebles extends StatefulWidget {
  ListaInmuebles({Key? key}) : super(key: key);

  @override
  _ListaInmueblesState createState() => _ListaInmueblesState();
}

class _ListaInmueblesState extends State<ListaInmuebles> {
  var markers = <Marker>[];
  bool verMapa=false;
  BannerAd? banner;
  List<BannerAd> banners=[];
  List<BannerAd> banners1=[];
  int contadorAdd=0;
  List<Publicidad> publicidadesRectangulo=[];
  List<Publicidad> publicidadesCuadrado=[];
  var rng = new Random();
  var polylines=<Polyline>[];
  MapController? mapController;
  int _eventKey = 0;
  @override
  void initState() {
    super.initState();
    mapController=MapController();
    print("init");
    //mapController.move(london, 10);
    /*
    loadBanner().whenComplete(() {
      loadBanner1().whenComplete((){
        banners1.addAll(banners);
        setState(() {
        
        });
      });
      
    });
    */
  }
  
  //ca-app-pub-4538512831886703/8264971081
  //ca-app-pub-3940256099942544/6300978111
  Future loadBanner()async{
    banners=[];
    for(int i=0;i<5;i++){
      banners.add(BannerAd(
          size: AdSize.banner, 
          adUnitId: "ca-app-pub-3940256099942544/6300978111", 
          listener: BannerAdListener(), 
          request: AdRequest()
        )
      );
      banners[i].load();
    }
    
    //print("${banner!.responseInfo}");
    //return banner!.load();

  }
  Future loadBanner1()async{
    banners1=[];
    for(int i=0;i<5;i++){
      banners1.add(BannerAd(
          size: AdSize.banner, 
          adUnitId: "ca-app-pub-3940256099942544/6300978111", 
          listener: BannerAdListener(), 
          request: AdRequest()
        )
      );
      banners1[i].load();
    }
    
    //print("${banner!.responseInfo}");
    //return banner!.load();

  }
  @override
  Widget build(BuildContext context) {
    
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _mapaFiltroInternas=Provider.of<MapaFiltroInternasInfo>(context);
    final _mapaFiltroComunidad=Provider.of<MapaFiltroComunidadInfo>(context);
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _mapaFiltroPorUsuario=Provider.of<MapaFiltroPorUsuario>(context);
    contadorAdd=0;
    if(_inmueblesFiltrado.isFiltrar){
      final _usuario=Provider.of<UsuariosInfo>(context); 
      final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
      List<InmuebleTotal> inmueblesAux=[];
      Map<String,dynamic> mapFiltro={};
      mapFiltro.addAll(_mapaFiltroPrincipales.getMapaFiltro);
      mapFiltro.addAll(_mapaFiltroGenerales.getMapaFiltro);
      mapFiltro.addAll(_mapaFiltroGenerales.getMapaFiltroMas);
      mapFiltro.addAll(_mapaFiltroInternas.getMapaFiltro);
      mapFiltro.addAll(_mapaFiltroInternas.getMapaFiltroMas);
      mapFiltro.addAll(_mapaFiltroComunidad.getMapaFiltro);
      mapFiltro.addAll(_mapaFiltroComunidad.getMapaFiltroMas);
      mapFiltro.addAll(_mapaFiltroOtros.getMapaFiltro);
      mapFiltro.addAll(_mapaFiltroOtros.getMapaFiltroMas);
      mapFiltro.addAll(_mapaFiltroPorUsuario.getMapaFiltro);
      mapFiltro.addAll(_mapaFiltroPorUsuario.getMapaFiltroMas);
      //rint(mapFiltro);
      inmueblesAux=filtrado_inmuebles.filtrarInmuebles(inmueblesTotalGeneral,mapFiltro);
      //print("este "+_inmueblesFiltrado.getInmueblesTotalGeneral.length.toString());
      if(_usuario.tipoSesion=="Comprar"){
        _inmueblesFiltrado.setInmueblesTotal(filtrado_inmuebles.filtrarInmueblesOrdenarBase(inmueblesAux, _mapaFiltroOtros, _usuario.usuarioInmuebleBases, _mapaFiltroPrincipales));
      }else{
        filtrado_inmuebles.ordenarLista(inmueblesAux, _mapaFiltroOtros.getMapaFiltroOrden);
        _inmueblesFiltrado.setInmueblesTotal(inmueblesAux);
      }
      _estadoWidgets.init();
      final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
      publicidadesRectangulo=[];
      publicidadesCuadrado=[];
      publicidadesCuadrado.addAll(
        publicidades.where((element) => 
        element.tipoPublicidad=="Cuadrado"&&
        element.precioMin==_mapaFiltroGenerales.getMapaFiltro["precio_min"]&&
        element.precioMax==_mapaFiltroGenerales.getMapaFiltro["precio_max"]&&
        element.tipoContrato==_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]&&
        element.tipoInmueble==_mapaFiltroPrincipales.getMapaFiltro["tipo_inmueble"]
      ));
      publicidadesRectangulo.addAll(
        publicidades.where((element) => 
        element.tipoPublicidad!="Cuadrado"&&
        element.precioMin==_mapaFiltroGenerales.getMapaFiltro["precio_min"]&&
        element.precioMax==_mapaFiltroGenerales.getMapaFiltro["precio_max"]&&
        element.tipoContrato==_mapaFiltroPrincipales.getMapaFiltro["tipo_contrato"]&&
        element.tipoInmueble==_mapaFiltroPrincipales.getMapaFiltro["tipo_inmueble"]
      ));
      _datosGenerales.setPublicidadCuadrado(publicidadesCuadrado);
      _datosGenerales.setPublicidadRectangulo(publicidadesRectangulo);
      _inmueblesFiltrado.filtrar=false;
      _inmueblesFiltrado.consultarBD=false;
      
    }
    //Widget ad=AdWidget(ad: banners1[0]);
    
    return Container(
      child :
          Column(
            children: [
             if(_estadoWidgets.isVerMapa) MapaListado(),
              Visibility(
                visible: !_estadoWidgets.isVerMapa,
                child: ListadoInmuebles()
              ),
            ],
          ),
      );
  }
}
class ListadoInmuebles extends StatefulWidget {
  ListadoInmuebles({Key? key}) : super(key: key);

  @override
  _ListadoInmueblesState createState() => _ListadoInmueblesState();
}

class _ListadoInmueblesState extends State<ListadoInmuebles> {
  var rng = new Random();
  @override
  Widget build(BuildContext context) {
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _mapaFiltroInternas=Provider.of<MapaFiltroInternasInfo>(context);
    final _mapaFiltroComunidad=Provider.of<MapaFiltroComunidadInfo>(context);
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _mapaFiltroPorUsuario=Provider.of<MapaFiltroPorUsuario>(context);
    final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    return Container(
        child:
        //mapa(context, _inmueblesFiltrado.getInmueblesTotal):Container(
        Expanded(
          child: Container(
            child: RefreshIndicator(
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              color: Colors.blue,
              onRefresh: ()async{
                _inmueblesFiltrado.filtrar=true;
                _mapaFiltroGenerales.inicializarFiltros();
                _mapaFiltroInternas.inicializarFiltros();
                _mapaFiltroComunidad.inicializarFiltros();
                _mapaFiltroOtros.inicializarFiltros(); 
                _mapaFiltroPorUsuario.inicializarFiltros();
                setState(() {
                  
                });
              },
              child: CustomScrollView(
                controller: _estadoWidgets.scrollControllerListaInmueble,
                slivers: [
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context,i){
                        var inmueble=_inmueblesFiltrado.getInmueblesTotal[i];
                        
                        if(inmueble.inmueble.indice<0){
                          Publicidad publicidad=Publicidad.vacio();
                          if(inmueble.inmueble.categoria=="Cuadrado"){
                            if(_datosGenerales.publicidadesCuadrado.length>0){
                              int numeroAleatorio=rng.nextInt(_datosGenerales.publicidadesCuadrado.length);
                              publicidad=_datosGenerales.publicidadesCuadrado[numeroAleatorio];
                            }
                          }else{
                            if(_datosGenerales.publicidadesRectangulo.length>0){
                              int numeroAleatorio=rng.nextInt(_datosGenerales.publicidadesRectangulo.length);
                              publicidad=_datosGenerales.publicidadesRectangulo[numeroAleatorio];
                            }
                          }
                          return publicidad.id!=""?Column(
                            children: [
                              Container(
                                height: publicidad.tipoPublicidad=="Cuadrado"?250:40,
                                width: 250,
                                color: Colors.blue,
                                child:CachedNetworkImage(
                                  imageUrl: publicidad.linkImagenPublicidad,
                                )
                              ),
                              Container(
                                height: 32,
                                child: TextButton(
                                  onPressed: (){},
                                  child: Text("Web: ${publicidad.linkWebPublicidad}",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline
                                    ),
                                  )
                                ),
                              )
                            ],
                          ):Container();
                        }
                        return Container(
                          child: Column(
                            children: [
                              InmuebleItem(inmuebleTotal: inmueble,index: i,),
                            ],
                          ),
                        );
                      },
                      childCount: _inmueblesFiltrado.inmueblessTotal.length
                    ),
                  )
                ],
              )
            ),
          ),
        )
      );
  }
}
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
  Zona zonaActual=Zona.vacio();
  late final MapController mapController;
  @override
  void initState() { 
    super.initState();
    //listarMakers(widget.inmueblesTotal);
    if(_location==null){
        _getLocation();
    }
    mapController=new MapController();
    
    
  }
  Future<void> _getLocation() async {
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
  List<Marker>listarMakers(ListadoInmueblesFiltrado _inmueblesFiltrado,Usuario usuario) {

    int mayorVistos=0;
    int mayorDobleVistos=0;
    markers=[];
    if(inmueblesTotalGeneral.length>0){
      if(usuario.tipoUsuario=="Gerente"){
        
        inmueblesTotalGeneral.sort((b,a)=>a.inmueble.cantidadVistos.compareTo(b.inmueble.cantidadVistos));
        mayorVistos=inmueblesTotalGeneral[0].inmueble.cantidadVistos;
        inmueblesTotalGeneral.sort((b,a)=>a.inmueble.cantidadDobleVistos.compareTo(b.inmueble.cantidadDobleVistos));
        mayorDobleVistos=inmueblesTotalGeneral[0].inmueble.cantidadDobleVistos;
        _inmueblesFiltrado.mayorVistos=mayorVistos;
        _inmueblesFiltrado.mayorDobleVistos=mayorDobleVistos;
        _inmueblesFiltrado.clasificarIndicadores();
      }
    }
    for(int i=0;i<_inmueblesFiltrado.inmueblessTotal.length;i++){
      if(_inmueblesFiltrado.inmueblessTotal[i].inmueble.indice>0){
        Widget? icono;
        if(usuario.tipoUsuario=="Gerente"){
          Icon iconoRelleno=Icon(icontyp.Typicons.location,size: 40,color: _inmueblesFiltrado.getColorValor(_inmueblesFiltrado.inmueblessTotal[i].inmueble.cantidadDobleVistos, _inmueblesFiltrado.limitesDobleVistos));
          Icon iconoBorde=Icon(icontyp.Typicons.location,size: 45,color: _inmueblesFiltrado.getColorValor(_inmueblesFiltrado.inmueblessTotal[i].inmueble.cantidadDobleVistos, _inmueblesFiltrado.limitesDobleVistos));
          icono=IconoUbicacion(
            iconoBorde: iconoBorde,
            iconoPrincipal: iconoRelleno,
            colorRelleno: _inmueblesFiltrado.getColorValor(_inmueblesFiltrado.inmueblessTotal[i].inmueble.cantidadDobleVistos, _inmueblesFiltrado.limitesDobleVistos),
            inmuebleTotal: _inmueblesFiltrado.inmueblessTotal[i],
          );
        }else{
          Icon iconoRelleno;
          if(_inmueblesFiltrado.inmueblessTotal[i].inmueble.categoria=="Pro360"){
            iconoRelleno=Icon(icontyp.Typicons.location,size:50,color: Color.fromRGBO(212, 175, 55, 0.5));
          }else if(_inmueblesFiltrado.inmueblessTotal[i].inmueble.categoria=="Pro"){
            iconoRelleno=Icon(iconmfg.MfgLabs.location,size: 50,color: Colors.blue.withOpacity(0.5));
          }else{
             iconoRelleno=Icon(iconweb.WebSymbols.location,size: 35,color:Colors.grey.withOpacity(0.4));
          }
          icono=IconoUbicacion(
            colorRelleno: _inmueblesFiltrado.inmueblessTotal[i].inmueble.categoria=="Pro360"?Color.fromRGBO(212, 175, 55, 0.5): _inmueblesFiltrado.inmueblessTotal[i].inmueble.categoria=="Pro"?Colors.blue.withOpacity(0.5):Colors.grey.withOpacity(0.4),
            iconoBorde: iconoRelleno,
            iconoPrincipal: iconoRelleno,
            inmuebleTotal: _inmueblesFiltrado.inmueblessTotal[i],
          );
        }
        markers.add(
          Marker(
            width: 50,
            height: 50,
            point: LatLng(_inmueblesFiltrado.inmueblessTotal.elementAt(i).getInmueble.getCoordenadas[0],_inmueblesFiltrado.inmueblessTotal.elementAt(i).getInmueble.getCoordenadas[1]),
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
                        child: InmuebleItem(inmuebleTotal: _inmueblesFiltrado.inmueblessTotal.elementAt(i),index: i,),
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
    final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final _datosGenerales=Provider.of<DatosGeneralesInfo>(context);
    try{
      if(zonaActual.nombreZona!=_mapaFiltroPrincipales.getMapaFiltro["zona"]){
        zonaActual=Zona.vacio();
        _datosGenerales.zonasCiudad.forEach((element) { 
          if(element.nombreZona==_mapaFiltroPrincipales.getMapaFiltro["zona"]){
            zonaActual.zonaCopy(element);
          }
        });
        polylines=[];
        if(zonaActual.nombreZona!="Cualquiera"){
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
          mapController.move(points[0], 15);
        }
      }
    }catch(e){
      print(e);
    }
    final _usuario=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    markers=[];
    listarMakers(_inmueblesFiltrado,_usuario.usuario);
    /*if(_usuario.getUsuarioInmuebleBases[0].id==""){
      longitudeInicial=-65.2405;
      latitudeInicial=-19.1865;
    }else{*/
      if(_inmueblesFiltrado.getInmueblesTotal.length>0){
        latitudeInicial=_inmueblesFiltrado.getInmueblesTotal[0].getInmueble.getCoordenadas[0]; 
        longitudeInicial=_inmueblesFiltrado.getInmueblesTotal[0].getInmueble.getCoordenadas[1];
      }else{
        latitudeInicial=-19.1865;
        longitudeInicial=-65.2673;
      }
    //}
    print("object");
    return 
    //latitudeInicial==null?Container():
    Flexible(
      fit: FlexFit.loose,
      child: 
      FlutterMap(
        children: [
          Container(
            width: 360,
            height: 360,
            color: Colors.blue,
          )
        ],
        mapController: mapController,
          options: MapOptions(
            //center: LatLng(-19.1865, -65.2673),
            center: LatLng(latitudeInicial!, longitudeInicial!),
            zoom: 15,
            maxZoom: 16.0,
            minZoom: 5.0,
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
    );
  }
}
class IconoUbicacion extends StatefulWidget {
  IconoUbicacion({Key? key,required this.iconoPrincipal,required this.iconoBorde,required this.colorRelleno,required this.inmuebleTotal}) : super(key: key);
  final Icon iconoPrincipal;
  final Icon iconoBorde;
  final Color colorRelleno;
  final InmuebleTotal inmuebleTotal;
  @override
  _IconoUbicacionState createState() => _IconoUbicacionState();
}

class _IconoUbicacionState extends State<IconoUbicacion> {
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
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
          if(_usuario.usuario.tipoUsuario=="Gerente")
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
            child: Text(_usuario.usuario.tipoUsuario=="Gerente"?widget.inmuebleTotal.inmueble.cantidadFavoritos.toString():"",
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

