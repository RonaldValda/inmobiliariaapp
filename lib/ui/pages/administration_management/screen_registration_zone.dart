import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generals.dart';
import 'package:inmobiliariaapp/domain/usecases/general/usecase_generals.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/generals/registration_places_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
class ScreenRegistrationZone extends StatefulWidget {
  ScreenRegistrationZone({Key? key}) : super(key: key);
  @override
  _ScreenRegistrationZoneState createState() => _ScreenRegistrationZoneState();
}

class _ScreenRegistrationZoneState extends State<ScreenRegistrationZone> {
  var markers = <Marker>[];
  UseCaseGenerals useCaseGenerales=UseCaseGenerals();
  @override
  void initState() {
    super.initState();
    /*useCaseGenerales.getZones(widget.ciudad.id).then((value){
      if(value["completed"]){
        zonas=value["zonas"];
        zonas.sort((a,b)=>a.zoneName.compareTo(b.zoneName));
        setState(() {
          
        });
      }
    });*/
    //zonasNoSeleccionadas.addAll(zonas);
    //listarMakers(zonas);
  }
  
  @override
  Widget build(BuildContext context) {
    final modeList=context.watch<RegistrationPlacesProvider>().zoneModeList;
    return SafeArea(
      child: Scaffold(
        body:
        Container(
          child: Stack(
            children: [
              MapZonesCity(),
              Positioned(
                bottom: 0,
                left: 0,
                child: modeList?_wListZones(context: context):_wData(context: context)
                //_wData()
              ),
              //_wListZones()
            ],
          ),
        )
      ),
    );
  }

