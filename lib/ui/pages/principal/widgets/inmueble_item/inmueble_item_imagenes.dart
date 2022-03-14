import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_base.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/inmueble_item/icono_favorito.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/inmueble_item/inmueble_etiqueta.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/page_vista_inmueble.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
class InmuebleItemImagenes extends StatefulWidget {
  final InmuebleTotal inmuebleTotal;
  final int index;
  InmuebleItemImagenes({Key? key,required this.inmuebleTotal,required this.index}) : super(key: key);
  @override
  _InmuebleItemImagenesState createState() => _InmuebleItemImagenesState();
}

class _InmuebleItemImagenesState extends State<InmuebleItemImagenes> {
  double heightImagen=0;
  double width=0;
  //double movido=0;
  bool movido=false;
  double posicionInicial=0;
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCaseInmueble useCaseInmueble=UseCaseInmueble();
  UseCaseInmuebleBase useCaseInmuebleBase=UseCaseInmuebleBase();
  @override
  Widget build(BuildContext context) {
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final usuariosInfo=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(_estadoWidgets.isVerMapa){
      heightImagen=150;
      width=250;
    }else{
        if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
          heightImagen=MediaQuery.of(context).size.height/4;
          width=MediaQuery.of(context).size.width;
        }else{
          width=MediaQuery.of(context).size.width*0.6;
          heightImagen=MediaQuery.of(context).size.height/2.2;
        }
    }
    
