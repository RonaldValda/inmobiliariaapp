import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/calculo_bancario.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_base.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/notificaciones_super_usuario/notificaciones_super_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/operaciones_generales/page_operaciones_generales.dart';
import 'package:inmobiliariaapp/ui/pages/listado_agentes/page_listado_agentes.dart';
import 'package:inmobiliariaapp/ui/pages/notificaciones/page_notificaciones_inmuebles.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/page_registro_inmueble.dart';
import 'package:inmobiliariaapp/ui/pages/estadisticas_buscados/page_estadisticas_buscados.dart';
import 'package:inmobiliariaapp/ui/pages/membresia_pagos/page_membresia_pagos.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_por_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

Widget listTileBuscarAgenteInmobiliario(BuildContext context,MapaFiltroPrincipalesInfo _mapaFiltroPrincipales){
    return ListTile(
      hoverColor: Theme.of(context).hoverColor,
      focusColor: Colors.blueAccent,
      selectedTileColor: Colors.indigo,
      mouseCursor: MouseCursor.defer,
      leading: Icon(Icons.person_search,size: 40,),
      title: Text("Agentes inmobiliarios",
        
      ),
      onTap: (){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageListadoAgentes(ciudad: _mapaFiltroPrincipales.getMapaFiltro["ciudad"]);
            }
          )
        );
      },
    );
  }
  Widget listTileFavoritos(BuildContext context,MapaFiltroPorUsuario _mapaFiltroPorUsuario,ListadoInmueblesFiltrado _inmueblesFiltrado){
    return ListTile(
      leading: _mapaFiltroPorUsuario.getMapaFiltro["favoritos"]?
        Icon(Icons.favorite,color: Colors.red,size:40)
        :Icon(Icons.favorite_border,size:40),
      title: Text(
          "Favoritos"
      ),
      onTap: (){
        _inmueblesFiltrado.setFiltrar(true);
        _mapaFiltroPorUsuario.setMapaFiltroItem("favoritos", !_mapaFiltroPorUsuario.getMapaFiltro["favoritos"]);
      },
    );
  }
  Widget listTileVenderInmueble(BuildContext context,InmuebleInfo inmuebleInfo){
    return ListTile(
      leading: iconc.FaIcon(iconc.FontAwesomeIcons.laptopHouse,size: 30,),
      title: Text("Vender inmueble"),
      onTap: (){
        inmuebleInfo.setInmueblesTotal(InmuebleTotal.vacio());
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageRegistroInmueble();
            }
          )
        );
      },
    );
  }
  Widget listTileMembresiaPago(BuildContext context){
    return ListTile(
      leading: iconc.FaIcon(iconc.FontAwesomeIcons.userCheck,size: 30,),
      title: Text("Membresía"),
      onTap: (){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageMembresiaPagos();
            }
          )
        );
      },
    ); 
  }
  Widget listTileEstadisticas(BuildContext context,MapaFiltroPrincipalesInfo _mapaFiltroPrincipales){
    return ListTile(
      leading: Icon(Icons.bar_chart,size:40),
      title: Text(
          "Estadísticas"
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageEstadisticasBuscados(
                ciudad: _mapaFiltroPrincipales.getMapaFiltro["ciudad"],
              );
            }
          )
        );
      },
    );
  }
  Widget listTileBancos(BuildContext context){
    return ListTile(
      leading: Icon(Icons.attach_money,size:40),
      title: Text(
          "Banco"
      ),
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              //return WidgetAux();
              return CalculosBancarios();
            }
          )
        );
      },
    );
  }
  Widget listTileAyuda(BuildContext context){
    return ListTile(
      leading: Icon(Icons.help,size:40),
      title: Text(
          "Ayuda"
      ),
      onTap: (){
      },
    );
  }
  Widget listTileAdministracionGerente(BuildContext context){
    return ListTile(
      leading: Icon(Icons.public,size: 40,),
      title: Text("Administración Gerente"),
      onTap: (){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageOperacionesGenerales();
            }
          )
        );
      },
    );
  }
  Widget listTileTipoSesion(BuildContext context,UsuariosInfo usuariosInfo,ListadoInmueblesFiltrado _inmueblesFiltrado,MapaFiltroPorUsuario _mapaFiltroPorUsuario){
    return ListTile(
      leading: iconc.FaIcon(iconc.FontAwesomeIcons.random,size: 30,),
      title: Text(
          usuariosInfo.tipoSesion
      ),
      trailing: Switch(
        value:usuariosInfo.usuario.tipoUsuario!="Gerente"?usuariosInfo.tipoSesion!="Comprar"?true:false:usuariosInfo.tipoSesion!="Observar"?true:false, 
        onChanged: (val){
          if(val){
            if(usuariosInfo.sesionIniciada){
              _inmueblesFiltrado.setConsultarBD(true);
              _mapaFiltroPorUsuario.getMapaFiltro["favoritos"]=false;
              usuariosInfo.setTipoSesion(usuariosInfo.getUsuario, val);
            }else{
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Necesita iniciar sesión para poder publicar inmuebles"));
            }
          }else{
            _inmueblesFiltrado.setConsultarBD(true);
            usuariosInfo.setTipoSesion(usuariosInfo.getUsuario, val);
          }
          
        }
      ),
      onTap: (){
        
      },
    );
  }
  class ListTileNotificacionesInmueblesNuevos extends StatefulWidget {
  ListTileNotificacionesInmueblesNuevos({Key? key,required this.base}) : super(key: key);
  final UsuarioInmuebleBase base;
  @override
  _ListTileNotificacionesInmueblesNuevosState createState() => _ListTileNotificacionesInmueblesNuevosState();
}

