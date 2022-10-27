
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/version_app.dart';
import 'package:inmobiliariaapp/ui/pages/user/login/screen_login.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
import 'drawer_list_tile.dart';
import 'dawer_user_info.dart';
AppVersion versionAPPActual=AppVersion(
    id: "", versionNumber: "1.0.0.1", 
    publicationDate: "", downloadLink: ""
);
class DrawerMenu extends StatefulWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  _DrawerMenuState createState() => _DrawerMenuState();
}

class _DrawerMenuState extends State<DrawerMenu> {
  
  
  @override
  Widget build(BuildContext context) {
    final userProvider=context.watch<UserProvider>();
    return Drawer(
       elevation: 0,
       semanticLabel: "Configuraciones",
       child: SafeArea(
         child: Column(
           children: [
             DrawerUserInfo(),
             Expanded(
               child: ListView(
                 children:<Widget>[
                    if(userProvider.user.id!=""&&
                    userProvider.sessionType=="Comprar")
                    wBuy(context: context),
                    if(userProvider.user.id!=""&&
                    userProvider.sessionType=="Vender")
                    wSeller(context: context),
                    if(userProvider.user.id!=""&&
                    userProvider.sessionType=="Supervisar"&&
                    userProvider.user.userType=="Super user")
                    wSuperUserSupervise(context: context),
                    if(userProvider.user.id!=""&&
                    userProvider.sessionType=="Supervisar"&&
                    userProvider.user.userType=="Gerente")
                    wManagerSupervise(context: context),
                    if(userProvider.user.email!=""&&userProvider.sessionType=="Administrar")
                    wAdminister(context: context),
                    ListTile(
                      title: Text(
                        !userProvider.sessionStarted?"Iniciar sesión":"Cerrar sesión",
                      ),
                      onTap: ()async{
                        if(userProvider.sessionStarted){
                          userProvider.logoutUser(context: context);
                        }else{
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){
                                return ScreenLogin();
                              }
                            )
                          );
                        }
                      },
                    )
                 ],
               ),
             ),
             if(userProvider.user.id!="")
             wListTileSessionType(context: context)
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