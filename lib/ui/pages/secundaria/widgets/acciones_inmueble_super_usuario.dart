
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/configuration/graphql_configuration.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/super_usuario_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/acciones_solicitudes.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';

import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
class AccionesInmuebleSuperUsuario extends StatefulWidget {
  AccionesInmuebleSuperUsuario({Key? key}) : super(key: key);
  
  @override
  _AccionesInmuebleSuperUsuarioState createState() => _AccionesInmuebleSuperUsuarioState();
}

class _AccionesInmuebleSuperUsuarioState extends State<AccionesInmuebleSuperUsuario> {
  List<SolicitudAdministrador> administradorSolicitudes=[];
  UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  late InmuebleInfo inmuebleInfo;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      inmuebleInfo=Provider.of<InmuebleInfo>(context,listen: false);
      useCaseSuperUsuario.obtenerSolicitudesAdministradoresSuperUsuario(inmuebleInfo.inmuebleTotal.solicitudAdministrador.id)
      .then((resultado){
        if(resultado["completado"]){
          administradorSolicitudes=resultado["administrador_solicitudes"];
          setState(() {
            
          });
        }
      });
      ;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          ElevatedButton(
            onPressed: ()async{
              
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dar Alta")
              ],
            ),
            style: ElevatedButton.styleFrom(
                            primary: Colors.blue
                          ),
          ),
          SizedBox(
            width: 5,
          ),
          ElevatedButton(
            onPressed: ()async{
              
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Dar Baja")
              ],
            ),
            style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
          ),
          SizedBox(
            width:5
          ),
          ElevatedButton(
            onPressed: ()async{
              
            }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Vendido")
              ],
            ),
            style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
          ),
          SizedBox(
            width:5
          ),
          PopupMenuSolicitudesAdministrador(administradorSolicitudes: administradorSolicitudes,)
        ],
      ),
    );
  }
}
class PopupMenuItemSolicitudesAdministradorSuperUsuario extends StatefulWidget {
  PopupMenuItemSolicitudesAdministradorSuperUsuario({Key? key,required this.administradorSolicitudes}) : super(key: key);
  final List<SolicitudAdministrador> administradorSolicitudes;
  @override
  _PopupMenuItemSolicitudesAdministradorSuperUsuarioState createState() => _PopupMenuItemSolicitudesAdministradorSuperUsuarioState();
}

class _PopupMenuItemSolicitudesAdministradorSuperUsuarioState extends State<PopupMenuItemSolicitudesAdministradorSuperUsuario> {
  
