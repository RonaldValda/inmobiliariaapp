import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/ui/pages/principal/widgets/dialog_registro_inmueble_buscado.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_ordenacion.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_principales.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_secundarios_principal.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/popup_menu_item_opciones.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:fluttericon/entypo_icons.dart' as iconentypo;
import 'package:provider/provider.dart';
class AppBarPzd extends StatefulWidget with PreferredSizeWidget{
  AppBarPzd({Key? key}) : super(key: key);

  @override
  _AppBarPzdState createState() => _AppBarPzdState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _AppBarPzdState extends State<AppBarPzd> {
  bool ordenarActivado=false;
  @override
  Widget build(BuildContext context) {
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    final mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    final mapaFiltroOrden=Provider.of<MapaFiltroOtrosInfo>(context);
    final _inmueblesFiltrados=Provider.of<ListadoInmueblesFiltrado>(context);
    return DefaultTabController(
      length: 1,

      child: AppBar(
        excludeHeaderSemantics: true,
        toolbarHeight: 200,
        elevation: 0,
        leadingWidth: 30.0,
        title: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                FiltroTipoContrato(),
                SizedBox(
                  width:3
                ),
                PopupMenuButton(
                  elevation: 30,
                  offset: const Offset(0, -35),
                  color: Colors.white.withOpacity(0.8),
                  child: Row(
                    children: [
                      Icon(Icons.house,size:20),
                      Container(
                        child: 
                          Row(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                height:32,
                                child:Container(
                                  alignment: Alignment.center,
                                  width: mapaFiltroPrincipales.getMapaFiltro["tipo_inmueble"].toString().length<10?72:mapaFiltroPrincipales.getMapaFiltro["tipo_inmueble"].toString().length.toDouble()*8.2,
                                  child: Text(mapaFiltroPrincipales.getMapaFiltro["tipo_inmueble"],
                                    textAlign: TextAlign.right,
                                    style:TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal
                                    )
                                  ),
                                )
                              ),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.black,width: 0.2)
                            )
                          ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context){
                    return[
                      PopupMenuItem<int>(
                        padding: EdgeInsets.all(0),
                        value: 0, 
                        child: PMItemTipoInmueble()
                      ),
                    ];
                  }
                ),
                SizedBox(
                  width:3
                ),
                FiltroPrecio(),
                
              ],
            ),
          ),
        ),
        actions: [
          Container(
            width: 30,
            child: PopupMenuButton(
              tooltip: "Filtrar",
              elevation: 30,
              offset: const Offset(0, 40),
              color: Colors.white.withOpacity(0.8),
              enableFeedback: false,
              icon: iconc.FaIcon(iconc.FontAwesomeIcons.filter,size: 25,),
              padding: EdgeInsets.zero,
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    padding: EdgeInsets.all(5),
                    value: 0, 
                    child: FiltrosSecundariosPrincipal()
                  ),
                ];
              }
            ),
          ),
          if(!_estadoWidgets.isVerMapa)
          Row(
            children: [
              if(ordenarActivado)
              Row(
                children: [
                  Container(
                    width: 30,
                    child: PopupMenuButton(
                      tooltip: "Ordernar",
                      elevation: 30,
                      offset: const Offset(0, 40),
                      color: Colors.white.withOpacity(0.8),
                      enableFeedback: false,
                      icon:Icon(mapaFiltroOrden.getMapaFiltroOrden["orden"]==getOrden.ascendente.index?iconentypo.Entypo.up_thin:iconentypo.Entypo.down_thin),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context){
                        return [
                          PopupMenuItem<int>(
                            padding: EdgeInsets.all(5),
                            value: 0, 
                            child: FiltrosOrdenacion(),
                            //child: FiltrosOrdenacion()
                          ),
                        ];
                      }
                    ),
                  ),
                  Container(
                    width: 30,
                    child: PopupMenuButton(
                      tooltip: "Inmuebles buscados",
                      elevation: 30,
                      offset: const Offset(0, 40),
                      color: Colors.white.withOpacity(0.8),
                      enableFeedback: false,
                      icon:IconoNotificacion(numeroNotificacion: _inmueblesFiltrados.inmueblesBuscados.length),
                      padding: EdgeInsets.zero,
                      itemBuilder: (context){
                        return [
                          PopupMenuItem<int>(
                            padding: EdgeInsets.all(5),
                            value: 0, 
                            child: CargarInmuebleBuscado(),
                            //child: FiltrosOrdenacion()
                          ),
                        ];
                      }
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: (){
                  setState(() {
                    ordenarActivado=!ordenarActivado;
                  });
                }, 
                icon: Icon(
                  Icons.more_vert,size: 30,
                  color: ordenarActivado?Colors.blue:Colors.black,
                )
              ),
            ],
          ),
           /*Container(
            width: 30,
            child: PopupMenuButton(
              tooltip: "Ordernar",
              elevation: 30,
              offset: const Offset(0, 40),
              color: Colors.white.withOpacity(0.8),
              enableFeedback: false,
              icon:Icon(Icons.more_vert,size: 28,),
              padding: EdgeInsets.zero,
              itemBuilder: (context){
                return [
                  PopupMenuItem<int>(
                    padding: EdgeInsets.all(5),
                    value: 0, 
                    child: PopupMenuItemOpciones(),
                    //child: FiltrosOrdenacion()
                  ),
                ];
              }
            ),
          ),*/
        ],
      ),
    );
  }
}

class IconoNotificacion extends StatefulWidget {
  IconoNotificacion({Key? key,required this.numeroNotificacion}) : super(key: key);
  final int numeroNotificacion;
  @override
  _IconoNotificacionState createState() => _IconoNotificacionState();
}

class _IconoNotificacionState extends State<IconoNotificacion> {
  String notificacionTexto="";
  @override
  void initState() {
    super.initState();
    //numeroNotificacion=widget.inmuebles.length.toString();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.numeroNotificacion==0){
      notificacionTexto="";
    }else if(widget.numeroNotificacion>99){
      notificacionTexto="99+";
    }else{
      notificacionTexto=widget.numeroNotificacion.toString();
    }
    return Stack(
        children: [
          iconc.FaIcon(iconc.FontAwesomeIcons.solidFolderOpen,size: 25,),
          notificacionTexto!=""? Positioned(
            width: 20,
            height: 20,
            left: 10,
            top:00,
           // alignment: Alignment.topRight,
           // margin: EdgeInsets.only(top: 0,left: 5),
           // padding: EdgeInsets.all(0),
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xffc32c37),
                  border: Border.all(color: Colors.white, width: 1)),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Text(
                    notificacionTexto,
                    //_counter.toString(),
                    style: TextStyle(fontSize: 10,color: Colors.white),
                  ),
                ),
              ),
            ),
          ):Container(
            width: 30,
            height: 30,
          ),
        ],
      );
  }
}