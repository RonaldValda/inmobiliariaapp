import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/administrador_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/inscripcion_agente.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_administrador.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';
class NotificacionesMembresiaAdministrador extends StatefulWidget {
  NotificacionesMembresiaAdministrador({Key? key,required this.administrador}) : super(key: key);
  final Usuario administrador;
  @override
  _NotificacionesMembresiaAdministradorState createState() => _NotificacionesMembresiaAdministradorState();
}

class _NotificacionesMembresiaAdministradorState extends State<NotificacionesMembresiaAdministrador> {
  List<MembresiaPago> membresiasPagos=[];
  List<InscripcionAgente> inscripcionesAgentes=[];
  UseCaseAdministrador useCaseAdministrador=UseCaseAdministrador();
  @override
  void initState() {
    super.initState();
    useCaseAdministrador.obtenerNotificacionesAdministrador(widget.administrador.id).then((value) {
      if(value["completed"]){
        membresiasPagos=value["membresias_pagos"];
        inscripcionesAgentes=value["inscripciones_agentes"];
        print(inscripcionesAgentes.length);
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child:ListTileNotificacionesMembresiaAdministrador(membresiasPagos: membresiasPagos,inscripcionesAgentes: inscripcionesAgentes,)
    );
  }
}
class ListTileNotificacionesMembresiaAdministrador extends StatefulWidget {
  ListTileNotificacionesMembresiaAdministrador({Key? key,required this.membresiasPagos,required this.inscripcionesAgentes}) : super(key: key);
  final List<MembresiaPago> membresiasPagos;
  final List<InscripcionAgente> inscripcionesAgentes;
  @override
  _ListTileNotificacionesMembresiaAdministradorState createState() => _ListTileNotificacionesMembresiaAdministradorState();
}

class _ListTileNotificacionesMembresiaAdministradorState extends State<ListTileNotificacionesMembresiaAdministrador> {
   String numeroNotificacion="";
   @override
  void initState() { 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if((widget.membresiasPagos.length+widget.inscripcionesAgentes.length)>99){
      numeroNotificacion="99+";
    }else if((widget.membresiasPagos.length+widget.inscripcionesAgentes.length)>0){
      numeroNotificacion=(widget.membresiasPagos.length+widget.inscripcionesAgentes.length).toString();
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
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return PageNotificacionesAdministrador(membresiasPagos: widget.membresiasPagos,inscripcionesAgentes: widget.inscripcionesAgentes,);
                }
              )
            );
        },
      );
  }
}
class PageNotificacionesAdministrador extends StatefulWidget {
  PageNotificacionesAdministrador({Key? key,required this.membresiasPagos,required this.inscripcionesAgentes}) : super(key: key);
  final List<MembresiaPago> membresiasPagos;
  final List<InscripcionAgente> inscripcionesAgentes;
  @override
  _PageNotificacionesAdministradorState createState() => _PageNotificacionesAdministradorState();
}

