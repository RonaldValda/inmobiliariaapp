

import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/datos_auxiliares.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_pago.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/inmueble_item/inmueble_item_imagenes.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

class PageNotificacionesSuperUsuario extends StatefulWidget {
  PageNotificacionesSuperUsuario({Key? key,required this.usuario,required this.tipoSesion}) : super(key: key);
  final Usuario usuario;
  final String tipoSesion;
  @override
  _PageNotificacionesSuperUsuarioState createState() => _PageNotificacionesSuperUsuarioState();
}

class _PageNotificacionesSuperUsuarioState extends State<PageNotificacionesSuperUsuario> {
  int index=0;
  int notificacionesReportados=0;
  int notificacionesQuejas=0;
  int notificacionesPagos=0;
  List<InmuebleReportado> inmueblesReportados=[];
  List<InmuebleQueja> inmueblesQuejas=[];
  List<MembresiaPago> membresiasPagos=[];
  UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  int total=0;
  @override
  void initState() {
    super.initState();
    try{
    useCaseSuperUsuario.obtenerNotificacionesSuperUsuario(widget.usuario,widget.tipoSesion)
    .then((value) {
      if(value["completed"]){
        inmueblesReportados=value["inmuebles_reportados"];
        inmueblesQuejas=value["inmuebles_quejas"];
        membresiasPagos=value["membresias_pagos"];
        total=inmueblesReportados.length+inmueblesQuejas.length+membresiasPagos.length;
        notificacionesReportados=inmueblesReportados.length;
        notificacionesQuejas=inmueblesQuejas.length;
        notificacionesPagos=membresiasPagos.length;
        setState(() {
          
        });
      }
    });
    }catch(e){
      print(e);
    }
    
  }
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UsuariosInfo>(context);
    