  Row _wButtons() {
    return Row(
      mainAxisAlignment:MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          height: 35*SizeDefault.scaleWidth,
          width: 100*SizeDefault.scaleWidth,
          child: ButtonOutlinedPrimary(
            text: "Limpiar", 
            onPressed: (){
              setState(() {
                
              });
            }
          ),
        ),
        SizedBox(
          height: 35*SizeDefault.scaleWidth,
          width: 120*SizeDefault.scaleWidth,
          child: ButtonPrimary(
            text: "Modificar",
            onPressed: (){
              /*if(seleccionado>=0){
              useCaseGenerales.updateZone(zonaSeleccionada).then((value) {
                if(value){
                  zonas.removeAt(seleccionado);
                  zonas.add(zonaSeleccionada);
                  zonas.sort((a,b)=>a.zoneName.compareTo(b.zoneName));
                  setState(() {
                    
                  });
                }
              });
            }else{
              useCaseGenerales.registerZone(widget.ciudad.id, zonaSeleccionada).then((value) {
                if(value["completed"]){
                  zonas.add(value["zona"]);
                  zonas.sort((a,b)=>a.zoneName.compareTo(b.zoneName));
                  setState(() {
                    
                  });
                }
              });
            }*/
            },
          )
        ),
        SizedBox(
          height: 35*SizeDefault.scaleWidth,
          width: 120*SizeDefault.scaleWidth,
          child: ButtonPrimary(
            text: "Ver zonas",
            onPressed: (){}
          )
        )
      ],
    );
  }

  Container _wListZones({required BuildContext context}) {
    final registrationPlacesProvider=context.read<RegistrationPlacesProvider>();
    final zoneCity=registrationPlacesProvider.zonesCity;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
      width: SizeDefault.swidth,
      height: 210*SizeDefault.scaleWidth,
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroud,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsDefault.colorShadowCardImage,
            blurRadius: 5,
            offset: Offset(0,-5)
          )
        ]
      ),
      //color: Colors.white,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: zoneCity.length,
              itemBuilder: (context, index){
                final zone=zoneCity[index];
                //final Zona zona=zonas[index];
                bool selected=registrationPlacesProvider.zoneSelected.id==zone.id;
                return _wListTile(
                  zone: zone, 
                  color: selected?ColorsDefault.colorBackgroundListTileSelected:ColorsDefault.colorBackgroud, 
                  onTap: (){
                    context.read<RegistrationPlacesProvider>().setZoneSelected(zone);
                  }, 
                  widget: selected?_wTrailing(
                    onPressedEdit: (){
                      context.read<RegistrationPlacesProvider>().setZoneModeList(false);
                      //context.read<RegistrationPlacesProvider>().notify();
                    }, 
                    onPressedDelete: (){}
                  ):SizedBox()
                );
                
                /*Column(
                  children: [
                    ListTile(
                      title:Text(zoneCity[index].zoneName),
                      selected: seleccionado==index?true:false,
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextStandard(
                            text: "P1: [${zoneCity[index].area[0][0]},${zoneCity[index].area[0][1]}]", 
                            fontSize: 10*SizeDefault.scaleWidth
                          ),
                          TextStandard(
                            text: "P2: [${zoneCity[index].area[1][0]},${zoneCity[index].area[1][1]}]", 
                            fontSize: 10*SizeDefault.scaleWidth
                          ),
                        ],
                      ),
                      onTap: (){
                        if(seleccionado==index){
                          seleccionado=-1;
                          controllerNombreZona!.text="";
                          controllerLatitud1!.text="0";
                          controllerLongitud1!.text="0";
                          controllerLatitud2!.text="0";
                          controllerLongitud2!.text="0";
                          zonaSeleccionada=Zone.empty();
                          zonasNoSeleccionadas=[];
                          zonasNoSeleccionadas.addAll(zoneCity);
                        }else{
                          seleccionado=index;
                          controllerNombreZona!.text=zoneCity[index].zoneName;
                          controllerLatitud1!.text=zoneCity[index].area[0][0].toString();
                          controllerLongitud1!.text=zoneCity[index].area[0][1].toString();
                          controllerLatitud2!.text=zoneCity[index].area[1][0].toString();
                          controllerLongitud2!.text=zoneCity[index].area[1][1].toString();
                          zonaSeleccionada=Zone.copyWith(zoneCity[index]);
                          zonasNoSeleccionadas=[];
                          zonasNoSeleccionadas.addAll(zoneCity.where((element) => element.zoneName!=zoneCity[index].zoneName&&element.area!=zoneCity[index].area));
                        }
                        setState(() {
                          
                        });
                      },
                      trailing:  IconButton(
                        onPressed: (){
                          useCaseGenerales.deleteZone(zoneCity[index].id).then((value){
                            if(value){
                              zoneCity.removeAt(index);
                              setState(() {
                                
                              });
                            }
                          });
                        },
                        icon: Icon(Icons.delete,color:Colors.redAccent)
                      ),
                    ),
                    Divider(height: 3,thickness: 2,)
                  ],
                );*/
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _wListTile({required Zone zone,required Color color,required Function onTap,required Widget widget}){
    return Material(
      color: color,
      child: InkWell(
        splashColor: ColorsDefault.colorBackgroud,
        onTap: (){
          onTap();
        },
        child: Container(
          width: double.infinity,
          height: 90*SizeDefault.scaleHeight,
          padding: EdgeInsets.symmetric(horizontal: 12*SizeDefault.scaleWidth),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextStandard(
                      text: zone.zoneName, 
                      fontSize: SizeDefault.fSizeListTileTitle,
                      color: ColorsDefault.colorTextListTileTitle,
                      fontWeight: FontWeight.w500,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        SizedBox(height:7*SizeDefault.scaleHeight),
                        Row(
                          children: [
                            TextStandard(
                              text: "Latitud 1: ", 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: ColorsDefault.colorTextListTileSubtitle,
                              fontWeight: FontWeight.w300,
                            ),
                            TextStandard(
                              text: "${zone.area[0][0]}", 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: ColorsDefault.colorTextListTileSubtitle,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextStandard(
                              text: "Longitud 1: ", 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: ColorsDefault.colorTextListTileSubtitle,
                              fontWeight: FontWeight.w300,
                            ),
                            TextStandard(
                              text: "${zone.area[0][1]}", 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: ColorsDefault.colorTextListTileSubtitle,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextStandard(
                              text: "Latitud 2: ", 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: ColorsDefault.colorTextListTileSubtitle,
                              fontWeight: FontWeight.w300,
                            ),
                            TextStandard(
                              text: "${zone.area[1][0]}", 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: ColorsDefault.colorTextListTileSubtitle,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextStandard(
                              text: "Longitud 2: ", 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: ColorsDefault.colorTextListTileSubtitle,
                              fontWeight: FontWeight.w300,
                            ),
                            TextStandard(
                              text: "${zone.area[1][1]}", 
                              fontSize: SizeDefault.fSizeListTileSubtitle,
                              color: ColorsDefault.colorTextListTileSubtitle,
                              fontWeight: FontWeight.w500,
                            ),
                          ],
                        ),
                      ]
                    )
                  ],
                ),
              ),
              widget
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _wTrailing({required Function onPressedEdit,required Function onPressedDelete}) {
    return SizedBox(
      width: 60*SizeDefault.scaleWidth,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _wIconButton(
            icon: Icon(
              Icons.edit,
              color: ColorsDefault.colorIcon,
              size: SizeDefault.sizeIconButton,
            ), 
            onPressed: ()async{
              onPressedEdit();
            }
          ),
          _wIconButton(
            icon: Icon(
              Icons.delete,
              color: ColorsDefault.colorTextError,
              size: SizeDefault.sizeIconButton,
            ), 
            onPressed: ()async{
              onPressedDelete();
            }
          ),
        ],
      ),
    );
  }

  Container _wData({required BuildContext context}) {
    final registrationPlacesProvider=context.read<RegistrationPlacesProvider>();
    final zoneSelected=registrationPlacesProvider.zoneSelected;
    final sizedBox=SizedBox(height: 7*SizeDefault.scaleWidth,);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 10*SizeDefault.scaleWidth),
      width: SizeDefault.swidth,
      height: 210*SizeDefault.scaleWidth,
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroud,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        )
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            FTextFieldBasico(
              controller: registrationPlacesProvider.controllerZoneName, 
              labelText: "Nombre de la zona", 
              onChanged: (x){
                zoneSelected.zoneName=x.toString();
              }
            ),
            sizedBox,
            Row(
              children: [
                Expanded(
                  child: FTextFieldBasico(
                    controller: registrationPlacesProvider.controllerLatitude1, 
                    labelText: "Latitud Punto 1", 
                    onChanged: (x){
                      if(x=="-"){
                        context.read<RegistrationPlacesProvider>().setZoneSelectedAreaItem(pointNumber: 0, index: 0, coordinate: 0.0);
                      }else{
                        context.read<RegistrationPlacesProvider>().setZoneSelectedAreaItem(pointNumber: 0, index: 1, coordinate: double.parse(x));
                      }
                    }
                  ),
                ),
                SizedBox(width: 10*SizeDefault.scaleWidth,),
                Expanded(
                  child: FTextFieldBasico(
                    controller: registrationPlacesProvider.controllerLongitude2, 
                    labelText: "Longitud Punto 2", 
                    onChanged: (x){
                      zoneSelected.area[0][1]=double.parse(x);
                      //context.read<RegistrationPlacesProvider>().notify();
                    }
                  ),
                ),
              ],
            ),
            sizedBox,
            Row(
              children:[
                Expanded(
                  child: FTextFieldBasico(
                    controller: registrationPlacesProvider.controllerLatitude2, 
                    labelText: "Latitud Punto 2", 
                    onChanged: (x){
                      zoneSelected.area[1][0]=double.parse(x);
                      //context.read<RegistrationPlacesProvider>().notify();
                    }
                  ),
                ),
                SizedBox(width: 10*SizeDefault.scaleWidth,),
                Expanded(
                  child: FTextFieldBasico(
                    controller: registrationPlacesProvider.controllerLongitude2, 
                    labelText: "Longitud Punto 2", 
                    onChanged: (x){
                      zoneSelected.area[1][1]=double.parse(x);
                      //context.read<RegistrationPlacesProvider>().notify();
                    }
                  ),
                ),
              ]
            ),
            SizedBox(height: 15*SizeDefault.scaleWidth,),
            _wButtons()
          ],
        ),
      ),
    );
  }
  Widget _wIconButton({required Icon icon,required Function onPressed}){
    return IconButton(
      constraints: BoxConstraints(maxWidth: SizeDefault.sizeIconButton,maxHeight: SizeDefault.sizeIconButton),
      padding: EdgeInsets.zero,
      splashRadius: SizeDefault.sizeIconButton,
      onPressed:() => onPressed(), 
      icon: icon
    );
  }
}
class MapZonesCity extends StatefulWidget {
  MapZonesCity({Key? key}) : super(key: key);
  @override
  _MapZonesCityState createState() => _MapZonesCityState();
}