    return Stack(
      children: [
        Positioned(
          child: Container(
            width: width,
            height:heightImagen+80,
            padding:EdgeInsets.all(2),
            child: PageView.builder(
              pageSnapping: true,
              allowImplicitScrolling: false,
              scrollDirection: Axis.horizontal,
              onPageChanged: (currentPage){
                if(usuariosInfo.tipoSesion=="Comprar"){
                  if(currentPage>1&&!widget.inmuebleTotal.getUsuarioFavorito.isVisto){
                    if(usuariosInfo.getUsuario.getId!=""){
                      widget.inmuebleTotal.getUsuarioFavorito.setDobleVisto(false);
                      widget.inmuebleTotal.getUsuarioFavorito.setVisto(true);
                      widget.inmuebleTotal.getUsuarioFavorito.setFavorito(false);
                      widget.inmuebleTotal.getUsuarioFavorito.setContactado(false);
                      _inmueblesFiltrado.setFiltrar(false);
                      usuariosInfo.setUsuarioInmuebleBases(filtrado_inmuebles.generarInmuebleBase(usuariosInfo.getUsuario.getId, _inmueblesFiltrado.getInmueblesTotalGeneral));
                      _inmueblesFiltrado.setInmueblesItem(widget.inmuebleTotal, _mapaFiltroOtros.getMapaFiltroOrden,"Modificar");
                      movido=true;
                      setState(() {
                        
                      });
                      useCaseInmueble.registrarFavoritos(usuariosInfo.usuario, widget.inmuebleTotal).then((bool respuesta) {
                        if(!respuesta){
                          widget.inmuebleTotal.getUsuarioFavorito.setDobleVisto(false);
                          widget.inmuebleTotal.getUsuarioFavorito.setVisto(false);
                          widget.inmuebleTotal.getUsuarioFavorito.setFavorito(false);
                          widget.inmuebleTotal.getUsuarioFavorito.setContactado(false);
                          _inmueblesFiltrado.setFiltrar(false);
                          _inmueblesFiltrado.setInmueblesItem(widget.inmuebleTotal, _mapaFiltroOtros.getMapaFiltroOrden,"Modificar");
                          setState(() {
                            
                          });
                        }
                      });
                    }
                  }
                }
              },
              itemCount: 3,
              itemBuilder: (context, index) {
                return InkWell(
                  child: CachedNetworkImage(
                    imageUrl: widget.inmuebleTotal.getInmueble.mapImagenes["principales"][index],
                    width: width,
                    height:heightImagen+80,
                    //filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    fadeInCurve: Curves.bounceOut,
                    fadeInDuration: Duration(milliseconds: 200),
                     progressIndicatorBuilder: (context, url, downloadProgress) {
                       return Center(child: CircularProgressIndicator(value: downloadProgress.progress));
                     },
                    errorWidget: (context, url, error) {
                      return Center(
                        child:Icon(Icons.error,color:Colors.red)
                      );
                    },
                  ),
                  onTap: ()async{
                    if(usuariosInfo.tipoSesion=="Comprar"){
                      if(!widget.inmuebleTotal.getUsuarioFavorito.isDobleVisto){
                        widget.inmuebleTotal.getUsuarioFavorito.setDobleVisto(true);
                        widget.inmuebleTotal.getUsuarioFavorito.setVisto(true);
                        widget.inmuebleTotal.getUsuarioFavorito.setFavorito(false);
                        widget.inmuebleTotal.getUsuarioFavorito.setContactado(false);
                        _inmueblesFiltrado.setFiltrar(false);
                        _inmueblesFiltrado.setConsultarBD(false);
                        _inmueblesFiltrado.setInmueblesItem(widget.inmuebleTotal,_mapaFiltroOtros.getMapaFiltroOrden,"modificar");
                        usuariosInfo.setUsuarioInmuebleBases(filtrado_inmuebles.generarInmuebleBase(usuariosInfo.getUsuario.getId, inmueblesTotalGeneral));
                        useCaseInmueble.registrarFavoritos(usuariosInfo.usuario, widget.inmuebleTotal).then((value){
                          if(value){
                            //ScaffoldMessenger.of(context).showSnackBar(showSnackBar("¡correcto!"));
                          }else{
                            widget.inmuebleTotal.getUsuarioFavorito.favorito=!widget.inmuebleTotal.getUsuarioFavorito.favorito;
                          }
                        }).whenComplete((){
                          useCaseInmuebleBase.registrarInmuebleBase(usuariosInfo.usuarioInmuebleBases, _prefs).whenComplete(() {
                          });
                        });
                      }
                    }
                    inmuebleInfo.setInmueblesTotal(widget.inmuebleTotal);
                    inmuebleInfo.moverInicioController();
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context)=>PageVistaInmueble(inmuebleTotal:widget.inmuebleTotal, index: widget.index,)
                      )
                    );
                    inmuebleInfo.caracteristicaSeleccionada=-1;
                  }
                );
              },
            ),
          ),
        ),
        Positioned(
          child: Container(
                width: width,
                color:Color.fromRGBO(50, 50, 50, 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _widgetIconosNavegacion(),
                    if(usuariosInfo.usuario.tipoUsuario!="Gerente"
                    &&usuariosInfo.tipoSesion=="Comprar"
                    )Row(
                      children: [
                        widget.inmuebleTotal.getUsuarioFavorito.isDobleVisto?Icon(Icons.done_all,color: Colors.white,)
                        :
                        (widget.inmuebleTotal.getUsuarioFavorito.isVisto?Icon(Icons.done,color: Colors.white,):Container()),
                        SizedBox(width:10)
                      ],
                    ),
                    if(usuariosInfo.usuario.tipoUsuario=="Gerente")
                    Row(
                      children: [
                        Text(widget.inmuebleTotal.inmueble.cantidadVistos.toString(),
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Icon(Icons.done,color: Colors.white,),
                        Text(widget.inmuebleTotal.inmueble.cantidadDobleVistos.toString(),
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                        Icon(Icons.done_all,color: Colors.white,),
                        SizedBox(width: 10,)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              width: width,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                color:Color.fromRGBO(50, 50, 50, 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                if(usuariosInfo.tipoSesion=="Comprar")
                IconoFavorito(
                  inmuebleTotal: widget.inmuebleTotal,),
                if(usuariosInfo.tipoSesion=="Supervisar"||usuariosInfo.tipoSesion=="Observar")
                Container(
                    //color:Color.fromRGBO(50, 50, 50, 0.2),
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width:20),
                        SizedBox(width:MediaQuery.of(context).size.width/12),
                        Row(
                          children: [
                            Text(widget.inmuebleTotal.inmueble.cantidadFavoritos.toString(),
                              style: TextStyle(
                                color: Colors.white
                              ),
                            ),
                            Icon(Icons.favorite,size: 30,color: Colors.white,),
                          ],
                        ),
                      ],
                    ),
                  )
                  ],
                ),
              ),
            ),
          if(widget.inmuebleTotal.inmueble.estadoNegociacion!="Sin negociar"&&widget.inmuebleTotal.inmueble.estadoNegociacion!="")
          Positioned(
            top: heightImagen/2-25,
            left: widget.inmuebleTotal.inmueble.estadoNegociacion=="Vendido"?
            MediaQuery.of(context).size.width/2-25:-10,
            child: Container(
              width: 50,
              height: 150,
              child: InmuebleEtiqueta(inmuebleTotal: widget.inmuebleTotal,),
            ),
          )
      ],
    );
  }
  Widget _widgetIconosNavegacion(){
    return Container(
      height: 30,
      child: Row(
        children: [
            widget.inmuebleTotal.getInmuebleOtros.getVideo2DLink!=""? IconButton(
              onPressed: (){},
              padding: EdgeInsets.zero,
              splashRadius:20,
              tooltip: "Vídeo 2D",
              icon: Icon(Icons.video_collection,color:Colors.white,size: 25,)
            ):Container(),
            widget.inmuebleTotal.getInmuebleOtros.getTourVirtual360Link!=""? IconButton(
              onPressed: (){},
              padding: EdgeInsets.zero,
              splashRadius:20,
              tooltip: "Tour virtual 360",
              icon: Icon(Icons.web_sharp,color:Colors.white,size: 25,)
            ):Container(),
            widget.inmuebleTotal.getInmuebleOtros.getVideoTour360Link!=""? IconButton(
              onPressed: (){},
              padding: EdgeInsets.zero,
              splashRadius:20,
              tooltip: "Vídeo tour 360",
              icon: Icon(Icons.video_label,color:Colors.white,size: 25,)
            ):Container(),
        ],
      ),
    );
  }
}