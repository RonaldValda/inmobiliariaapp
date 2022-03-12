import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/generales.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_generales.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
class PageRegistroZona extends StatefulWidget {
  PageRegistroZona({Key? key,required this.ciudad}) : super(key: key);
  final Ciudad ciudad;
  @override
  _PageRegistroZonaState createState() => _PageRegistroZonaState();
}

class _PageRegistroZonaState extends State<PageRegistroZona> {
  var markers = <Marker>[];
  List<Zona> zonas=[];
  List<Zona> zonasNoSeleccionadas=[];
  int seleccionado=-1;
  Zona zonaSeleccionada=Zona.vacio();
  TextEditingController? controllerLatitud1;
  TextEditingController? controllerLongitud1;
  TextEditingController? controllerLatitud2;
  TextEditingController? controllerLongitud2;
  TextEditingController? controllerNombreZona;
  UseCaseGenerales useCaseGenerales=UseCaseGenerales();
  @override
  void initState() {
    super.initState();
    controllerLatitud1=TextEditingController(text: "0");
    controllerLongitud1=TextEditingController(text: "0");
    controllerLatitud2=TextEditingController(text: "0");
    controllerLongitud2=TextEditingController(text: "0");
    controllerNombreZona=TextEditingController(text: "");
    useCaseGenerales.obtenerZonas(widget.ciudad.id).then((value){
      if(value["completed"]){
        zonas=value["zonas"];
        zonas.sort((a,b)=>a.nombreZona.compareTo(b.nombreZona));
        setState(() {
          
        });
      }
    });
    //zonasNoSeleccionadas.addAll(zonas);
    //listarMakers(zonas);
  }
  