class _PageNotificacionesAdministradorState extends State<PageNotificacionesAdministrador> {
  List<String> planes=["Básico","Medio","Avanzado"];
  int notificacionesMembresias=0;
  int notificacionesInscripciones=0;
  int index=0;
  UseCaseAdministrador useCaseAdministrador=UseCaseAdministrador();
  @override
  void initState() {
    super.initState();
    notificacionesMembresias=widget.membresiasPagos.length;
    notificacionesInscripciones=widget.inscripcionesAgentes.length;
  }
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notificaciones"),
          bottom: TabBar(
            onTap: (val){
              index=val;
              setState(() {
                
              });
            },
            tabs: [
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person,size:25),
                    if(notificacionesMembresias>0)
                    IconoNumeroNotificacion(
                      numeroNotificaciones: notificacionesMembresias.toString(), size: Size(25,25)
                    )
                  ],
                ),
                text: "Pago de membresías",
              ),
              Tab(
                text: "Inscripciones de agentes",
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.supervised_user_circle,size:25),
                    if(notificacionesInscripciones>0)
                    IconoNumeroNotificacion(
                      numeroNotificaciones: notificacionesInscripciones.toString(), size: Size(25,25)
                    )
                  ],
                ),
              ),
            ]
          ),
        ),
        body: index==0?containerPagoMembresias():containerInscripcionesAgentes(_usuario.usuario)
      ),
    );
  }
  Widget containerPagoMembresias(){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.membresiasPagos.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: widget.membresiasPagos[index].autorizacion=="Pendiente"?
                                Colors.orange:widget.membresiasPagos[index].autorizacion=="Rechazado"?Colors.redAccent:
                                Colors.blueAccent,
                        foregroundColor: Colors.white,
                        child: Text(widget.membresiasPagos[index].autorizacion.substring(0,1)),
                      ),
                      title: Text("Usuario: ${widget.membresiasPagos[index].usuario.getNombres}"),
                      subtitle: Text("Fecha Solicitud: ${widget.membresiasPagos[index].fechaSolicitud}"),
                      trailing: Text(widget.membresiasPagos[index].membresiaPlanesPago.nombrePlan,
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onTap: ()async{
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context){
                              return PageDatosMembresiaPagos(
                                membresiaPago: widget.membresiasPagos[index],
                              );
                            }
                          )
                        );
                        setState(() {
                          
                        });
                      },
                    ),
                    Divider()
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
  Widget containerInscripcionesAgentes(Usuario administrador){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.inscripcionesAgentes.length,
              itemBuilder: (context, index) {
                InscripcionAgente inscripcion=widget.inscripcionesAgentes[index];
                return ListTile(
                  tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.transparent,
                  leading: CircleAvatar(
                    backgroundColor: inscripcion.respuesta==""?
                            Colors.orange:inscripcion.respuesta=="Rechazado"?Colors.redAccent:
                            Colors.blueAccent,
                    foregroundColor: Colors.white,
                    child:inscripcion.respuesta!=""?Text(inscripcion.respuesta.substring(0,1)):Text("P"),
                  ),
                  title: Text("Agente: ${inscripcion.usuarioSolicitante.nombres} ${inscripcion.usuarioSolicitante.apellidos}"),
                  subtitle: Text("Fecha Solicitud: ${inscripcion.fechaSolicitud}"),

                  //trailing: Text(widget.inscripcionesAgentes[index].membresiaPlanesPago.nombrePlan),
                  onTap: ()async{
                    try{
                      InscripcionAgente inscripcionAux=InscripcionAgente.copyWith(inscripcion);
                      String respuesta=await dialogResponderInscripcionAgente(context, inscripcion);
                      if(respuesta=="Aprobado"){
                        inscripcion.respuesta=respuesta;
                        inscripcion.usuarioRespondedor.id=administrador.id;
                        useCaseAdministrador.responderSolicitudInscripcionAgente(inscripcion).then((value) {
                          if(value["completed"]){
                            inscripcion=value["inscripcion_agente"];
                            setState(() {
                              
                            });
                          }else{
                            
                            inscripcion=inscripcionAux;
                          }
                        });
                      }
                    }catch(e){

                    }
                  },
                );
              },
            )
          )
        ],
      ),
    );
  }
}
class PageDatosMembresiaPagos extends StatefulWidget {
  PageDatosMembresiaPagos({Key? key,required this.membresiaPago}) : super(key: key);
  final MembresiaPago membresiaPago;
  @override
  _PageDatosMembresiaPagosState createState() => _PageDatosMembresiaPagosState();
}

class _PageDatosMembresiaPagosState extends State<PageDatosMembresiaPagos> {
  final color=Colors.grey;
  final colorFill=Colors.white12;
  List<String> planes=["Básico","Medio","Avanzado"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Membresía pagos"),
       ),
       body: Container(
         padding: EdgeInsets.all(10),
         child: Column(
           children: [
             Expanded(
               child: ListView(
                 children: [
                   Text("Datos del usuario",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                   ),
                   Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                      border: Border.all(color: color,width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Text("Nombres: ${widget.membresiaPago.usuario.nombres}"),
                        Text("Email: ${widget.membresiaPago.usuario.correo}"),
                        Text("Agencia: ${widget.membresiaPago.usuario.nombreAgencia}"),
                        Text("Web: ${widget.membresiaPago.usuario.web}"),
                       ],
                     ),
                   ),
                   Text("Datos del pago",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                   ),
                  Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                      border: Border.all(color: color,width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Text("Plan: ${widget.membresiaPago.membresiaPlanesPago.nombrePlan}"),
                        Text("Monto: ${widget.membresiaPago.montoPago}"),
                        Text("Tipo transacción: ${widget.membresiaPago.medioPago}"),
                        Text("Entidad financiera: ${widget.membresiaPago.cuentaBanco.nombreBanco}"),
                        Text("Número de cuenta: ${widget.membresiaPago.cuentaBanco.numeroCuenta}"),
                        Text("Titular de la cuenta: ${widget.membresiaPago.cuentaBanco.titular}"),
                        Text("Comprobante depósito",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                        Container(
                          height: 700,
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.membresiaPago.linkImagenDeposito),
                              fit: BoxFit.cover
                            )
                          ),
                        )
                       ],
                     ),
                   ),
                 ],
               ),
             ),
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 BotonResponderMembresiaPago(botonTexto: "Aprobado",membresiaPago: widget.membresiaPago,),
                 SizedBox(width: 10,),
                 BotonResponderMembresiaPago(botonTexto: "Rechazado",membresiaPago: widget.membresiaPago,),
               ],
             )
           ],
           
         ),
       ),
    );
  }
}
class BotonResponderMembresiaPago extends StatelessWidget {
  const BotonResponderMembresiaPago({Key? key,required this.botonTexto,required this.membresiaPago}) : super(key: key);
  final String botonTexto;
  final MembresiaPago membresiaPago;
  
