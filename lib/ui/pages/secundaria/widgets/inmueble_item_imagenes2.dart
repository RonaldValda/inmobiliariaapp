import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_base.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/inmueble_item/icono_favorito.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/page_vista_inmueble.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
import 'package:shared_preferences/shared_preferences.dart';
class InmuebleItemImagenes2 extends StatefulWidget {
  InmuebleItemImagenes2({Key? key,required this.inmuebleTotal,required this.width,required this.height}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  final double width;
  final double height;
  @override
  _InmuebleItemImagenes2State createState() => _InmuebleItemImagenes2State();
}

class _InmuebleItemImagenes2State extends State<InmuebleItemImagenes2> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCaseInmuebleBase useCaseInmuebleBase=UseCaseInmuebleBase();
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final usuariosInfo=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    UseCaseInmueble useCaseInmueble=UseCaseInmueble();
    return Stack(
      children:[
        InkWell(
          child: CachedNetworkImage(
            imageUrl: widget.inmuebleTotal.getInmueble.mapImagenes["principales"][0],
            width: widget.width,
            height:widget.height-140,
            //filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            fadeInCurve: Curves.bounceOut,
            fadeInDuration: Duration(milliseconds: 200),
            placeholder: (context, url) {
              return Center(child: CircularProgressIndicator());
            },
            errorWidget: (context, url, error) {
              return Center(
                child:Icon(Icons.error,color:Colors.red)
              );
            },
          ),
          onTap: ()async{
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
            //inmuebleInfo.setInmueblesTotal(widget.inmuebleTotal);
            inmuebleInfo.moverInicioController();
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context)=>PageVistaInmueble(inmuebleTotal: widget.inmuebleTotal,index: 0,)
              )
            );
            inmuebleInfo.imagenesCategorias=[];
            inmuebleInfo.caracteristicaSeleccionada=-1;
          },
        ),
        Positioned(
              child: Container(
                    
                    color:Color.fromRGBO(50, 50, 50, 0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          //width: 200,
                          height: 25,
                          child: Row(
                            children: [
                                widget.inmuebleTotal.getInmuebleOtros.getVideo2DLink!=""? IconButton(
                                  onPressed: (){},
                                  padding: EdgeInsets.zero,
                                  splashRadius:20,
                                  tooltip: "Vídeo 2D",
                                  icon: Icon(Icons.video_collection,color:Colors.white,size: 20,)
                                ):Container(),
                                widget.inmuebleTotal.getInmuebleOtros.getTourVirtual360Link!=""? IconButton(
                                  onPressed: (){},
                                  padding: EdgeInsets.zero,
                                  splashRadius:20,
                                  tooltip: "Tour virtual 360",
                                  icon: Icon(Icons.web_sharp,color:Colors.white,size: 20,)
                                ):Container(),
                                widget.inmuebleTotal.getInmuebleOtros.getVideoTour360Link!=""? IconButton(
                                  onPressed: (){},
                                  padding: EdgeInsets.zero,
                                  splashRadius:20,
                                  tooltip: "Vídeo tour 360",
                                  icon: Icon(Icons.video_label,color:Colors.white,size: 20,)
                                ):Container(),
                            ],
                          ),
                        ),
                        usuariosInfo.tipoSesion=="Comprar"?Row(
                        children: [
                          widget.inmuebleTotal.getUsuarioFavorito.isDobleVisto?Icon(Icons.done_all,color: Colors.white,)
                          :
                          (widget.inmuebleTotal.getUsuarioFavorito.isVisto?Icon(Icons.done,color: Colors.white,):Container()),
                          SizedBox(width:5)
                        ],
                      ):usuariosInfo.tipoSesion=="Supervisar"?Row(
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
                          Icon(Icons.done_all,color: Colors.white,)
                        ],
                      ):
                      Container(),
                      ],
                    ),
                  ),
            ),
            Positioned(
              bottom: 0,
              width: widget.width,
              child: Container(
                padding: EdgeInsets.only(right: 10),
                color:Color.fromRGBO(50, 50, 50, 0.2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                usuariosInfo.tipoSesion=="Comprar"?
                IconoFavorito(
                  inmuebleTotal: widget.inmuebleTotal,)
                :
                usuariosInfo.tipoSesion=="Supervisar"?
                Container(
                    color:Color.fromRGBO(50, 50, 50, 0.2),
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
                :Container(height: 50,),
                  ],
                ),
              ),
            ),
      ]
    );
  }
}