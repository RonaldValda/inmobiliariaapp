import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_base.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

import 'package:inmobiliariaapp/domain/usecases/inmueble/filtrado_inmuebles.dart' as filtrado_inmuebles;
import 'package:shared_preferences/shared_preferences.dart';
class IconoFavorito extends StatefulWidget {
  IconoFavorito({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _IconoFavoritoState createState() => _IconoFavoritoState();
}

class _IconoFavoritoState extends State<IconoFavorito> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCaseInmueble useCaseInmueble=UseCaseInmueble();
  UseCaseInmuebleBase useCaseInmuebleBase=UseCaseInmuebleBase();
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final UsuariosInfo usuariosInfo=Provider.of<UsuariosInfo>(context);
    return Container(
        //color:Color.fromRGBO(50, 50, 50, 0.2),
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
                Container(
                  height: 50,
                  child: IconButton(
                    onPressed: () {
                      if(usuariosInfo.getUsuario.getId!=""){
                        widget.inmuebleTotal.getUsuarioFavorito.setDobleVisto(true);
                        widget.inmuebleTotal.getUsuarioFavorito.setVisto(true);
                        widget.inmuebleTotal.getUsuarioFavorito.setFavorito(!widget.inmuebleTotal.getUsuarioFavorito.isFavorito);
                        widget.inmuebleTotal.getUsuarioFavorito.setContactado(false);
                        _inmueblesFiltrado.setFiltrar(false);
                        _inmueblesFiltrado.setConsultarBD(false);
                        if(widget.inmuebleTotal.getUsuarioFavorito.favorito)
                          widget.inmuebleTotal.inmueble.cantidadFavoritos=widget.inmuebleTotal.inmueble.cantidadFavoritos+1;
                        else
                          widget.inmuebleTotal.inmueble.cantidadFavoritos=widget.inmuebleTotal.inmueble.cantidadFavoritos-1;
                        
                        usuariosInfo.setUsuarioInmuebleBases(filtrado_inmuebles.generarInmuebleBase(usuariosInfo.getUsuario.getId, inmueblesTotalGeneral));
                        _inmueblesFiltrado.setInmueblesItem(widget.inmuebleTotal,_mapaFiltroOtros.getMapaFiltroOrden,"modificar");
                        
                        useCaseInmueble.registrarFavoritos(usuariosInfo.usuario, widget.inmuebleTotal).then((value){
                          if(value){
                            //ScaffoldMessenger.of(context).showSnackBar(showSnackBar("¡correcto!"));
                          }else{
                            widget.inmuebleTotal.getUsuarioFavorito.favorito=!widget.inmuebleTotal.getUsuarioFavorito.favorito;
                            //ScaffoldMessenger.of(context).showSnackBar(showSnackBar("¡Error! Por favor intente más tarde"));
                          }
                        }).whenComplete((){
                           useCaseInmuebleBase.registrarInmuebleBase(usuariosInfo.usuarioInmuebleBases, _prefs).whenComplete(() {
                             //ScaffoldMessenger.of(context).showSnackBar(showSnackBar("guardado en caché"));
                           });
                        });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("¡Error! No puede guardar el inmueble"));
                      }
                    },
                    //icon:Icon(Icons.favorite_border,color: Colors.white,size: 30,),
                    icon: !widget.inmuebleTotal.getUsuarioFavorito.isFavorito?Icon(Icons.favorite_border,color: Colors.white,size: 30,):Icon(Icons.favorite,color: Colors.red,size:30)
                  )
                )
              ],
            ),
          ],
        ),
      );
  }
}