  @override
  Widget build(BuildContext context) {
    /*if(seleccionado<0){
      zonasNoSeleccionadas.addAll(zonas);
    }*/
    return SafeArea(
      child: Scaffold(
        body:
        Container(
          child: Column(
            children: [
              Expanded(
                child: MapaListadoZonas(
                  zonas: zonasNoSeleccionadas,zona: zonaSeleccionada,
                  controllerLatitud1:controllerLatitud1!,
                  controllerLongitud1: controllerLongitud1!,
                  controllerLatitud2:controllerLatitud2!,
                  controllerLongitud2: controllerLongitud2!,
                )
              ),
              Container(
                height:40,
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFFRegistroZona(
                        controller: controllerNombreZona!, 
                        labelText: "Nombre zona",
                        onChanged: (x){
    
                          zonaSeleccionada.nombreZona=x.toString();
                        }
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height:40,
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFFRegistroZona(
                        controller: controllerLatitud1!, 
                        labelText: "Latitud (P1)",
                        onChanged: (x){
                          zonaSeleccionada.area[0][0]=double.parse(x);
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                    SizedBox(
                      width:2
                    ),
                    Expanded(
                      child: TextFFRegistroZona(
                        controller: controllerLongitud1!, 
                        labelText: "Longitud (P1)",
                        onChanged: (x){
                          zonaSeleccionada.area[0][1]=double.parse(x);
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height:40,
                padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFFRegistroZona(
                        controller: controllerLatitud2!, 
                        labelText: "Latitud (P2)",
                        onChanged: (x){
                          zonaSeleccionada.area[1][0]=double.parse(x);
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                    SizedBox(
                      width:2
                    ),
                    Expanded(
                      child: TextFFRegistroZona(
                        controller: controllerLongitud2!, 
                        labelText: "Longitud (P2)",
                        onChanged: (x){
                          zonaSeleccionada.area[1][1]=double.parse(x);
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment:MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                    onPressed:(){
                      seleccionado=-1;
                      setState(() {
                        
                      });
                    },
                    child:Row(
                      children: [
                        Text("Limpiar")
                      ],
                    ),
                  ),
                  OutlinedButton(
                    onPressed: (){
                      if(seleccionado>=0){
                        useCaseGenerales.modificarZona(zonaSeleccionada).then((value) {
                          if(value){
                            zonas.removeAt(seleccionado);
                            zonas.add(zonaSeleccionada);
                            zonas.sort((a,b)=>a.nombreZona.compareTo(b.nombreZona));
                            setState(() {
                              
                            });
                          }
                        });
                      }else{
                        useCaseGenerales.registrarZona(widget.ciudad.id, zonaSeleccionada).then((value) {
                          if(value["completed"]){
                            zonas.add(value["zona"]);
                            zonas.sort((a,b)=>a.nombreZona.compareTo(b.nombreZona));
                            setState(() {
                              
                            });
                          }
                        });
                      }
                    }, 
                    child: Text(seleccionado>=0?"Modificar":"Registrar")
                  )
                ],
              ),
              Container(
                height: 140,
                //color: Colors.white,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: zonas.length,
                        itemBuilder: (context, index){
                          //final Zona zona=zonas[index];
                          return Column(
                            children: [
                              ListTile(
                                title:Text(zonas[index].nombreZona),
                                selected: seleccionado==index?true:false,
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("P1: [${zonas[index].area[0][0]},${zonas[index].area[0][1]}]"),
                                    Text("P2: [${zonas[index].area[1][0]},${zonas[index].area[1][1]}]")
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
                                    zonaSeleccionada=Zona.vacio();
                                    zonasNoSeleccionadas=[];
                                    zonasNoSeleccionadas.addAll(zonas);
                                  }else{
                                    seleccionado=index;
                                    controllerNombreZona!.text=zonas[index].nombreZona;
                                    controllerLatitud1!.text=zonas[index].area[0][0].toString();
                                    controllerLongitud1!.text=zonas[index].area[0][1].toString();
                                    controllerLatitud2!.text=zonas[index].area[1][0].toString();
                                    controllerLongitud2!.text=zonas[index].area[1][1].toString();
                                    zonaSeleccionada=Zona.copia(zonas[index]);
                                    zonasNoSeleccionadas=[];
                                    zonasNoSeleccionadas.addAll(zonas.where((element) => element.nombreZona!=zonas[index].nombreZona&&element.area!=zonas[index].area));
                                  }
                                  setState(() {
                                    
                                  });
                                },
                                trailing:  IconButton(
                                  onPressed: (){
                                    useCaseGenerales.eliminarZona(zonas[index].id).then((value){
                                      if(value){
                                        zonas.removeAt(index);
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
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}
class MapaListadoZonas extends StatefulWidget {
  MapaListadoZonas({Key? key,required this.zonas,required this.zona,
    required this.controllerLatitud1,
    required this.controllerLongitud1,
    required this.controllerLatitud2,
    required this.controllerLongitud2,
  }) : super(key: key);
  final List<Zona> zonas;
  final Zona zona;
  final TextEditingController controllerLatitud1;
  final TextEditingController controllerLongitud1;
  final TextEditingController controllerLatitud2;
  final TextEditingController controllerLongitud2;
  @override
  _MapaListadoZonasState createState() => _MapaListadoZonasState();
}

class _MapaListadoZonasState extends State<MapaListadoZonas> {
  var markers = <Marker>[];
  var points=<LatLng>[];
  var polylines=<Polyline>[];
  var nuevosMarkersZona=<Marker>[];
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
  void agregarMarker(Zona zona){
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
                icon: Icon(Icons.circle,color:colores[indexColor]),
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
                            Text("[${zona.area[j][0]}"),
                            Text("${zona.area[j][1]}")
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
  void agregarPolyline(Zona zona){
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
            strokeWidth: 3,
            color: colores[indexColor],
            isDotted: polylines.length<widget.zonas.length?true:false,
            //gradientColors: [Colors.blueAccent,Colors.indigo],
            //borderColor: colores[i],
            //borderStrokeWidth: 2,              //gradientColors: [Colors.indigo,Colors.orange]
        )
      );
    }
  }
  Future<List<Marker>> listarMakers(List<Zona> zonas) async{
    indexColor=0;
    markers=[];
    polylines=[];
    for(int i=0;i<zonas.length;i++){
      agregarMarker(zonas[i]);
      agregarPolyline(zonas[i]);
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
    listarMakers(widget.zonas);
    agregarMarker(widget.zona);
    agregarPolyline(widget.zona);
    
    print("zona area: ${widget.zona.area}");
    return FlutterMap(
        options: MapOptions(
          //center:LatLng(31,121),

          center:widget.zonas.length>0?LatLng(widget.zonas[0].area[0][0],widget.zonas[0].area[0][1]):LatLng(-19.044622966626424,-65.268857253123),
          zoom: 15,
          onTap: (tapPosition,point){
            if(widget.zona.area[0][0]==widget.zona.area[0][1]){
              
              widget.zona.area[0]=[point.latitude,point.longitude];
              widget.controllerLatitud1.text=widget.zona.area[0][0].toString();
              widget.controllerLongitud1.text=widget.zona.area[0][1].toString();
    
            }else{
              widget.zona.area[1]=[point.latitude,point.longitude];
              widget.controllerLatitud2.text=widget.zona.area[1][0].toString();
              widget.controllerLongitud2.text=widget.zona.area[1][1].toString();
            }
            if(widget.zona.area[1][0]!=widget.zona.area[1][1]){
              LatLng point1=LatLng(widget.zona.area[0][0],widget.zona.area[0][1]);
              LatLng point2=LatLng(widget.zona.area[1][0],widget.zona.area[1][1]);
              if(!verificarPunto(point1, point2)){
                widget.zona.area[0]=[0.0,0.0];
                widget.zona.area[1]=[0.0,0.0];
                widget.controllerLatitud1.text=widget.zona.area[0][0].toString();
                widget.controllerLongitud1.text=widget.zona.area[0][1].toString();
                widget.controllerLatitud2.text=widget.zona.area[1][0].toString();
                widget.controllerLongitud2.text=widget.zona.area[1][1].toString();
                ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Zona en área no permitida"));
              }
            }
            setState(() {
              
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
          PolylineLayerOptions(
            polylineCulling: false,
            polylines: polylines,

          ),
          MarkerLayerOptions(markers: markers),
          
        ],
      );
  }
  bool verificarPunto(LatLng point1,LatLng point2){
    bool correcto=true;
    List<LatLng> points=[point1,point2,new LatLng(point1.latitude,point2.longitude),new LatLng(point2.latitude,point1.longitude)];
    for(int i=0;i<widget.zonas.length;i++){
      List<List<dynamic>> area=widget.zonas[i].area;
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
class TextFFRegistroZona extends StatefulWidget {
  TextFFRegistroZona({Key? key,required this.controller,required this.labelText,
    required this.onChanged
  }) : super(key: key);
  final TextEditingController controller;
  final String labelText;
  final Function onChanged;
  @override
  _TextFFRegistroZonaState createState() => _TextFFRegistroZonaState();
}

class _TextFFRegistroZonaState extends State<TextFFRegistroZona> {
  final color=Colors.grey;
  final colorFill=Colors.white12;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
          controller: widget.controller,
          style: TextStyle(color: color,
            fontSize: 15
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(color: color.withOpacity(0.8),fontSize: 15),
            filled: true,
            fillColor: colorFill,
            labelText: widget.labelText,
            labelStyle: TextStyle(
              fontSize: 15
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: color.withOpacity(0.7))
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: color.withOpacity(0.7))
            ),
            
          ),
          onChanged:(x){ widget.onChanged(x);},
    );
  }
}