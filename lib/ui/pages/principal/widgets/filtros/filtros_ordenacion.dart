
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';

class FiltrosOrdenacion extends StatefulWidget {
  FiltrosOrdenacion({Key? key}) : super(key: key);

  @override
  _FiltrosOrdenacionState createState() => _FiltrosOrdenacionState();
}

class _FiltrosOrdenacionState extends State<FiltrosOrdenacion> {
  final heightContainerTexto=30.0;
  final widthContainerTexto=100.0;
  @override
  Widget build(BuildContext context) {
    final mapaFiltroOrden=Provider.of<MapaFiltroOtrosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final usuarioInfo=Provider.of<UsuariosInfo>(context);
    return Container(
      //width: 160,
       child: Column(
         children: [
           Align(
             alignment: Alignment.centerLeft,
             child: Text("Ordenar por:",
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700
              ),
             )
            ),
           Container(
              height: heightContainerTexto,
              child:Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto,
                    width: widthContainerTexto,
                    child: Text("Precio",style: TextStyle(fontSize: 13),),
                  ),
                  Container(
                    child: Radio<int>(
                      groupValue: mapaFiltroOrden.getMapaFiltroOrden["parametro"],
                      value: getParametroOrden.precio.index,
                      onChanged: (value){
                        _inmueblesFiltrado.setFiltrar(true);
                        mapaFiltroOrden.setMapaFiltroOrden("parametro", value);
                      }
                    ),
                  ),
                ],
              ),
            ),
            
            Container(
              height: heightContainerTexto,
              child:Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto,
                    width: widthContainerTexto,
                    child: Text("Superficie terreno",style: TextStyle(fontSize: 13),),
                  ),
                  Container(
                    child: Radio<int>(
                      groupValue: mapaFiltroOrden.getMapaFiltroOrden["parametro"],
                      value: getParametroOrden.superficieTerreno.index,
                      onChanged: (value){
                        _inmueblesFiltrado.setFiltrar(true);
                        mapaFiltroOrden.setMapaFiltroOrden("parametro", value);
                      }
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: heightContainerTexto,
              child:Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto,
                    width: widthContainerTexto,
                    child: Text("Superficie construcción",style: TextStyle(fontSize: 13),),
                  ),
                  Container(
                    child: Radio<int>(
                      groupValue: mapaFiltroOrden.getMapaFiltroOrden["parametro"],
                      value: getParametroOrden.superficieConstruccion.index,
                      onChanged: (value){
                        _inmueblesFiltrado.setFiltrar(true);
                        mapaFiltroOrden.setMapaFiltroOrden("parametro", value);
                      }
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: heightContainerTexto,
              child:Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto,
                    width: widthContainerTexto,
                    child: Text("Tiempo construcción",style: TextStyle(fontSize: 13),),
                  ),
                  Container(
                    child: Radio<int>(
                      groupValue: mapaFiltroOrden.getMapaFiltroOrden["parametro"],
                      value: getParametroOrden.tiempoConstruccion.index,
                      onChanged: (value){
                        _inmueblesFiltrado.setFiltrar(true);
                        mapaFiltroOrden.setMapaFiltroOrden("parametro", value);
                      }
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: heightContainerTexto,
              child:Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto,
                    width: widthContainerTexto,
                    child: Text("Dormitorios",style: TextStyle(fontSize: 13),),
                  ),
                  Container(
                    child: Radio<int>(
                      groupValue: mapaFiltroOrden.getMapaFiltroOrden["parametro"],
                      value: getParametroOrden.dormitorios.index,
                      onChanged: (value){
                        _inmueblesFiltrado.setFiltrar(true);
                        mapaFiltroOrden.setMapaFiltroOrden("parametro", value);
                      }
                    ),
                  ),
                ],
              ),
            ),
            if(usuarioInfo.usuario.tipoUsuario=="Gerente")
            Column(
              children: [
                Container(
                  height: heightContainerTexto,
                  child:Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: heightContainerTexto,
                        width: widthContainerTexto,
                        child: Text("Vistos",style: TextStyle(fontSize: 13),),
                      ),
                      Container(
                        child: Radio<int>(
                          groupValue: mapaFiltroOrden.getMapaFiltroOrden["parametro"],
                          value: getParametroOrden.vistos.index,
                          onChanged: (value){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroOrden.setMapaFiltroOrden("parametro", value);
                          }
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightContainerTexto,
                  child:Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: heightContainerTexto,
                        width: widthContainerTexto,
                        child: Text("Revisados",style: TextStyle(fontSize: 13),),
                      ),
                      Container(
                        child: Radio<int>(
                          groupValue: mapaFiltroOrden.getMapaFiltroOrden["parametro"],
                          value: getParametroOrden.doble_vistos.index,
                          onChanged: (value){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroOrden.setMapaFiltroOrden("parametro", value);
                          }
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: heightContainerTexto,
                  child:Row(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        height: heightContainerTexto,
                        width: widthContainerTexto,
                        child: Text("Favoritos",style: TextStyle(fontSize: 13),),
                      ),
                      Container(
                        child: Radio<int>(
                          groupValue: mapaFiltroOrden.getMapaFiltroOrden["parametro"],
                          value: getParametroOrden.favoritos.index,
                          onChanged: (value){
                            _inmueblesFiltrado.setFiltrar(true);
                            mapaFiltroOrden.setMapaFiltroOrden("parametro", value);
                          }
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
           Row(
            children: [
              Text("Orden",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w700
              ),
            ),
              Expanded(
                child: Container(
                  height: 1,
                  color:Colors.black54
                ),
              ),
            ],
          ),
          
          Container(
              height: heightContainerTexto,
              child:Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto,
                    width: widthContainerTexto,
                    child: Text("Ascendente",style: TextStyle(fontSize: 13),),
                  ),
                  Container(
                    child: Radio<int>(
                      groupValue: mapaFiltroOrden.getMapaFiltroOrden["orden"],
                      value: getOrden.ascendente.index,
                      onChanged: (value){
                        _inmueblesFiltrado.setFiltrar(true);
                        mapaFiltroOrden.setMapaFiltroOrden("orden", value);
                      }
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: heightContainerTexto,
              child:Row(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    height: heightContainerTexto,
                    width: widthContainerTexto,
                    child: Text("Descendente",style: TextStyle(fontSize: 13),),
                  ),
                  Container(
                    child: Radio<int>(
                      groupValue: mapaFiltroOrden.getMapaFiltroOrden["orden"],
                      value: getOrden.descendente.index,
                      onChanged: (value){
                        _inmueblesFiltrado.setFiltrar(true);
                        mapaFiltroOrden.setMapaFiltroOrden("orden", value);
                      }
                    ),
                  ),
                ],
              ),
            ),
         ],
       )
    );
  }
}