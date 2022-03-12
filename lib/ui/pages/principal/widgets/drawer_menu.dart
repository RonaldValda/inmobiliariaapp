
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/version_app.dart';
import 'package:inmobiliariaapp/ui/pages/notificaciones_membresia/notificaciones_agentes.dart';
import 'package:inmobiliariaapp/ui/pages/notificaciones_super_usuario/notificaciones_super_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_por_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_principales_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/info_usuario_menu.dart';
import 'package:provider/provider.dart';

import 'drawer_list_tile.dart';
VersionAPP versionAPPActual=VersionAPP(
    id: "", numeroVersion: "1.0.0.1", 
    fechaPublicacion: "", linkDescarga: ""
);
class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  
  
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroPorUsuario=Provider.of<MapaFiltroPorUsuario>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    final usuariosInfo=Provider.of<UsuariosInfo>(context);
    final _mapaFiltroPrincipales=Provider.of<MapaFiltroPrincipalesInfo>(context);
    return Drawer(
       elevation: 0,
       semanticLabel: "Configuraciones",
       child: SafeArea(
         child: Column(
           children: [
             InfoUsuarioMenu(),
             Expanded(
               child: ListView(
                 children:<Widget>[
                      Container(
                        child: Column(
                            children: [
                              if(usuariosInfo.getUsuario.getId!=""&&
                                usuariosInfo.tipoSesion=="Vender")
                                listTileBuscarAgenteInmobiliario(context,_mapaFiltroPrincipales),
                              if(usuariosInfo.getUsuario.getId!=""&&
                                usuariosInfo.tipoSesion=="Comprar")
                                listTileFavoritos(context, _mapaFiltroPorUsuario, _inmueblesFiltrado),
                              if(usuariosInfo.tipoSesion=="Vender")
                                listTileVenderInmueble(context,inmuebleInfo),
                              
                              if(usuariosInfo.getUsuario.id!=""&&
                                usuariosInfo.tipoSesion=="Supervisar"&&
                                usuariosInfo.usuario.tipoUsuario=="Gerente")
                                listTileEstadisticas(context, _mapaFiltroPrincipales),
                              if(usuariosInfo.getUsuario.getId!=""&&usuariosInfo.tipoSesion=="Supervisar")
                                NotificacionesSuperUsuario(usuario: usuariosInfo),
                              if(usuariosInfo.getUsuario.getId!=""&&usuariosInfo.tipoSesion=="Comprar")
                                ListTileNotificacionesInmueblesNuevos(base: usuariosInfo.usuarioInmuebleBases[1],),
                              if(usuariosInfo.getUsuario.getCorreo!=""&&usuariosInfo.tipoSesion=="Administrar")
                                NotificacionesMembresiaAdministrador(administrador: usuariosInfo.usuario),
                              if(usuariosInfo.getUsuario.getId!=""&&
                              usuariosInfo.tipoSesion=="Comprar")
                                listTileBancos(context),
                              listTileAyuda(context),
                              Divider(),
                             // usuariosInfo.getUsuario.getId!=""?SolicitudesUsuario():Container(),
                              if(usuariosInfo.getUsuario.getId!=""
                                &&usuariosInfo.getUsuario.tipoUsuario=="Gerente"
                                &&usuariosInfo.tipoSesion=="Supervisar")
                                listTileAdministracionGerente(context),
                            ],
                        ),
                    )
                 ],
               ),
             ),
             if(usuariosInfo.getUsuario.getId!="")
             listTileTipoSesion(context, usuariosInfo, _inmueblesFiltrado, _mapaFiltroPorUsuario)
           ],
         ),
       ),
     );
  }
  
}


/*class ListTileMisInmuebleBuscados extends StatefulWidget {
  ListTileMisInmuebleBuscados({Key? key}) : super(key: key);

  @override
  _ListTileMisInmuebleBuscadosState createState() => _ListTileMisInmuebleBuscadosState();
}

class _ListTileMisInmuebleBuscadosState extends State<ListTileMisInmuebleBuscados> {
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    _inmueblesFiltrado.inmueblesBuscados=[];
    for(int i=0;i<_usuario.usuarioInmueblesBuscados.length;i++){
      _inmueblesFiltrado.inmueblesBuscados.addAll(filtrado_inmuebles.filtrarInmuebles(inmueblesTotalGeneral, _usuario.usuarioInmueblesBuscados[i].toMap()));
    }
    return ListTile(
      leading: Icon(Icons.search,size: 40,),
      title: Text("Buscados"),
      trailing: _inmueblesFiltrado.inmueblesBuscados.length>0?Container(
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
                _inmueblesFiltrado.inmueblesBuscados.length.toString(),
                style: TextStyle(fontSize: 15,color: Colors.white),
              ),
            ),
          ),
          
        ):Container(
          width: 30,
          height: 30,
        ),
        onTap:()async{
          _inmueblesFiltrado.filtroBuscadoSeleccionado=-1;
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context){
                return PageMisInmueblesBuscados();
              }
            )
          );
          _inmueblesFiltrado.filtroBuscadoSeleccionado=-1;
        }
    );
  }
}
*/