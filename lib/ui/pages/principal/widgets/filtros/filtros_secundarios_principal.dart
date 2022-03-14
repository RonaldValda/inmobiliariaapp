import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/dialog_registro_inmueble_buscado.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_secundarios_comunidad.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_secundarios_generales.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_secundarios_internas.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/filtros/filtros_secundarios_otros.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_comunidad_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_generales_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_internas_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_por_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
class FiltrosSecundariosPrincipal extends StatefulWidget {
  FiltrosSecundariosPrincipal({Key? key}) : super(key: key);

  @override
  _FiltrosSecundariosPrincipalState createState() => _FiltrosSecundariosPrincipalState();
}

class _FiltrosSecundariosPrincipalState extends State<FiltrosSecundariosPrincipal> {
  bool activadoGenerales=true;
  bool activadoInternas=true;
  bool activadoComunidad=true;
  bool activadoOtros=true;
  double altura=300;
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroGenerales=Provider.of<MapaFiltroGeneralesInfo>(context);
    final _mapaFiltroInternas=Provider.of<MapaFiltroInternasInfo>(context);
    final _mapaFiltroComunidad=Provider.of<MapaFiltroComunidadInfo>(context);
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _mapaFiltroPorUsuario=Provider.of<MapaFiltroPorUsuario>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context); 
    final _usuario=Provider.of<UsuariosInfo>(context);
    return Container(
      padding: EdgeInsets.all(0),
      width: 600,
      height: MediaQuery.of(context).size.height*0.7,
      //color: Colors.yellow.withOpacity(0.8),
       child: Column(
         children: [
           Expanded(
             child: ListView(
               scrollDirection: Axis.vertical,
               children: [
                 /*Material(
                   borderOnForeground: true,
                   shadowColor: Colors.red,
                   elevation: 10,
                   color: Colors.amberAccent,
                   child: Text("data"),
                 ),*/
                 ElevatedButton(
                   child: Row(
                     children:[
                      Text("Generales",style: TextStyle(color:Colors.indigo),),
                     ],
                   ),
                   onPressed: (){
                     setState(() {
                       activadoGenerales=!activadoGenerales;
                       altura=activadoGenerales?500:300;
                     });
                   },
                   style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      shadowColor: Colors.indigo,
                      textStyle: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.red,
                        fontStyle: FontStyle.normal
                      ),
                      elevation: 0,
                      shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                    ),
                 ),
                 activadoGenerales?FiltrosSecundariosGenerales(mapFiltro: _mapaFiltroGenerales.getMapaFiltro,):Container(),
                 ElevatedButton(
                   child: Row(
                     children:[
                      Text("Características internas",style: TextStyle(color:Colors.blueGrey),),
                     ],
                   ),
                   onPressed: (){
                     setState(() {
                       activadoInternas=!activadoInternas;
                       altura=activadoInternas?500:300;
                     });
                   },
                   style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      shadowColor: Colors.indigo,
                      textStyle: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.red,
                        fontStyle: FontStyle.normal
                      ),
                      elevation: 0,
                      shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                    ),
                 ),
                 activadoInternas?FiltrosSecundariosInternas():Container(),
                 ElevatedButton(
                   child: Row(
                     children:[
                      Text("Comunidad",style: TextStyle(color:Colors.blueGrey),),
                     ],
                   ),
                   onPressed: (){
                     setState(() {
                       activadoComunidad=!activadoComunidad;
                     });
                   },
                   style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      shadowColor: Colors.indigo,
                      textStyle: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.red,
                        fontStyle: FontStyle.normal
                      ),
                      elevation: 0,
                      shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                    ),
                 ),
                 activadoComunidad?FiltrosSecundariosComunidad():Container(),
                 ElevatedButton(
                   child: Row(
                     children:[
                      Text("Otros",style: TextStyle(color:Colors.blueGrey),),
                     ],
                   ),
                   onPressed: (){
                     setState(() {
                       activadoOtros=!activadoOtros;
                     });
                   },
                   style: ElevatedButton.styleFrom(
                      primary:Colors.white,
                      shadowColor: Colors.indigo,
                      textStyle: TextStyle(
                        color: Colors.white,
                        decorationColor: Colors.red,
                        fontStyle: FontStyle.normal
                      ),
                      elevation: 0,
                      shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                    ),
                 ),
                 activadoOtros?FiltrosSecundariosOtros():Container(),
               ],
             ),
           ),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
              if(_usuario.getSuscrito()=="Suscrito") ElevatedButton(
                 child: Row(
                   children:[
                    Text("Guardar",style: TextStyle(color:Colors.white),),
                   ],
                 ),
                 onPressed: ()async{
                   await dialogRegistroInmuebleBuscado(context);
                   _inmueblesFiltrado.filtroBuscadoSeleccionado=-1;
                 },
                 style: ElevatedButton.styleFrom(
                    primary:Colors.green,
                    shadowColor: Colors.lightGreen,
                    textStyle: TextStyle(
                      color: Colors.green,
                      decorationColor: Colors.greenAccent,
                      fontStyle: FontStyle.normal
                    ),
                    elevation: 0,
                    shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                  ),
               ),
               SizedBox(width: 5,),
               ElevatedButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Text("Limpiar",style: TextStyle(color:Colors.white),),
                  ],
                ),
                onPressed: (){
                  _inmueblesFiltrado.setFiltrar(true);
                  _mapaFiltroGenerales.inicializarFiltros();
                  _mapaFiltroInternas.inicializarFiltros();
                  _mapaFiltroComunidad.inicializarFiltros();
                  _mapaFiltroOtros.inicializarFiltros(); 
                  _mapaFiltroPorUsuario.inicializarFiltros();
                  _inmueblesFiltrado.filtroBuscadoSeleccionado=-1;
                  
                },
                style: ElevatedButton.styleFrom(
                    primary:Colors.red,
                    shadowColor: Colors.indigo,
                    textStyle: TextStyle(
                      color: Colors.red,
                      decorationColor: Colors.red,
                      fontStyle: FontStyle.normal
                    ),
                    elevation: 0,
                    shape: StadiumBorder(side: BorderSide(color: Colors.orange))
                  ),
              ),
             ],
           ),
            
         ],
       )
    );
  }
}