class _MapZonesCityState extends State<MapZonesCity> {
  var markers = <Marker>[];
  var points=<LatLng>[];
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
  double? longitudeInicial;
  double? latitudeInicial;
  @override
  void initState() { 
    super.initState();
    //listarMakers(widget.zonas);
    
  }
  void agregarMarker(Zone zona){
    for(int j=0;j<zona.area.length;j++){
      final markerZone=InkWell(
        child: Container(
          padding: EdgeInsets.zero,
          child:PopupMenuButton(
                elevation: 10,
                offset: const Offset(0, 5),
                color: ColorsDefault.colorBackgroud,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                enableFeedback: true,
                onSelected: (a){},

                icon: Icon(Icons.circle,color:colores[indexColor],size: 15*SizeDefault.scaleWidth,),
                padding: EdgeInsets.zero,
                itemBuilder: (context){
                  return [
                    PopupMenuItem<int>(
                      onTap: (){},
                      padding: EdgeInsets.zero,
                      height: 40,
                      value: 0, 
                      child: Container(
                        height:50*SizeDefault.scaleWidth,
                        width:180*SizeDefault.scaleWidth,
                        padding: EdgeInsets.only(left: 10*SizeDefault.scaleWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextStandard(
                              text: zona.zoneName,
                              fontSize: 10*SizeDefault.scaleHeight,
                              color: ColorsDefault.colorPrimary,
                            ),
                            TextStandard(
                              text: "Lat. ${j+1}: ${zona.area[j][0]}",
                              fontSize: 11*SizeDefault.scaleHeight,
                              color: ColorsDefault.colorText,
                            ),
                            TextStandard(
                              text: "Long. ${j+1}: ${zona.area[j][1]}",
                              fontSize: 11*SizeDefault.scaleHeight,
                              color: ColorsDefault.colorText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                }
              ),
        ),
        onTap: (){
          print("tap");
        },
      );
    markers.add(
        Marker(
          point:LatLng(zona.area[j][0],zona.area[j][1]),
          builder: (cxt){
            return markerZone;
            /*return PopupMenuButton(
                elevation: 30,
                offset: const Offset(0, 40),
                color: Colors.white.withOpacity(0.8),
                enableFeedback: false,
                icon: Icon(Icons.circle,color:colores[indexColor],size: 10,),
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
                            Text(zona.zoneName),
                            Text("[${zona.area[j][0]}"),
                            Text("${zona.area[j][1]}")
                          ],
                        ),
                      ),
                    ),
                  ];
                }
              );*/
          }
        )
      );
    }
  }
  void agregarPolyline(Zone zona,List<Zone> zonesCity){
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
        //new LatLng(zonas[i].area[0][0],zonas[i].area[1][1]),
      ];
      polylines.add(
        new Polyline(
            points: points,
            strokeWidth: 1,
            color: colores[indexColor],
            isDotted: polylines.length<zonesCity.length?true:false,
            //gradientColors: [Colors.blueAccent,Colors.indigo],
            //borderColor: colores[i],
            //borderStrokeWidth: 2,              //gradientColors: [Colors.indigo,Colors.orange]
        )
      );
    }
  }
  Future<List<Marker>> listarMakers(List<Zone> zones) async{
    indexColor=0;
    markers=[];
    polylines=[];
    for(int i=0;i<zones.length;i++){
      agregarMarker(zones[i]);
      agregarPolyline(zones[i],zones);
      if(indexColor<colores.length){
        indexColor++;
      }else{
        indexColor=0;
      }
    }
    return markers;
  }
  @override
  Widget build(BuildContext context) {
    final registrationPlacesProvider=context.read<RegistrationPlacesProvider>();
    final zonesCity=registrationPlacesProvider.zonesCity;
    final zoneSelected=registrationPlacesProvider.zoneSelected;
    listarMakers(zonesCity);
    agregarMarker(zoneSelected);
    agregarPolyline(zoneSelected,zonesCity);
    
    return FlutterMap(
        options: MapOptions(
          //center:LatLng(31,121),

          center:zonesCity.length>0?LatLng(zonesCity[0].area[0][0],zonesCity[0].area[0][1]):LatLng(-19.044622966626424,-65.268857253123),
          zoom: 15,
          onTap: (tapPosition,point){
            if(!registrationPlacesProvider.zoneModeList){
              if(zoneSelected.area[0][0]==zoneSelected.area[0][1]){
              zoneSelected.area[0]=[point.latitude,point.longitude];
              //widget.controllerLatitud1.text=zoneSelected.area[0][0].toString();
              //widget.controllerLongitud1.text=zoneSelected.area[0][1].toString();
    
              }else{
                zoneSelected.area[1]=[point.latitude,point.longitude];
                //widget.controllerLatitud2.text=zoneSelected.area[1][0].toString();
                //widget.controllerLongitud2.text=zoneSelected.area[1][1].toString();
              }
              if(zoneSelected.area[1][0]!=zoneSelected.area[1][1]){
                LatLng point1=LatLng(zoneSelected.area[0][0],zoneSelected.area[0][1]);
                LatLng point2=LatLng(zoneSelected.area[1][0],zoneSelected.area[1][1]);
                if(!verificarPunto(point1, point2,zonesCity)){
                  zoneSelected.area[0]=[0.0,0.0];
                  zoneSelected.area[1]=[0.0,0.0];
                  /*widget.controllerLatitud1.text=zoneSelected.area[0][0].toString();
                  widget.controllerLongitud1.text=zoneSelected.area[0][1].toString();
                  widget.controllerLatitud2.text=zoneSelected.area[1][0].toString();
                  widget.controllerLongitud2.text=zoneSelected.area[1][1].toString();*/
                  ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Zona en área no permitida"));
                }
              }
              setState(() {
                
              });
            }
            
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
          PolylineLayerOptions(
            polylineCulling: false,
            polylines: polylines,

          ),
          MarkerLayerOptions(markers: markers),
          
        ],
      );
  }
  bool verificarPunto(LatLng point1,LatLng point2,List<Zone> zonesCity){
    bool correcto=true;
    List<LatLng> points=[point1,point2,new LatLng(point1.latitude,point2.longitude),new LatLng(point2.latitude,point1.longitude)];
    for(int i=0;i<zonesCity.length;i++){
      List<List<dynamic>> area=zonesCity[i].area;
      //print(area);
      bool izquierdaDerecha=area[0][1]<area[1][1];
      bool abajoArriba=area[0][0]<area[1][0];
      for(int j=0;j<points.length;j++){
        LatLng point=points[j];
        if(izquierdaDerecha){
          if(point.longitude>=area[0][1]&&point.longitude<=area[1][1]){
            if(abajoArriba){
              if(point.latitude>=area[0][0]&&point.latitude<=area[1][0]){
                correcto=false;
                break;
              }
            }else{
              if(point.latitude<=area[0][0]&&point.latitude>=area[1][0]){
                correcto=false;
                break;
              }
            }
          }
        }else{
          if(point.longitude>=area[1][1]&&point.longitude<=area[1][0]){
            if(abajoArriba){
              if(point.latitude>=area[1][0]&&point.latitude<=area[0][0]){
                correcto=false;
                break;
              }
            }else{
              if(point.latitude<=area[1][0]&&point.latitude>=area[0][0]){
                correcto=false;
                break;
              }
            }
          }
        }
        if(!correcto){
          break;
        }
      }
    }
    return correcto;
  }
}