    return DefaultTabController(
      initialIndex: 0,
      length:3,
      child: Scaffold(
        appBar:AppBar(
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
                    Icon(Icons.house,size:25),
                    if(notificacionesReportados>0)
                    IconoNumeroNotificacion(
                      numeroNotificaciones: notificacionesReportados.toString(), size: Size(25,25)
                    )
                  ],
                ),
                text: "Reportes",
              ),
              Tab(
                text: "Quejas",
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning,size:25),
                    if(notificacionesQuejas>0)
                    IconoNumeroNotificacion(
                      numeroNotificaciones: notificacionesQuejas.toString(), size: Size(25,25)
                    )
                  ],
                ),
              ),
              Tab(
                text: "Membresía",
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person,size:25),
                    if(notificacionesPagos>0)
                    IconoNumeroNotificacion(
                      numeroNotificaciones: notificacionesPagos.toString(), size: Size(25,25)
                    )
                  ],
                ),
              ),
            ]
          ),
        ),
        body: index==0?containerReportes(_usuario):index==1?containerQuejas(_usuario):containerMembresiasPagos(_usuario),
      ),
    );
  }
  Widget containerReportes(UsuariosInfo _usuario){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: inmueblesReportados.length,
              itemBuilder: (context, index) {
                InmuebleReportado inmuebleReportado=inmueblesReportados[index];
                return Card(
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        child:Text(inmuebleReportado.respuesta!=""?inmuebleReportado.respuesta:"Pendiente",
                            style: TextStyle(
                              color: inmuebleReportado.respuesta==""?
                        Colors.cyan:
                        inmuebleReportado.respuesta=="Confirmado"?
                        Colors.green:Colors.red,
                            ),
                        )
                      ),
                      InmuebleItemImagenes(inmuebleTotal: inmuebleReportado.inmueble, index: index),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Fecha reporte:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(inmuebleReportado.fechaSolicitud),
                                Text("Faltas:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                inmuebleReportado.vendidoMultiplesLugares?
                                Text("Vendido en más de un lugar"):Container(),
                                inmuebleReportado.contenidoFalsoImagen?
                                Text("Contenido falso imágen"):Container(),
                                inmuebleReportado.contenidoFalsoTexto?
                                Text("Contenido falso texto"):Container(),
                                inmuebleReportado.contenidoInapropiado?
                                Text("Contenido imapropiado"):Container(),
                                inmuebleReportado.otro?
                                Text("Otro"):Container(),
                                Text("Detalles del reporte:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(inmuebleReportado.observacionesSolicitud),
                                Text("Fecha respuesta:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                inmuebleReportado.respuesta!=""?
                                Text(inmuebleReportado.fechaRespuesta):
                                Text(""),
                                Text("Detalles de la respuesta:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(inmuebleReportado.observacionesRespuesta),
                              ],
                            ),
                            OutlinedButton(
                              onPressed: ()async{
                                // ignore: unused_local_variable
                                String respuesta="";
                                // ignore: unused_local_variable
                                String observacionesRespuesta;
                                String respuestaInicial=inmuebleReportado.respuesta;
                                try{
                                  respuesta=(await dialogResponderInmuebleReportado(context,inmuebleReportado));
                                  inmuebleReportado.respuesta=respuesta;
                                  bool resultado=await useCaseSuperUsuario.responderReporteInmueble(inmuebleReportado);
                                  if(resultado){
                                    if(respuestaInicial==""){
                                      notificacionesReportados--;
                                      total--;
                                      if(total<=0){
                                        _usuario.existeNotificacion=false;
                                      }
                                    }
                                    setState(() {
                                      
                                    });
                                  }
                                }catch(e){
                                  
                                }
                              }, 
                              child: Text(inmuebleReportado.respuesta==""?
                              "Responder":"Corregir")
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            )
          )
        ],
      ),
    );
  }
  Widget containerQuejas(UsuariosInfo _usuario){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:inmueblesQuejas.length,
              itemBuilder: (context, index) {
                InmuebleQueja queja=inmueblesQuejas[index];
                return Card(
                  child:Column(
                    children: [
                      Container(
                        height: 20,
                        child:Text(queja.respuesta!=""?queja.respuesta:"Pendiente",
                          style: TextStyle(
                            color: queja.respuesta==""?   
                            Colors.cyan:
                            queja.respuesta=="Confirmado"?
                            Colors.green:Colors.red,
                          ),
                        )
                      ),
                      InmuebleItemImagenes(inmuebleTotal: queja.inmueble, index: index),
                      Container(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children:[
                            Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text("Fecha del reporte:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                               ),
                               Text(formatFechaUTC(DateTime.parse(queja.fechaSolicitud))),
                               Text("Faltas:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                               ),
                               if(queja.sinRespuesta)
                               Text("Sin respuesta mucho tiempo"),
                               if(queja.rechazadoSinJustificacion)
                               Text("Rechazado sin justificación válida"),
                               if(queja.otro)
                               Text("Otros"),
                               Text("Detalles del reporte:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                               ),
                               Text(queja.observacionesSolicitud),
                                Text("Fecha respuesta:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                queja.respuesta!=""?
                                Text(queja.fechaRespuesta):
                                Text(""),
                                Text("Detalles de la respuesta:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(queja.observacionesRespuesta),
                             ], 
                            ),
                            OutlinedButton(
                              onPressed: ()async{
                                // ignore: unused_local_variable
                                String respuesta="";
                                // ignore: unused_local_variable
                                String observacionesRespuesta;
                                try{
                                  String respuestaInicial=queja.respuesta;
                                  respuesta=(await dialogResponderInmuebleQueja(context,queja));
                                  queja.respuesta=respuesta;
                                  bool resultado=await useCaseSuperUsuario.responderInmuebleQueja(queja, _usuario.usuario.id);
                                  if(resultado){
                                    if(respuestaInicial==""){
                                      notificacionesQuejas--;
                                      total--;
                                      if(total<=0){
                                        _usuario.existeNotificacion=false;
                                      }
                                    }
                                    setState(() {
                                      
                                    });
                                  }else{
                                    queja.respuesta=respuestaInicial;
                                  }
                                }catch(e){
                                  print(e);
                                }
                              }, 
                              child: Text(queja.respuesta==""?
                              "Responder":"Corregir")
                            )
                          ]
                        ),
                      )
                    ],
                  )
                );
              },
            ),
          )
        ],
      )
    );
  }
  Widget containerMembresiasPagos(UsuariosInfo _usuario){
    return Container(
      child:Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: membresiasPagos.length,
              itemBuilder: (context, index) {
                MembresiaPago membresia=membresiasPagos[index];
                return Column(
                     children: [
                       ListTile(
                         leading: CircleAvatar(
                           backgroundColor: membresia.autorizacionSuperUsuario=="Pendiente"?
                                    Colors.orange:membresia.autorizacionSuperUsuario=="Rechazado"?Colors.redAccent:
                                    Colors.blueAccent,
                           foregroundColor: Colors.white,
                           child: Text(membresia.autorizacionSuperUsuario.substring(0,1)),
                         ),
                         title: Text("Usuario: ${membresia.usuario.getNombres} ${membresia.usuario.apellidos}"),
                         subtitle: Text("Fecha Solicitud: ${membresia.fechaSolicitudSuperUsuario}"),
                         trailing: Text(membresia.membresiaPlanesPago.nombrePlan,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                         ),
                         onTap: ()async{
                            try{
                              String autorizacionInicial=membresia.autorizacionSuperUsuario;
                              String respuesta=await dialogResponderMembresiaPago(context, membresia);
                              
                              if(respuesta!=""){
                                membresia.autorizacionSuperUsuario=respuesta;
                                bool resultado=await useCaseSuperUsuario.responderMembresiaPagoSuperUsuario(membresia, _usuario.usuario.id);
                                if(resultado){
                                  if(autorizacionInicial==""){
                                    notificacionesPagos--;
                                    total--;
                                    if(total<=0){
                                      _usuario.existeNotificacion=false;
                                    }
                                  }
                                  setState(() {
                                    
                                  });
                                }else{
                                  membresia.autorizacionSuperUsuario=autorizacionInicial;
                                }
                              }
                            }catch(e){
                                    
                            }
                         },
                       ),
                       Divider()
                     ],
                   );
              },
            )
          )
        ],
      )
    );
  }
}