  @override
  Widget build(BuildContext context) {
    final usuario=Provider.of<UsuariosInfo>(context);
    return graphql.Mutation(
      options: graphql.MutationOptions(
        document: graphql.gql(getMutationResponderMembresiaPago()),
        onCompleted: (dynamic data){
          if(data!=null){
            //print(data["responderAgentePago"]);
            membresiaPago.membresiaPagoCopy(MembresiaPago.fromMap(data["responderAgentePago"]));
            Navigator.pop(context);
          }
        },
        onError: (error){
          var ms=error!.graphqlErrors;
          ms.forEach((element) {
            print("error ${element.message}");
          });
        },
      ),
      builder: (runMutation, result) {
        return ElevatedButton(
          onPressed: (){
            runMutation({
              "id_administrador":usuario.getUsuario.id,
              "id":membresiaPago.id,
              "observaciones":"",
              "autorizacion":botonTexto
            });
          }, 
          child: Text(botonTexto)
        );
      },
    );
  }
}
Future<String> dialogResponderInscripcionAgente(
  BuildContext context,
  InscripcionAgente inscripcionAgente
)async{
  String respuesta="";
 return await showDialog(
    barrierLabel: "",
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: Text("Inscripción de agente",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                padding: EdgeInsets.all(5),
                //width: 300,
                //height: 600,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    ContainerDatosInscripcionAgente(inscripcionAgente: inscripcionAgente),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: (){
                            respuesta="Aprobado";
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Aprobado")
                        ),
                        SizedBox(width: 10,),
                        OutlinedButton(
                          onPressed: (){
                            respuesta="Rechazado";
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Rechazar",style: TextStyle(color: Colors.red),),
                        )
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
class ContainerDatosInscripcionAgente extends StatefulWidget {
  ContainerDatosInscripcionAgente({Key? key,required this.inscripcionAgente}) : super(key: key);
  final InscripcionAgente inscripcionAgente;
  @override
  _ContainerDatosInscripcionAgenteState createState() => _ContainerDatosInscripcionAgenteState();
}

class _ContainerDatosInscripcionAgenteState extends State<ContainerDatosInscripcionAgente> {
  final color=Colors.grey;
  final colorFill=Colors.white12;
  TextEditingController? controller;
  @override
  void initState() {
    super.initState();
    controller=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height/1.3,
        width: MediaQuery.of(context).size.width/1.1,
         padding: EdgeInsets.all(10),
         child: Column(
           children: [
             Expanded(
               child: ListView(
                 children: [
                   Text("Datos del usuario",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                   ),
                   Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                      border: Border.all(color: color,width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Text("Nombres: ${widget.inscripcionAgente.usuarioSolicitante.nombres} ${widget.inscripcionAgente.usuarioSolicitante.apellidos}"),
                        Text("Email: ${widget.inscripcionAgente.usuarioSolicitante.correo}"),
                        Text("Ciudad: ${widget.inscripcionAgente.usuarioSolicitante.ciudad}"),
                        Text("Agencia: ${widget.inscripcionAgente.usuarioSolicitante.nombreAgencia}"),
                        Text("Web: ${widget.inscripcionAgente.usuarioSolicitante.web}"),
                       ],
                     ),
                   ),
                   Text("Datos del pago",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                   ),
                  Container(
                     padding: EdgeInsets.all(10),
                     decoration: BoxDecoration(
                      border: Border.all(color: color,width: 1),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white
                    ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                        Text("Documento de respaldo",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                        Container(
                          height: 700,
                          width: MediaQuery.of(context).size.width/1.1,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(widget.inscripcionAgente.linkRespaldoSolicitud),
                              fit: BoxFit.cover
                            )
                          ),
                        )
                       ],
                      
                     ),
                     
                   ),
                 ],
               ),
             ),
             SizedBox(height:10),
             TextFFBasico(
               controller: controller!, 
               labelText: "Observaciones", 
               onChanged: (x){
                 widget.inscripcionAgente.observaciones=x;
               }
              )
           ],
         ),
       );
  }
}