class _ListTileNotificacionesInmueblesNuevosState extends State<ListTileNotificacionesInmueblesNuevos> {
  String numeroNotificacion="";
  UseCaseInmuebleBase useCaseInmuebleBase=UseCaseInmuebleBase();
  @override
  void initState() { 
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final usuarioInfo=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    if(_inmueblesFiltrado.inmueblesNuevos.length>9){
      numeroNotificacion="9+";
    }else if(_inmueblesFiltrado.inmueblesNuevos.length>0){
      numeroNotificacion=_inmueblesFiltrado.inmueblesNuevos.length.toString();
    }
    return ListTile(
      leading: Icon(Icons.notifications,size: 40,),
      title: Text("Notificaciones"),
      trailing: numeroNotificacion!=""?Container(
        width: 30,
        height: 30,
        alignment: Alignment.topRight,
        margin: EdgeInsets.only(top: 5),
        decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xffc32c37),
              border: Border.all(color: Colors.white, width: 1)),
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Center(
            child: Text(
              numeroNotificacion,
              style: TextStyle(fontSize: 15,color: Colors.white),
            ),
          ),
        ),
        
      ):Container(
        width: 30,
        height: 30,
      ),
      onTap: ()async{
        setState(() {
          numeroNotificacion="";
        });
        usuarioInfo.getUsuarioInmuebleBases[1].fechaInicio=usuarioInfo.getUsuario.getFechaUltimoIngreso;
        useCaseInmuebleBase.actualizarFechaInmuebleBase(usuarioInfo.getUsuarioInmuebleBases[1].id, usuarioInfo.getUsuario.getFechaUltimoIngreso)
        .then((completado) {

        });
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return PageNotificacionesInmueblesNuevos();
              }
            )
          );
      },
    );
  }
  
}
class NotificacionesSuperUsuario extends StatefulWidget {
  NotificacionesSuperUsuario({Key? key,required this.usuario}) : super(key: key);
  final UsuariosInfo usuario;
  @override
  _NotificacionesSuperUsuarioState createState() => _NotificacionesSuperUsuarioState();
}

class _NotificacionesSuperUsuarioState extends State<NotificacionesSuperUsuario> {

