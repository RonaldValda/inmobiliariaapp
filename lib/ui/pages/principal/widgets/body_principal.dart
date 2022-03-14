
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/container_listado_inmuebles.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_por_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';

class BodyPrincipal extends StatefulWidget {
  const BodyPrincipal({Key? key}):super(key: key);

  @override
  _BodyPrincipalState createState() => _BodyPrincipalState();
}

class _BodyPrincipalState extends State<BodyPrincipal> with SingleTickerProviderStateMixin{
  
  bool cargar=true;
  bool favoritos=false;
  AnimationController? _controller;
  Animation? _animation;
  bool toggle=false;
  double pi=3.141516;
  Color? colorBotonActivado=Colors.orange[900];
  Color? colorBotonDesactivado=Colors.deepOrangeAccent;
  @override
  void initState(){
    super.initState();
    _controller=AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
      reverseDuration: Duration(milliseconds: 275)
    );
    _animation=CurvedAnimation(
      parent: _controller!, 
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn
    );
    _controller!.addListener(() { 
      setState(() {
        
      });
    });
    //colorBotonActivado=Colors.orange.shade900;
  }
  Alignment alignmentMapaVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y-0.07);
  Alignment alignmentMapaNoVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y+0.3);
  Alignment alignmentFavoritoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y-0.07);
  Alignment alignmentFavoritoNoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y+0.3);
  double size1=50.0;
  double size2=50.0;
  double size3=60.0;

  @override
  Widget build(BuildContext context) {
    final _mapaFiltroPorUsuario=Provider.of<MapaFiltroPorUsuario>(context);
    final usuario=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    int iVistos=-1;
    int iDobleVistos=-1;
    if(MediaQuery.of(context).size.height<MediaQuery.of(context).size.width){
      alignmentMapaVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y-0.07);
      alignmentMapaNoVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y+0.55);
      alignmentFavoritoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y-0.07);
      alignmentFavoritoNoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y+0.55);
    }else{
      alignmentMapaVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y-0.07);
      alignmentMapaNoVisible=Alignment(Alignment.bottomLeft.x+0.1, Alignment.bottomLeft.y+0.3);
      alignmentFavoritoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y-0.07);
      alignmentFavoritoNoVisible=Alignment(Alignment.bottomRight.x-0.1, Alignment.bottomRight.y+0.3);
    }
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      
      //color: Colors.blue,
       child: Column(
         children:<Widget>[
            Expanded(
              child: Stack(
              children: [
                PaginaListadoInmuebles(),
                AnimatedAlign(
                  duration: _estadoWidgets.botonesAnteriorVisible?Duration(milliseconds: 700):Duration(milliseconds:700),
                  alignment: _estadoWidgets.botonesAnteriorVisible?alignmentMapaVisible:alignmentMapaNoVisible,
                  curve: _estadoWidgets.botonesAnteriorVisible?Curves.easeIn:Curves.easeOut,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: _estadoWidgets.botonesAnteriorVisible?Curves.easeIn:Curves.elasticOut,
                    height: size3,
                    width: size3,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: IconButton(
                      icon: 
                      _estadoWidgets.isVerMapa?
                      Icon(Icons.list,size: 35,):Icon(Icons.public,size: 35,),
                      color: Colors.white,
                      onPressed: (){
                        _inmueblesFiltrado.setFiltrar(false);
                         _inmueblesFiltrado.setConsultarBD(false);
                        _estadoWidgets.setVerMapa(!_estadoWidgets.isVerMapa);
                      },
                    ),
                  ),
                ),
                usuario.getUsuario.id!=""? usuario.tipoSesion=="Comprar"?
                AnimatedAlign(
                  duration: _estadoWidgets.botonesAnteriorVisible?Duration(milliseconds: 700):Duration(milliseconds:700),
                  alignment: _estadoWidgets.botonesAnteriorVisible?alignmentFavoritoVisible:alignmentFavoritoNoVisible,
                  curve: _estadoWidgets.botonesAnteriorVisible?Curves.easeIn:Curves.easeOut,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 100),
                    curve: _estadoWidgets.botonesAnteriorVisible?Curves.easeIn:Curves.elasticOut,
                    height: size3,
                    width: size3,
                    decoration: BoxDecoration(
                      color: _mapaFiltroPorUsuario.getMapaFiltro["favoritos"]?
                            colorBotonActivado:colorBotonDesactivado,
                      borderRadius: BorderRadius.circular(40)
                    ),
                    child: IconButton(
                      icon: _mapaFiltroPorUsuario.getMapaFiltro["favoritos"]?
                      Icon(
                        Icons.favorite,
                        color:Colors.white
                        ,size: 35,
                      ):
                      Icon(
                        Icons.favorite_border,
                        color:Colors.white
                        ,size: 35,
                      ),
                      color: Colors.white,
                      onPressed: (){
                         _inmueblesFiltrado.setFiltrar(true);
                         _inmueblesFiltrado.setConsultarBD(false);
                        _mapaFiltroPorUsuario.setMapaFiltroItem("favoritos", !_mapaFiltroPorUsuario.getMapaFiltro["favoritos"]);
                      },
                    ),
                  ),
                ):Container():Container(),
                if(_estadoWidgets.isVerMapa&&usuario.usuario.tipoUsuario=="Gerente")
                Align(
                  alignment: Alignment.bottomRight,
                  child: Card(
                    elevation: 10,
                    child: Container(
                      width: 170,
                      height: 130,
                      color: Colors.white,
                      child:Column(
                        children: [
                          Text("Indicadores"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Card(
                                elevation: 10,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text("Vistos"),
                                      Column(
                                        children: _inmueblesFiltrado.limitesVistos.map((e){
                                          iVistos++;
                                          if(iVistos==0){
                                            return Row(
                                              children: [
                                                Icon(Icons.circle,size:10,color:_inmueblesFiltrado.colores[iVistos]),
                                                SizedBox(width: 2,),
                                                Text("De 0 a ${_inmueblesFiltrado.limitesVistos[iVistos]}")    
                                              ],
                                            );
                                          }
                                          return Row(
                                            children: [
                                              Icon(Icons.circle,size:10,color:_inmueblesFiltrado.colores[iVistos]),
                                              SizedBox(width: 2,),
                                              Text("De ${_inmueblesFiltrado.limitesVistos[iVistos-1]+1} a ${_inmueblesFiltrado.limitesVistos[iVistos]}")    
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Card(
                                elevation: 10,
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      Text("Revisados"),
                                      Column(
                                        children: _inmueblesFiltrado.limitesDobleVistos.map((e){
                                          iDobleVistos++;
                                          if(iDobleVistos==0){
                                            return Row(
                                              children: [
                                                Icon(Icons.circle,size:10,color:_inmueblesFiltrado.colores[iDobleVistos]),
                                                SizedBox(width: 2,),
                                                Text("De 0 a ${_inmueblesFiltrado.limitesDobleVistos[iDobleVistos]}")    
                                              ],
                                            );
                                          }
                                          return Row(
                                            children: [
                                              Icon(Icons.circle,size:10,color:_inmueblesFiltrado.colores[iDobleVistos]),
                                              SizedBox(width: 2,),
                                              Text("De ${_inmueblesFiltrado.limitesDobleVistos[iDobleVistos-1]+1} a ${_inmueblesFiltrado.limitesDobleVistos[iDobleVistos]}")    
                                            ],
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    ),
                  ),
                ),
              ],
            ),
            ),
         ]
       )
    );
  }
}
