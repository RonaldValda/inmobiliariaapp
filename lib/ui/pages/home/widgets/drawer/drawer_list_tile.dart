import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/banking_calculation.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user_property_favorite.dart';
import 'package:inmobiliariaapp/domain/usecases/property/usecase_property_base.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_super_user.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/pages/notificaciones_super_usuario/notificaciones_super_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/listado_agentes/page_listado_agentes.dart';
import 'package:inmobiliariaapp/ui/pages/notificaciones/page_notificaciones_inmuebles.dart';
import 'package:inmobiliariaapp/ui/pages/estadisticas_buscados/page_estadisticas_buscados.dart';
import 'package:inmobiliariaapp/ui/pages/membresia_pagos/page_membresia_pagos.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_user_provider.dart';
import 'package:inmobiliariaapp/ui/provider/home/filter_main_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../../../../common/size_default.dart';
import '../../../../common/texts.dart';
import '../../../administration_management/screen_administration_management.dart';

Widget listTileBuscarAgenteInmobiliario(BuildContext context,FilterMainProvider filterMainProvider){
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
              return PageListadoAgentes(ciudad: filterMainProvider.mapFilter["city"]);
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
  class ListTileNotificacionesInmueblesNuevos extends StatefulWidget {
  ListTileNotificacionesInmueblesNuevos({Key? key,required this.base}) : super(key: key);
  final UserPropertyBase base;
  @override
  _ListTileNotificacionesInmueblesNuevosState createState() => _ListTileNotificacionesInmueblesNuevosState();
}

class _ListTileNotificacionesInmueblesNuevosState extends State<ListTileNotificacionesInmueblesNuevos> {
  String numeroNotificacion="";
  UseCasePropertyBase useCaseInmuebleBase=UseCasePropertyBase();
  @override
  void initState() { 
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    final usuarioInfo=Provider.of<UserProvider>(context);
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
        usuarioInfo.userPropertyBases[1].startDate=usuarioInfo.user.lastEntryDate;
        useCaseInmuebleBase.updateDatePropertyBase(usuarioInfo.userPropertyBases[1].id, usuarioInfo.user.lastEntryDate)
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
  final UserProvider usuario;
  @override
  _NotificacionesSuperUsuarioState createState() => _NotificacionesSuperUsuarioState();
}

class _NotificacionesSuperUsuarioState extends State<NotificacionesSuperUsuario> {

  List<PropertyReported> inmueblesReportados=[];
  List<PropertyComplaint> inmueblesQuejas=[];
  List<MembershipPayment> membresiasPagos=[];
  String numeroNotificaciones="";
  UseCaseSuperUser useCaseSuperUsuario=UseCaseSuperUser();
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
    final _usuario=Provider.of<UserProvider>(context);
    return ListTile(
      leading: Icon(Icons.notifications,size: 40,),
      title: Text("Notificaciones"),
      trailing: _usuario.existsNotification?Container(
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
                usuario:_usuario.user,
                tipoSesion: _usuario.sessionType,
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

Widget wBuy({required BuildContext context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _wListTileFavorite(context:context),
        _wListTileBank(context:context),
        _wListTileHelp(context: context),
      ],
    );
  }

  Widget wSeller({required BuildContext context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _wListTileAgents(context:context),
        _wListTileSellerProperty(context:context),
        _wListTileHelp(context: context),
      ],
    );
  }


  Widget wManagerSupervise({required BuildContext context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _wListTileStatistics(context: context),
        _wListTileNotificationsSupervise(context: context),
        _wListTileHelp(context: context),
        _wListTileAdministrationManagement(context: context)
      ],
    );
  }

  Widget wSuperUserSupervise({required BuildContext context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _wListTileNotificationsSupervise(context: context),
        _wListTileHelp(context: context),
      ],
    );
  }

  Widget wObserve({required BuildContext context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _wListTileHelp(context: context),
      ],
    );
  }

  Widget wAdminister({required BuildContext context}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _wListTileNotificationsAdministrator(context: context),
        _wListTileHelp(context: context),
      ],
    );
  }

  Widget _wListTileAgents({required BuildContext context}){
    return _wListTile(
      context: context, 
      text: "Agentes inmobiliarios", 
      icon: Icon(
        Icons.person_search,
        color: ColorsDefault.colorIcon,
        size: SizeDefault.sizeIconDrawer,
      ), 
      onTap: (){
        Navigator.of(context).pop();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageListadoAgentes(ciudad: context.read<FilterMainProvider>().mapFilter["city"],);
            }
          )
        );
      }
    );
  }

  Widget _wListTileSellerProperty({required BuildContext context}){
    return _wListTile(
      context: context, 
      text: "Vender inmueble", 
      icon: iconc.FaIcon(
        iconc.FontAwesomeIcons.laptopHouse,
        color: ColorsDefault.colorIcon,
        size: 40*SizeDefault.scaleWidth,
      ), 
      onTap: (){
        context.read<RegistrationPropertyProvider>().setPropertyTotalCopy(PropertyTotal.empty());
        Navigator.pushNamed(context, '/screen_registration_property_choise_plan');
      }
    );
  }

  Widget _wListTileFavorite({required BuildContext context}){
    final filterUserProvider=context.watch<FilterUserProvider>();
    return _wListTile(
      context: context, 
      text: "Favoritos", 
      icon: filterUserProvider.mapFilter["favorites"]?
        Icon(
          Icons.favorite,
          color: ColorsDefault.colorFavorite,
          size: SizeDefault.sizeIconDrawer,
        )
        :Icon(
          Icons.favorite_border,
          color: ColorsDefault.colorIcon,
          size: SizeDefault.sizeIconDrawer,
        ),
      onTap: (){
        filterUserProvider.setMapFilterItem("favorites", !filterUserProvider.mapFilter["favorites"],context: context);
      }
    );
  }

  Widget _wListTileBank({required BuildContext context}){
    return _wListTile(
      context: context, 
      text: "Bancos", 
      icon: Icon(
        Icons.attach_money,
        size: SizeDefault.sizeIconDrawer,
        color: ColorsDefault.colorIcon,
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
      }
    );
  }

  Widget _wListTileStatistics({required BuildContext context}) {
    return _wListTile(
      context: context, 
      text: "Estadísticas", 
      icon: Icon(
        Icons.bar_chart,
        size: SizeDefault.sizeIconDrawer,
        color: ColorsDefault.colorIcon,
      ), 
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageEstadisticasBuscados(
                ciudad: context.read<FilterMainProvider>().mapFilter["city"],
              );
            }
          )
        );
      }
    );
  }

  Widget _wListTileNotificationsSupervise({required BuildContext context}) {
    final userProvider=context.read<UserProvider>();
    return _wListTile(
      context: context, 
      text: "Notificaciones", 
      icon: Icon(
        Icons.notifications,
        size: SizeDefault.sizeIconDrawer,
        color: ColorsDefault.colorIcon,
      ), 
      onTap: (){
          Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageNotificacionesSuperUsuario(
                usuario:userProvider.user,
                tipoSesion: userProvider.sessionType,
              );
            }
          ),
        );
      }
    );
  }
  

  Widget _wListTileHelp({required BuildContext context}){
    return _wListTile(
      context: context, 
      text: "Ayuda", 
      icon: Icon(
        Icons.help,
        size: SizeDefault.sizeIconDrawer,
        color: ColorsDefault.colorIcon,
      ), 
      onTap: (){

      }
    );
  }

  Widget _wListTileAdministrationManagement({required BuildContext context}){
    return _wListTile(
      context: context, 
      text: "Administración gerencia", 
      icon: Icon(
        Icons.manage_accounts,
        size: SizeDefault.sizeIconDrawer,
        color: ColorsDefault.colorIcon,
      ), 
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return ScreenAdministrationManagement();
            }
          )
        );
      }
    );
  }

  Widget _wListTileNotificationsAdministrator({required BuildContext context}){
    return _wListTile(
      context: context, 
      text: "Notificaciones", 
      icon: Icon(
        Icons.notifications,
        size: SizeDefault.sizeIconDrawer,
        color: ColorsDefault.colorIcon,
      ), 
      onTap: (){
        /*Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return PageNotificacionesAdministrador(membresiasPagos: widget.membresiasPagos,inscripcionesAgentes: widget.inscripcionesAgentes,);
            }
          )
        );*/
      }
    );
  }

  Widget wListTileSessionType({required BuildContext context}){
    final userProvider=context.read<UserProvider>();
    return _wListTile(
      context: context, 
      text: userProvider.sessionType, 
      icon: iconc.FaIcon(
        iconc.FontAwesomeIcons.random,
        color: ColorsDefault.colorIcon,
        size: 40*SizeDefault.scaleWidth,
      ),
      trailing: CupertinoSwitch(
        activeColor: ColorsDefault.colorPrimary,
        value: userProvider.user.userType!="Gerente"?userProvider.sessionType!="Comprar"?true:false:userProvider.sessionType!="Observar"?true:false, 
        onChanged: (value){
          _onChangedSessionType(value: value, context: context);
        }
      ),
      onTap:(){
        bool value=userProvider.user.userType!="Gerente"?userProvider.sessionType!="Comprar"?true:false:userProvider.sessionType!="Observar"?true:false;
        _onChangedSessionType(value: !value, context: context);
      } 
    );
  }

  void _onChangedSessionType({required bool value,required BuildContext context}){
    final userProvider=context.read<UserProvider>();
    final filterUserProvider=context.read<FilterUserProvider>();
    if(value){
      if(userProvider.sessionStarted){
        filterUserProvider.mapFilter["favorites"]=false;
        userProvider.setSessionType(userProvider.user, value,context: context);
      }else{
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Necesita iniciar sesión para poder publicar inmuebles"));
      }
    }else{
      userProvider.setSessionType(userProvider.user, value,context: context);
    }
  } 


  Widget _wListTile({required BuildContext context,required String text, required Widget icon,Widget? trailing,required Function onTap}){
    return ListTile(
      leading: icon,
      trailing: trailing??SizedBox(),
      title: TextDrawer(
        text: text, 
      ),
      onTap: (){
        onTap();
      },
    );
  }