  List<InmuebleReportado> inmueblesReportados=[];
  List<InmuebleQueja> inmueblesQuejas=[];
  List<MembresiaPago> membresiasPagos=[];
  String numeroNotificaciones="";
  UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  @override
  void initState() {
    super.initState();
    try{
      /*exec_super_usuario.obtenerNotificacionesExisteSuperUsuario(widget.usuario).then((value) {
        if(value["completed"]){
          existeNotificacion=value["existe_notificacion"];
          setState(() {
            
          });
        }
      });*/
    /*exec_super_usuario.obtenerNotificacionesSuperUsuario(widget.usuario)
    .then((value) {
      if(value["completed"]){
        inmueblesReportados=value["inmuebles_reportados"];
        inmueblesQuejas=value["inmuebles_quejas"];
        membresiasPagos=value["membresias_pagos"];
        int total=inmueblesReportados.length+inmueblesQuejas.length+membresiasPagos.length;
        if(total>99){
          numeroNotificaciones="99+";
        }else if(total==0){
          numeroNotificaciones="";
        }else{
          numeroNotificaciones=total.toString();
        }
        setState(() {
          
        });
      }
    });*/
    }catch(e){
      print(e);
    }
    /*try{
    exec_super_usuario.obtenerNotificacionesNumeroSuperUsuario(widget.usuario)
    .then((value) {
      if(value["completed"]){
        numeroNotificaciones=value["numero_notificaciones"].toString();
        print(numeroNotificaciones);
        setState(() {
          
        });
      }
    });
    }catch(e){
      print(e);
    }*/
  }
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    return ListTile(
      leading: Icon(Icons.notifications,size: 40,),
      title: Text("Notificaciones"),
      trailing: _usuario.existeNotificacion?Container(
          width: 20,
          height: 20,
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffc32c37),
                border: Border.all(color: Colors.white, width: 1)),
          
          
        ):Container(
          width: 30,
          height: 30,
        ),
      onTap: ()async{
        Navigator.of(context).pop();
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageNotificacionesSuperUsuario(
                usuario:_usuario.usuario,
                tipoSesion: _usuario.tipoSesion,
              );
            }
          ),
        );
      },
    );
  }
}
/*class ListTileSolicitudesUsuario extends StatefulWidget {
  ListTileSolicitudesUsuario({Key? key,required this.inmueblesTotal}) : super(key: key);
  final List<InmuebleTotal> inmueblesTotal;
  @override
  _ListTileSolicitudesUsuarioState createState() => _ListTileSolicitudesUsuarioState();
}

class _ListTileSolicitudesUsuarioState extends State<ListTileSolicitudesUsuario> {
  String numeroNotificacion="";
  @override
  void initState() { 
    super.initState();
    if(widget.inmueblesTotal.length>9){
      numeroNotificacion="9+";
    }else if(widget.inmueblesTotal.length>0){
      numeroNotificacion=widget.inmueblesTotal.length.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    final usuarioInfo=Provider.of<UsuariosInfo>(context);
    return ListTile(
        leading: Icon(Icons.notifications,size: 40,),
        title: Text("Solicitudes"),
        trailing: numeroNotificacion!=""?Container(
          width: 30,
          height: 30,
          alignment: Alignment.topRight,
          margin: EdgeInsets.only(top: 5),
          decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffc32c37),
                border: Border.all(color: Colors.white, width: 1)),
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Center(
              child: Text(
                numeroNotificacion,
                style: TextStyle(fontSize: 15,color: Colors.white),
              ),
            ),
          ),
          
        ):Container(
          width: 30,
          height: 30,
        ),
        onTap: ()async{
          setState(() {
            numeroNotificacion="";
          });
          usuarioInfo.getUsuarioInmuebleBases[1].fechaInicio=usuarioInfo.getUsuario.getFechaUltimoIngreso;
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return PageSolicitudes(inmueblesTotal: widget.inmueblesTotal);
                }
              )
            );
        },
      );
  }
}*/