  double altura=300;
  SolicitudAdministrador solicitud=SolicitudAdministrador.vacio();
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final usuarioInfo=Provider.of<UsuariosInfo>(context);
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    return Container(
      width:300,
      height:MediaQuery.of(context).size.height/3,
      child: widget.administradorSolicitudes.length>0?
      Column(
        children: [
          Text("Solicitudes",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700

            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.administradorSolicitudes.length,
              itemBuilder: (context, index) {
                var solicitud=widget.administradorSolicitudes[index];
                return ListTile(
                  title: Text(solicitud.tipoSolicitud,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  subtitle: Text(DateTime.parse(widget.administradorSolicitudes[index].fechaSolicitudSuperUsuario).toLocal().toString()),
                  trailing: Container(
                    width: 30,
                    height: 30,
                    color: solicitud.respuestaSuperUsuario==""?Colors.orange:(solicitud.respuestaSuperUsuario=="Confirmado"?Colors.green:Colors.redAccent),
                    child: Center(
                      child: Text(!widget.administradorSolicitudes[index].solicitudTerminadaSuperUsuario?"P":widget.administradorSolicitudes[index].respuesta.substring(0,1),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  onTap: ()async{
                    widget.administradorSolicitudes[index].linkRespaldoSolicitud=inmuebleInfo.inmuebleTotal.inmuebleComprobante.linkImagenDeposito;
                    String mensaje=generarTextoAlerta(solicitud.tipoSolicitud);
                    await dialogRespuestaSolicitudSuperUsuario(context,widget.administradorSolicitudes[index],inmuebleInfo.inmuebleTotalCopia,mensaje);
                   
                    if(widget.administradorSolicitudes[index].respuestaSuperUsuario!=""){
                      Map<String,dynamic> map=await responderSolicitudAdministradorSuperUsuario(usuarioInfo, inmuebleInfo.inmuebleTotalCopia, solicitud);
                      if(map["respuesta"]){
                        _inmueblesFiltrado.setInmueblesItem(inmuebleInfo.inmuebleTotalCopia, _mapaFiltroOtros.getMapaFiltroOrden,"Modificar");
                      }else{
                        if(map["mensaje"]=="El inmueble está a cargo de otro super usuario"){
                          Navigator.pop(context);
                          _inmueblesFiltrado.setInmueblesItem(inmuebleInfo.inmuebleTotalCopia, _mapaFiltroOtros.getMapaFiltroOrden,"Eliminar");
                        }
                      }
                    }
                  },
                );
              },
            ),
          )
        ]
      )
      :
      Text("Aún no tiene solicitudes",
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
  String generarTextoAlerta(String tipoSolicitud){
    String texto="";
    if(tipoSolicitud=="Dar baja") {
      texto="Solicitud de baja del inmueble";
    }else if(tipoSolicitud=="Dar alta"){
      texto="Solicitud de alta del inmueble";
    }else if(tipoSolicitud=="Vendido"){
      texto="Solicitud para declarar vendido el inmueble";
    }
    return texto;
  }
}
Future<Map<String,dynamic>> responderSolicitudAdministradorSuperUsuario(UsuariosInfo usuariosInfo,InmuebleTotal inmuebleTotal,SolicitudAdministrador solicitudAdministrador)async{
  bool respuesta=false;
  Map<String,dynamic> map={};
  GraphQLConfiguration configuration=GraphQLConfiguration();
  graphql.GraphQLClient client=configuration.myGQLClient();
  
  await client
  .mutate(
    
    graphql.MutationOptions(
      document: graphql.gql(getQueryMutationResponderSolicitudAdministradorSuperUsuario(),
    
    ),
    variables: (
     {
       "id":inmuebleTotal.solicitudAdministrador.id,
       "id_super_usuario":usuariosInfo.usuario.id,
       "tipo_solicitud":solicitudAdministrador.tipoSolicitud,
       "respuesta":solicitudAdministrador.respuestaSuperUsuario,
       "observaciones":solicitudAdministrador.observacionesSuperUsuario,
       "solicitud_terminada":true,
       "id_solicitud":solicitudAdministrador.id
     } 
    ),
    onCompleted: (dynamic data){
      if(data!=null){
        if(data["responderSolicitudAdministradorSuperUsuario"].toString()=="Registro concluido"){
          inmuebleTotal.getSolicitudAdministrador.respuestaSuperUsuario=solicitudAdministrador.respuestaSuperUsuario;
          inmuebleTotal.getSolicitudAdministrador.solicitudTerminadaSuperUsuario=true;
          inmuebleTotal.getSolicitudAdministrador.observacionesSuperUsuario=solicitudAdministrador.observacionesSuperUsuario;
          respuesta=true;
        }
      }
    },
    onError: (error){
      var ms=error!.graphqlErrors;
        ms.forEach((element) {
          print("error ${element.message}");
          if(element.message=="El inmueble está a cargo de otro super usuario"){
            if(inmuebleTotal.getSolicitudAdministrador.superUsuario.id==""){
              map["mensaje"]=element.message;
              respuesta=false;
            }
          }
      });
      respuesta=false;
    }
  ));
  map["respuesta"]=respuesta;
  return map;
}
Future dialogRespuestaSolicitudSuperUsuario(
  BuildContext context,
  SolicitudAdministrador solicitud,
  InmuebleTotal inmuebleTotal,
  String mensaje
)async{
  TextEditingController _controller=TextEditingController();
  
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: const Center(child: Text("Confirmar Solicitud",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                //height: 200,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Text(mensaje),
                    
                    solicitud.inmuebleDarBaja.id!=""?
                    ComprobanteDarBajaView(inmuebleTotal: inmuebleTotal,solicitudAdministrador: solicitud):Container(),
                    solicitud.inmuebleVendido.id!=""?
                    ComprobanteVendidoView(
                      solicitudAdministrador: solicitud, 
                      inmuebleTotal: inmuebleTotal
                    ):Container(),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Observaciones:",
                            style:TextStyle(
                              color:Colors.black54,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          TextField(
                            controller: _controller,
                            maxLines:3
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            solicitud.respuestaSuperUsuario="Confirmado";
                            solicitud.observacionesSuperUsuario=_controller.text;
                            solicitud.solicitudTerminadaSuperUsuario=true;
                            Navigator.pop(context);
                          }, 
                          child: Text("Confirmar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
                        ),
                        SizedBox(width: 5,),
                        ElevatedButton(
                          onPressed: (){
                            solicitud.respuestaSuperUsuario="Rechazado";
                            solicitud.observacionesSuperUsuario=_controller.text;
                            solicitud.solicitudTerminadaSuperUsuario=true;
                            Navigator.pop(context);
                          }, 
                          child: Text("Rechazar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                        ),
                        SizedBox(width: 5,),
                        solicitud.tipoSolicitud=="Dar alta"?solicitud.linkRespaldoSolicitud!=""?ElevatedButton(
                          onPressed: ()async{
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context)=>PageComprobanteDepositoInmueble(
                                  inmuebleTotal: inmuebleTotal,
                                )
                              )
                            );
                          }, 
                          child: Icon(Icons.document_scanner)
                        ):Container():Container()
                      ],
                    )
                  ]
                ),
              )
            ],
          );
        }
      );
    }
  ); 
}