Future<String> dialogResponderInmuebleReportado(
  BuildContext context,
  InmuebleReportado inmuebleReportado
)async{
  String respuesta="";
  TextEditingController controller=TextEditingController(text: "");
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
            title: Center(child: Text("Reportar inmueble",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: 300,
                //height: 200,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    TextFFBasico(
                      controller: controller,
                      labelText: "Observaciones respuesta", 
                      onChanged: (x){

                      }
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: (){
                            respuesta="Confirmado";
                            inmuebleReportado.observacionesRespuesta=controller.text;
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Corfirmar")
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
Future<String> dialogResponderInmuebleQueja(
  BuildContext context,
  InmuebleQueja queja
)async{
  String respuesta="";
  TextEditingController controller=TextEditingController(text: "");
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
            title: Center(child: Text("Queja Inmueble",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                padding: EdgeInsets.all(5),
                width: 300,
                //height: 200,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    TextFFBasico(
                      controller: controller,
                      labelText: "Observaciones respuesta", 
                      onChanged: (x){

                      }
                    ),
                    SizedBox(height: 5,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OutlinedButton(
                          onPressed: (){
                            respuesta="Confirmado";
                            queja.observacionesRespuesta=controller.text;
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Corfirmar")
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
Future<String> dialogResponderMembresiaPago(
  BuildContext context,
  MembresiaPago membresiaPago
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
            title: Center(child: Text("Membresia pago",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                padding: EdgeInsets.all(5),
                //width: 300,
                //height: 600,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    ContainerResponderMembresiasPagos(membresiaPago: membresiaPago),
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
class ContainerResponderMembresiasPagos extends StatefulWidget {
  ContainerResponderMembresiasPagos({Key? key,required this.membresiaPago}) : super(key: key);
  final MembresiaPago membresiaPago;
  @override
  _ContainerResponderMembresiasPagosState createState() => _ContainerResponderMembresiasPagosState();
}

class _ContainerResponderMembresiasPagosState extends State<ContainerResponderMembresiasPagos> {
  final color=Colors.grey;
  final colorFill=Colors.white12;
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
                 //BotonResponderMembresiaPago(botonTexto: "Aprobado",membresiaPago: widget.membresiaPago,),
                 //SizedBox(width: 10,),
                 //BotonResponderMembresiaPago(botonTexto: "Rechazado",membresiaPago: widget.membresiaPago,),
               ],
             )
           ],
           
         ),
       );
  }
}