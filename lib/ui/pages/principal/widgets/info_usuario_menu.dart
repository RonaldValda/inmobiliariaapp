import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/entities/usuarios_inmuebles_favoritos.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/autenticacion_usuario/page_autenticacion_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/perfil_usuario/page_perfil_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/principal/page_home.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_por_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
class InfoUsuarioMenu extends StatefulWidget {
  InfoUsuarioMenu({Key? key}) : super(key: key);

  @override
  _InfoUsuarioMenuState createState() => _InfoUsuarioMenuState();
}

class _InfoUsuarioMenuState extends State<InfoUsuarioMenu> {
  Future<SharedPreferences> _prefs=SharedPreferences.getInstance();
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  Widget build(BuildContext context) {
    final usuariosInfo=Provider.of<UsuariosInfo>(context);
    final _mapaFiltroPorUsuario=Provider.of<MapaFiltroPorUsuario>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    return InkWell(
      onTap: (){
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context){
            return PagePerfilUsuario(
            );
          }
        )
      );
      },
      child: Container(
        padding:EdgeInsets.only(bottom: 10,left: 10,right: 0,top: 10),
        child:Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    usuariosInfo.usuario.linkFoto==""?
                    CircleAvatar(
                      radius :44,
                      backgroundColor: usuariosInfo.getUsuario.getCorreo!=""?Colors.amber:Colors.indigo,
                      child: usuariosInfo.sesionIniciada?Text(usuariosInfo.getUsuario.nombres.toString().substring(0,1),style: TextStyle(fontSize: 40),):Text("S/R",style: TextStyle(fontSize: 40),),
                    )
                    :
                    CircleAvatar(
                      radius :44,
                      backgroundImage: CachedNetworkImageProvider(
                        usuariosInfo.usuario.linkFoto,
                        scale: 30
                      ),
                      //child: usuariosInfo.sesionIniciada?Text(usuariosInfo.getUsuario.nombres.toString().substring(0,1),style: TextStyle(fontSize: 40),):Text("S/R",style: TextStyle(fontSize: 40),),
                    ),
                    SizedBox(width: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        shadowColor: Colors.white,
                        primary: usuariosInfo.sesionIniciada?Colors.red:Colors.blue[800],
                        elevation: 0,
                        onPrimary: Colors.white
                      ),
                      onPressed: ()async{
                        if(usuariosInfo.sesionIniciada){
                          await useCaseUsuario.registrarUsuarioShared(Usuario.vacio(), _prefs);
                          email="";
                          _mapaFiltroPorUsuario.inicializarFiltros();
                          usuariosInfo.sesionIniciada=false;
                          _inmueblesFiltrado.setConsultarBD(true);
                          List<UsuarioInmuebleBase> usuarioInmuebleBases=[UsuarioInmuebleBase.vacio(),UsuarioInmuebleBase.vacio(),UsuarioInmuebleBase.vacio()];
                          usuariosInfo.setUsuarioInmuebleBases(usuarioInmuebleBases);      
                          usuariosInfo.setUsuario(Usuario.vacio());    
                          usuariosInfo.setUsuarioInmueblesBuscados([]);         
                          usuariosInfo.setMembresiaPagos([]);
                          usuariosInfo.setMembresiaPagoActual(MembresiaPago.vacio());     
                        }else{
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){
                                return PageAutenticacionUsuario();
                              }
                            )
                          );
                        }
                      }, 
                      child: !usuariosInfo.sesionIniciada?
                      Text("Iniciar sesión",
                        style: GoogleFonts.aclonica(
                          textStyle:TextStyle(fontSize: 14)
                        ),
                      ):Text("Cerrar sesión",
                        style: GoogleFonts.aclonica(
                          textStyle:TextStyle(fontSize: 14)
                        ),
                      ),)
                  ],
                ),
                Row(
                  children:[
                    !usuariosInfo.getUsuario.isVerificado?
                    Text(usuariosInfo.getUsuario.nombres,
                    style:TextStyle(
                      fontWeight: FontWeight.w500
                    )
                    ):
                    Text("${usuariosInfo.getUsuario.nombres} - ${usuariosInfo.getUsuario.getNombreAgencia}"),
                  ]
                ),
                Row(
                  children: [
                    Text(usuariosInfo.getUsuario.getCorreo,
                    style:TextStyle(
                      fontStyle: FontStyle.italic
                    )
                    ),
                  ],
                ),
              ],
            ),
            RotatedBox(
              quarterTurns: -45,
              child: Container(
                height: 30,
                width: 90,
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                ),
                
                child: Center(
                  child: Text(usuariosInfo.getSuscrito(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: usuariosInfo.getSuscrito()=="Suscrito"?
                    Colors.green:Colors.redAccent,
                  ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}