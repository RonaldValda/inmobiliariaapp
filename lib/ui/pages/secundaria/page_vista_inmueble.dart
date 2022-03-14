
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/acciones_vendedor.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/carateristicas_inmueble.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/editar_inmueble.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/iconos_acceso_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/imagenes_tabbar.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/inmueble_item_encabezado2.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/inmueble_item_pie_pagina2.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/acciones.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/acciones_inmueble_super_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
import 'package:sliding_up_panel/sliding_up_panel.dart';
const imageHeight=260.0;
const imageWidth=300.0;
class PageVistaInmueble extends StatefulWidget {
  final int index;
  final InmuebleTotal inmuebleTotal;
  PageVistaInmueble({Key? key,required this.index,required this.inmuebleTotal}) : super(key: key);

  @override
  _PageVistaInmuebleState createState() => _PageVistaInmuebleState();
}

class _PageVistaInmuebleState extends State<PageVistaInmueble> with TickerProviderStateMixin{
   var markers = <Marker>[];
   double zoom=15.0;
   double minHeightSliding=0.0;
   double maxHeightSliding=0.0;
   double minHeightSlidingDefecto=0.0;
   bool cambiarSliding=true;
   int contadorCeros=0;
  void incrementarZoom(){
    if(zoom<=50.0){
      setState(() {
        zoom=zoom+5;
        print(zoom);
      });
    }
  }
  void decrementarZoom(){
    if(zoom>=5){
      setState(() {
        zoom=zoom-5;
        print(zoom);
      });
    }
  }
  //ImagenesInmuebleInfo? imagenesInmueble=ImagenesInmuebleInfo();
  List<InmuebleTotal> inmueblesSimilares=[];
  PanelController panelController=PanelController();
  double imagenHeight=0;
  double imagenWidth=0;
  bool isVertical=true;
  @override
  void initState() { 
    //print(widget.inmuebleTotal.getInmueble.getImagenesCategorias);
    //imagenesInmueble!.init(this,widget.inmuebleTotal.getInmueble.getImagenesCategorias,widget.inmuebleTotal.getInmueble.categoriasImagen);
    super.initState();
    
    
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    final usuario=Provider.of<UsuariosInfo>(context);
    if(inmuebleInfo.cambiarSliding){
      if(inmuebleInfo.caracteristicaSeleccionada>=0){
        if(isVertical){
          minHeightSlidingDefecto=(MediaQuery.of(context).size.height-MediaQuery.of(context).size.width*0.7-250);
          maxHeightSliding=MediaQuery.of(context).size.height-MediaQuery.of(context).size.width*0.7-100;
        }else{
           maxHeightSliding=MediaQuery.of(context).size.height-100;
        }
        minHeightSliding=0;
        int milliseconds=((maxHeightSliding-minHeightSliding)*0.6).toInt();
        if(milliseconds<0){
          milliseconds=0;
        }
        panelController.animatePanelToSnapPoint(duration:Duration(milliseconds: milliseconds));
     }else{
        minHeightSliding=0.0;
        maxHeightSliding=0.0;
      }
    }
    if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      isVertical=true;
      imagenWidth=MediaQuery.of(context).size.width;
      imagenHeight=imagenWidth*0.7;
    }else{
      isVertical=false;
      imagenHeight=MediaQuery.of(context).size.height*.8;
      imagenWidth=MediaQuery.of(context).size.width/1.9;
    }
    inmueblesSimilares=[];
    inmueblesSimilares=filtrado_inmuebles.seleccionarInmuebleSimilares(inmueblesTotalGeneral, widget.inmuebleTotal);
    markers=[];
    markers.add(
      Marker(
        width: 50,
        height: 50,
        point: LatLng(widget.inmuebleTotal.getInmueble.getCoordenadas[0],widget.inmuebleTotal.getInmueble.getCoordenadas[1]),
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
    
    //imagenesInmueble!.init(this,widget.inmuebleTotal.getInmueble.getImagenesCategorias,widget.inmuebleTotal.getInmueble.categoriasImagen,imageWidth);
    return Scaffold(
       body: SafeArea(
         //maintainBottomViewPadding: true,
         top: true,
         bottom: false,
         minimum: EdgeInsets.zero,
         child: SlidingUpPanel(
           body: Container(
             height: MediaQuery.of(context).size.height,
             padding: EdgeInsets.fromLTRB(0, 0, 0, 25),
             child:Row(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Expanded(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Expanded(
                         child: Column(
                           children: [
                              ImagenesTabBar(inmuebleTotal:widget.inmuebleTotal),
                              SizedBox(height:MediaQuery.of(context).size.height/60),
                              usuario.tipoSesion=="Comprar"?IconosAccesoUsuario(inmuebleTotal: widget.inmuebleTotal):Container(),
                              usuario.tipoSesion=="Vender"?EditarInmueble():Container(),
                              if(isVertical)
                              Expanded(
                                child: Column(
                                  children: [
                                    SizedBox(height:MediaQuery.of(context).size.height/60),
                                    Expanded(
                                      child: ListView(
                                        children: [
                                          CaracteristicasInmueble(),
                                          Divider(),
                                          SizedBox(height:MediaQuery.of(context).size.height/30),
                                          if(MediaQuery.of(context).size.height<1100)
                                            usuario.tipoSesion=="Comprar"?
                                            listadoInmeblesSimilares(context)
                                            :Container(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                           ],
                         ),
                       ),
                       if(MediaQuery.of(context).size.height>1100)
                       usuario.tipoSesion=="Comprar"?
                       listadoInmeblesSimilares(context)
                       :Container(),
                       usuario.tipoSesion=="Administrar"? Row(
                         mainAxisAlignment:MainAxisAlignment.center,
                         children: [
                           Acciones()
                         ],
                       ):usuario.tipoSesion=="Supervisar"?Row(
                         mainAxisAlignment:MainAxisAlignment.center,
                         children: [
                           AccionesInmuebleSuperUsuario()
                         ],
                       ):
                       usuario.tipoSesion=="Vender"?Row(
                         mainAxisAlignment:MainAxisAlignment.center,
                         children: [
                           AccionesVendedor(inmuebleTotal: widget.inmuebleTotal)
                         ],
                       ):Container(),
                       
                       //AccionesSolicitudes(inmuebleTotal: widget.inmuebleTotal)
                     ],
                   ),
                 ),
                 if(!isVertical)
                  Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width-imagenWidth,
                    child: Column(
                      children: [
                        SizedBox(height:MediaQuery.of(context).size.height/60),
                        Expanded(
                          child: ListView(
                            children: [
                              CaracteristicasInmueble(),
                              Divider(),
                              SizedBox(height:MediaQuery.of(context).size.height/30),
                              if(MediaQuery.of(context).size.height<1100)
                                usuario.tipoSesion=="Comprar"?
                                listadoInmeblesSimilares(context)
                                :Container(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
               ],
             )
           ),
           header:Container(
             height: 20,
             width: isVertical?MediaQuery.of(context).size.width:MediaQuery.of(context).size.width-imagenWidth,
             child: Center(
               child: Container(
                 width: 30,
                 height: 5,
                 decoration: BoxDecoration(
                   color: Colors.grey[300],
                   borderRadius:BorderRadius.circular(12)
                 ),
               ),
             ),
           ),
           margin: isVertical?EdgeInsets.only(left: 0,right: 0):EdgeInsets.only(left: imagenWidth,right: 0),
           parallaxOffset:5,
           snapPoint: .6,
           //defaultPanelState: PanelState.OPEN,
           panelSnapping: true,
           borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),),
           minHeight: minHeightSliding,
           maxHeight: maxHeightSliding,
           //renderPanelSheet: false,

           onPanelClosed: (){
             inmuebleInfo.cambiarSliding=false;
             inmuebleInfo.setCaracteristicaSeleccionada(-1);
           },
           controller: panelController,
           isDraggable: true,
           backdropTapClosesPanel: true,
           
           panelBuilder: (controller) {
             return Card(
                color: Colors.transparent,
                elevation: 20,
                shadowColor: Colors.white,
                borderOnForeground: true,
                semanticContainer: true,
                child: Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius:BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),),
                      color: Colors.white
                    ),
                    child: ListView(
                      controller: controller,
                      children: [
                        CaracteristicasInfoDetalle(inmuebleTotal: widget.inmuebleTotal,)
                      ],
                    ),
                  ),
              );
           },
         ),
       ),
    );
  }
  Widget listadoInmeblesSimilares(BuildContext context){
    double listaWidth=0.0;
    double listaHeight=0.0;
    double itemWidth=0.0;
    double itemHeight=0.0;
    if(isVertical){
      listaHeight=MediaQuery.of(context).size.width/1.4;
      listaWidth=MediaQuery.of(context).size.width;
      itemWidth=listaWidth/2;
      itemHeight=listaHeight;
    }else{
      listaHeight=MediaQuery.of(context).size.height*0.7;
      listaWidth=MediaQuery.of(context).size.width-imagenWidth;
      itemWidth=listaWidth/2;
      itemHeight=listaHeight;
    }
    return Container(
      height: listaHeight,
      width: listaWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("   Más inmueble similares....",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 18,
              fontStyle: FontStyle.italic,
              //decoration: TextDecoration.underline
            ),
          ),
          Expanded(
            child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: (inmueblesSimilares.length~/2).ceil(),
              itemBuilder: (context, index) {
                var inmueble=inmueblesSimilares[index];
                var inmueble1=InmuebleTotal.vacio();
                if(((inmueblesSimilares.length~/2).ceil()+index)<inmueblesSimilares.length){
                  inmueble1=inmueblesSimilares[(inmueblesSimilares.length~/2).ceil()+index];
                }
                return Row(
                  children: [
                    Card(
                      margin: EdgeInsets.all(0),
                      elevation: 10,
                      child: Container(
                        //height: 120,
                        padding: EdgeInsets.all(0),
                        width: itemWidth,
                        child: Column(
                          children: [
                            InmuebleItemEncabezado2(
                              inmuebleTotal: inmueble,
                              width: itemWidth,
                              height: itemHeight,
                            ),
                            PiePagina2(inmuebleTotal: inmueble, index: index)
                          ],
                        ),
                      ),
                    ),
                    inmueble1.inmueble.id!=""?
                    Card(
                      margin: EdgeInsets.all(0),
                      elevation: 10,
                      shadowColor: Colors.red,
                      child: Container(
                        //height: 120,
                        padding: EdgeInsets.all(0),
                        width: itemWidth,
                        child: Column(
                          children: [
                            InmuebleItemEncabezado2(
                              inmuebleTotal: inmueble1,
                              width: itemWidth,
                              height: itemHeight,
                            ),
                            PiePagina2(inmuebleTotal: inmueble1, index: index)
                          ],
                        ),
                      ),
                    ):Container(),
                  ],
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
class CaracteristicasInfoDetalle extends StatefulWidget {
  CaracteristicasInfoDetalle({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _CaracteristicasInfoDetalleState createState() => _CaracteristicasInfoDetalleState();
}

class _CaracteristicasInfoDetalleState extends State<CaracteristicasInfoDetalle> {
  List<Widget> children=<Widget>[];
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    children=childrenInfo(widget.inmuebleTotal,inmuebleInfo);
    return Container(
      child: Column(
        children: [
          Text(titulo(inmuebleInfo),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
            ),
          ),
          Column(
            children: [
              Wrap(
                children: children
                
              )
            ],
          )
        ],
      ),
    );
  }
  String titulo(InmuebleInfo inmuebleInfo){
    if(inmuebleInfo.caracteristicaSeleccionada==0){
      return "Internas";
    }else if(inmuebleInfo.caracteristicaSeleccionada==1){
      return "Comunidad";
    }else if(inmuebleInfo.caracteristicaSeleccionada==2){
      return "Generales";
    }else{
      return "";
    }
  }
  List<Widget> childrenInfo(InmuebleTotal inmuebleTotal,InmuebleInfo inmuebleInfo){
    List<Widget> children=<Widget>[];
    if(inmuebleInfo.caracteristicaSeleccionada==0){
      InmuebleInternas inmuebleInternas=widget.inmuebleTotal.getInmuebleInternas;
      Map<String,dynamic> map=generarTextoInternas(inmuebleInternas,inmuebleInfo);
      for(int i=0;i<map["categorias"].length;i++){
        children.add(
            Wrap(
            alignment: WrapAlignment.start,
            children: [
              inmuebleInfo.buscarPosicionCategoria(map["keys"][i])<inmuebleInfo.categoriasKeys.length?
              Container(
                width: 150,
                padding: EdgeInsets.all(5),
                child: TextButton(
                  onPressed: (){
                    int index=inmuebleInfo.buscarPosicionCategoria(map["keys"][i]);
                    if(index<inmuebleInfo.categoriasKeys.length){
                      inmuebleInfo.cambiarSliding=false;
                      inmuebleInfo.onCategoriaSelected(index);
                    }
                  }, 
                  child: Column(
                    children: [
                      map["iconos"][i],
                      Text(map["categorias"][i],
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  )
                ),
              ):Container(
                width: 150,
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    map["iconos"][i],
                    Text(map["categorias"][i],
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }
      children.add(
            Wrap(
            alignment: WrapAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width:MediaQuery.of(context).size.width/1.2,
                //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Detalles: ${inmuebleInternas.detallesInternas}"),
                  ],
                ),
              ),
            ],
          ),
      );
    }else if(inmuebleInfo.caracteristicaSeleccionada==1){
      InmuebleComunidad inmuebleComunidad=widget.inmuebleTotal.inmuebleComunidad;
      Map<String,dynamic> map=generarTextoComunidad(inmuebleComunidad);
      for(int i=0;i<map["categorias"].length;i++){
        children.add(
             Wrap(
              alignment: WrapAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(15),
                  //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  child: Column(
                    children: [
                      map["iconos"][i],
                      Text(map["categorias"][i]),
                    ],
                  ),
                ),
              ],
            ),
        );
      }
        children.add(
            Wrap(
            alignment: WrapAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width:MediaQuery.of(context).size.width/1.2,
                //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Detalles: ${inmuebleComunidad.detallesComunidad}"),
                  ],
                ),
              ),
            ],
          ),
      );
    }
    else if(inmuebleInfo.caracteristicaSeleccionada==2){
      Inmueble inmueble=widget.inmuebleTotal.getInmueble;
      Map<String,dynamic> map=generarTextoGeneral(inmueble);
      
      for(int i=0;i<map["categorias"].length;i++){
        children.add(
            Wrap(
            alignment: WrapAlignment.start,
            children: [
              Container(
                //color:Colors.amber,
                width: map["categorias"][i].length<30?150:150,
                padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      map["iconos"][i],
                      Text(map["categorias"][i],
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        );
      }
      children.add(
            Wrap(
            alignment: WrapAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width:MediaQuery.of(context).size.width/1.2,
                //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Detalles: ${inmueble.detallesGenerales}"),
                  ],
                ),
              ),
            ],
          ),
      );
      InmueblesOtros inmuebleOtros=widget.inmuebleTotal.getInmuebleOtros;
      Map<String,dynamic> mapOtros=generarTextoOtros(inmuebleOtros, inmueble);
      for(int i=0;i<mapOtros["categorias"].length;i++){
        children.add(
            Wrap(
            alignment: WrapAlignment.start,
            children: [
              Container(
                //color:Colors.amber,
                width: mapOtros["categorias"][i].length<30?150:250,
                padding: EdgeInsets.all(5),
                  child: Column(
                    children: [
                      mapOtros["iconos"][i],
                      Text(mapOtros["categorias"][i],
                        style: TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.normal
                        ),
                      ),
                    ],
                  )
              )
            ],
          ),
        );
      }
      children.add(
            Wrap(
            alignment: WrapAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(15),
                width:MediaQuery.of(context).size.width/1.2,
                //margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Otros detalles: ${inmuebleOtros.detallesOtros}"),
                  ],
                ),
              ),
            ],
          ),
      );
    }
    return children;
  }
  Map<String,dynamic> generarTextoGeneral(Inmueble inmueble){
    Map<String,dynamic> map={};
    List<Widget> iconos=[];
    List<String> categorias=[];
    categorias.add("En ${inmueble.tipoContrato}");
    iconos.add(Icon(Icons.document_scanner,size: 22,color: Colors.black,));
    categorias.add("${inmueble.tipoInmueble}");
    iconos.add(Icon(Icons.house_siding,size: 22,color: Colors.black,));
    categorias.add("${inmueble.precio}"+r"$");
    iconos.add(Icon(Icons.money,size: 22,color: Colors.black,));
    iconos.add(Icon(Icons.public));
    categorias.add("Ubicado en: "+inmueble.getDireccion+", zona: "+inmueble.getNombreZona+", ciudad: "+inmueble.getCiudad);
    
    categorias.add("${inmueble.getSuperficieTerreno.toString()}m2 de terreno");
    iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.vectorSquare,size: 20));
    categorias.add("${inmueble.superficieConstruccion.toString()}m2 de construcción");
    iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.square,size: 20));
    categorias.add("${inmueble.tamanioFrente.toString()}m de frente");
    iconos.add(Icon(Icons.house,size: 22,color: Colors.black,));
    if(!inmueble.proyectoPreventa) {
      categorias.add("${inmueble.antiguedadConstruccion.toString()} años de antigüedad");
      iconos.add(Icon(Icons.calendar_today,size: 22,color: Colors.black,));
    }
    if(inmueble.mascotasPermitidas){ 
      categorias.add("Mascota permitidas");
       iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.dog,size:20,color: Colors.black,));
    }
    if(inmueble.isSinHipoteca){
      categorias.add("Sin hipoteca");
      iconos.add(Icon(Icons.check_box_outlined,size: 22,color: Colors.black,));
    }
    if(inmueble.construccionEstrenar) {
      categorias.add("Construcción a estrenar");
      iconos.add(Icon(Icons.fiber_new,size: 22,color: Colors.black,));
    }
    if(inmueble.materialesPrimera) {
      categorias.add("Materiales de primera");
      iconos.add(Icon(Icons.construction,size: 22,color: Colors.black,));
    }
    if(inmueble.proyectoPreventa){
      categorias.add("Proyecto preventa");
      iconos.add(Icon(Icons.eight_mp,size: 22,color: Colors.black,));
    }
    if(inmueble.isInmuebleCompartido){
      categorias.add("${inmueble.getNumeroDuenios.toString()} dueños");
      iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.userFriends,size:20,color: Colors.black,));
    }else{
       iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.user,size:20,color: Colors.black,));
      categorias.add("Único dueño");
    }
    if(inmueble.serviciosBasicos){
      categorias.add("Servicios básicos (luz,agua,etc)");
      iconos.add(Icon(Icons.light,size: 22,color: Colors.black,));
    } 

    if(inmueble.gasDomiciliario){
      categorias.add("Gas domiciliario");
      iconos.add(Icon(Icons.ac_unit,size: 22,color: Colors.black,));
    }
    if(inmueble.wifi) {
      categorias.add("Wi-Fi");
      iconos.add(Icon(Icons.wifi,size: 22,color: Colors.black,));
    }
    if(inmueble.medidorIndependiente) {
      categorias.add("Medidor independiente");
      iconos.add(Icon(Icons.tab_unselected,size: 22,color: Colors.black,));
    }
    if(inmueble.termotanque) {
      categorias.add("Termotanques");
      iconos.add(Icon(Icons.thermostat,size: 22,color: Colors.black,));
    }
    if(inmueble.calleAsfaltada) {
      categorias.add("Calle asfaltada");
       iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.streetView,size:20,color: Colors.black,));
    }
    if(inmueble.transporte) {
      categorias.add("Transporte de 0 - 100m");
       iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.bus,size:20,color: Colors.black,));
    }
    if(inmueble.preparadoDiscapacidad) {
      categorias.add("Preparado para discapacidad");
       iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.wheelchair,size:20,color: Colors.black,));
    }
    if(inmueble.papelesOrden){
      categorias.add("Papeles en orden");
       iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.dochub,size:20,color: Colors.black,));
    }
    if(inmueble.habilitadoCredito){
      categorias.add("Habilitado para crédito de vivienda social");
       iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.checkCircle,size:20,color: Colors.black,));
    } 
    map["iconos"]=iconos;
    map["categorias"]=categorias;
    return map;
  }
  Map<String,dynamic> generarTextoInternas(InmuebleInternas inmuebleInternas,InmuebleInfo inmuebleInfo){
    Map<String,dynamic> map={};
    //map["ambientes"]=4;
    List<String> categorias=[];
    List<String> keys=[];
    List<Widget> iconos=[];
    //print(map);
    if(inmuebleInternas.plantas>0){
      categorias.add("Plantas: ${inmuebleInternas.plantas}");
      keys.add("plantas");
      if(inmuebleInfo.buscarPosicionCategoria("plantas")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.horizontal_split_outlined,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.horizontal_split_outlined,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.ambientes>0){
      categorias.add("Ambientes: ${inmuebleInternas.ambientes}");
      keys.add("ambientes");
      if(inmuebleInfo.buscarPosicionCategoria("ambientes")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.other_houses_rounded,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.other_houses_rounded,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.dormitorios>0){
      categorias.add("Dormitorios: ${inmuebleInternas.dormitorios}");
      keys.add("dormitorios");
      if(inmuebleInfo.buscarPosicionCategoria("dormitorios")<inmuebleInfo.categoriasKeys.length){
        iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.bed,size:20,color: Colors.blue));
      }else{
        iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.bed,size:20,color:Colors.black));
      }
      
    }
    if(inmuebleInternas.banios>0){
      categorias.add("Baños: ${inmuebleInternas.banios}");
      keys.add("banios");
      if(inmuebleInfo.buscarPosicionCategoria("banios")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.bathroom,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.bathroom,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.garaje>0){
      categorias.add("Garaje: ${inmuebleInternas.garaje}");
      keys.add("garaje");
      
      if(inmuebleInfo.buscarPosicionCategoria("garaje")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.garage,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.garage,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.amoblado){
      categorias.add("Amoblado");
      keys.add("amoblado");
      if(inmuebleInfo.buscarPosicionCategoria("amoblado")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.living,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.living,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.lavanderia){
      categorias.add("Lavanderia");
      keys.add("lavanderia");
      
      if(inmuebleInfo.buscarPosicionCategoria("lavanderia")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.wash,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.wash,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.cuartoLavado){
      categorias.add("Cuarto de lavado");
      keys.add("cuarto_lavado");
      if(inmuebleInfo.buscarPosicionCategoria("cuarto_lavado")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.wash_sharp,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.wash_sharp,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.churrasquero){
      categorias.add("Churrasquero");
      keys.add("churrasquero");
      
      if(inmuebleInfo.buscarPosicionCategoria("churrasquero")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.outdoor_grill,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.outdoor_grill,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.azotea){
      categorias.add("Azotea");
      keys.add("azotea");
      if(inmuebleInfo.buscarPosicionCategoria("azotea")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.roofing,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.roofing,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.condominioPrivado){
      categorias.add("[Club house]-> Condominio privado");
      keys.add("condominio_privado");
      if(inmuebleInfo.buscarPosicionCategoria("condominio_privado")<inmuebleInfo.categoriasKeys.length){
        iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.houseDamage,size:20,color: Colors.blue,));
      }else{
        iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.houseDamage,size:20,color: Colors.black,));
      }
    }
    if(inmuebleInternas.cancha){
      categorias.add("Cancha de fútbol, tenis, etc. en inmueble");
      keys.add("cancha");
      if(inmuebleInfo.buscarPosicionCategoria("cancha")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.sports_baseball,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.sports_baseball,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.piscina){
      categorias.add("Piscina");
      keys.add("piscina");
      if(inmuebleInfo.buscarPosicionCategoria("piscina")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.pool,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.pool,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.sauna){
      categorias.add("Sauna");
      keys.add("sauna");
      if(inmuebleInfo.buscarPosicionCategoria("sauna")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.water,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.water,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.jacuzzi){
      categorias.add("Jacuzzi");
      keys.add("jacuzzi");
      if(inmuebleInfo.buscarPosicionCategoria("jacuzzi")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.bathtub,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.bathtub,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.estudio){
      categorias.add("Estudio");
      keys.add("estudio");
      if(inmuebleInfo.buscarPosicionCategoria("estudio")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.book,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.book,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.jardin){
      categorias.add("Jardín");
      keys.add("jardin");
      if(inmuebleInfo.buscarPosicionCategoria("jardin")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.yard,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.yard,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.portonElectrico){
      categorias.add("Portón eléctrico");
      keys.add("porton_electrico");
      if(inmuebleInfo.buscarPosicionCategoria("porton_electrico")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.games_outlined,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.games_outlined,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.aireAcondicionado){
      categorias.add("Aire acondicionado");
      keys.add("aire_acondicionado");
      if(inmuebleInfo.buscarPosicionCategoria("aire_acondicionado")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.air,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.air,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.calefaccion){
      categorias.add("Calefacción");
      keys.add("calefaccion");
      if(inmuebleInfo.buscarPosicionCategoria("calefaccion")<inmuebleInfo.categoriasKeys.length){
        iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.cube,size:20,color:Colors.blue));
      }else{
        iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.cube,size:20,color: Colors.black,));
      }
    }
    if(inmuebleInternas.ascensor){
      categorias.add("Ascensor");
      keys.add("ascensor");
      if(inmuebleInfo.buscarPosicionCategoria("ascensor")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.arrow_circle_up_outlined,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.arrow_circle_up_outlined,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.deposito){
      categorias.add("Depósito");
      keys.add("deposito");
      if(inmuebleInfo.buscarPosicionCategoria("deposito")<inmuebleInfo.categoriasKeys.length){
        iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.houzz,size:20,color: Colors.blue,));
      }else{
        iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.houzz,size:20,color: Colors.black));
      }
    }
    if(inmuebleInternas.sotano){
      categorias.add("Sótano");
      keys.add("sotano");
      if(inmuebleInfo.buscarPosicionCategoria("sotano")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.arrow_circle_down_outlined,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.arrow_circle_down_outlined,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.balcon){
      categorias.add("Balcón");
      keys.add("balcon");
      if(inmuebleInfo.buscarPosicionCategoria("balcon")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.house_siding,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.house_siding,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.tienda){
      categorias.add("Tienda");
      keys.add("tienda");
      if(inmuebleInfo.buscarPosicionCategoria("tienda")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.shop,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.shop,size: 22,color: Colors.black,));
      }
    }
    if(inmuebleInternas.amuralladoTerreno){
      categorias.add("[Amurallado]-> Terreno");
      keys.add("amurallado_terreno");
      if(inmuebleInfo.buscarPosicionCategoria("amurallado_terreno")<inmuebleInfo.categoriasKeys.length){
        iconos.add(Icon(Icons.crop_square,size: 22,color: Colors.blue,));
      }else{
        iconos.add(Icon(Icons.crop_square,size: 22,color: Colors.black,));
      }
    }
    /*if(texto.length>2){
      if(texto.substring(1,2)=="|") texto=texto.substring(2,texto.length);
    }*/
    map["categorias"]=categorias;
    map["keys"]=keys;
    map["iconos"]=iconos;
    return map;
  }
  Map<String,dynamic> generarTextoComunidad(InmuebleComunidad inmuebleComunidad){
    Map<String,dynamic> map={};
    List<String> categorias=[];
    List<Widget> iconos=[];
    if(inmuebleComunidad.isIglesia){
      categorias.add("Iglesia");
      iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.church,size:20,color:Colors.black));
    }
    if(inmuebleComunidad.parqueInfantil) {
      categorias.add("Parque infantil");
      iconos.add(Icon(Icons.park,size: 22,color: Colors.black,));
    }
    if(inmuebleComunidad.escuela){
      categorias.add("Escuela");
      iconos.add(Icon(Icons.school,size: 22,color: Colors.black,));
    }
    if(inmuebleComunidad.universidad){
      categorias.add("Universidad");
      iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.university,size:20,color:Colors.black));
    }
    if(inmuebleComunidad.plazuela) {
      categorias.add("Plazuela");
      iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.square,size:20,color:Colors.black));
    }
    
    if(inmuebleComunidad.moduloPolicial) {
      categorias.add("Módulo policial");
      iconos.add(Icon(Icons.policy,size: 22,color: Colors.black,));
    }
    if(inmuebleComunidad.saunaPiscinaPublica) {
      categorias.add("Sauna / piscina pública");
      iconos.add(Icon(Icons.pool,size: 22,color: Colors.black,));
    }
    if(inmuebleComunidad.gymPublico) {
      categorias.add("Gym público");
      iconos.add(Icon(Icons.cabin,size: 22,color: Colors.black,));
    }
    if(inmuebleComunidad.centroDeportivo) {
      categorias.add("Centro deportivo");
      iconos.add(Icon(Icons.sports_basketball,size: 22,color: Colors.black,));
    }
    if(inmuebleComunidad.puestoSalud) {
      categorias.add("Puesto de salud");
      iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.hospitalUser,size:20,color:Colors.black));
    }
    if(inmuebleComunidad.zonaComercial) {
      categorias.add("Zona comercial");
      iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.shopware,size:20,color:Colors.black));
    }
    
    map["categorias"]=categorias;
    map["iconos"]=iconos;
    return map;
  }
  Map<String,dynamic> generarTextoOtros(InmueblesOtros inmuebleOtros,Inmueble inmueble){
    Map<String,dynamic> map={};
    List<String> categorias=[];
    List<Widget> iconos=[];
    categorias.add("${inmueble.estadoNegociacion}");
    iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.handHoldingUsd,size: 20));
    categorias.add("${inmueble.getDiasEntreFechas} días en P360");
    iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.calendarDay,size: 20));
    if(inmuebleOtros.rematesJudiciales){
      categorias.add("Remates judiciales");
      iconos.add(iconc.FaIcon(iconc.FontAwesomeIcons.buffer,size: 20));
    }
    map["categorias"]=categorias;
    map["iconos"]=iconos;
    return map;
  }
}
