

import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/datos_auxiliares.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/item_property_images.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';

import '../../../domain/usecases/user/usecase_super_user.dart';

class PageNotificacionesSuperUsuario extends StatefulWidget {
  PageNotificacionesSuperUsuario({Key? key,required this.usuario,required this.tipoSesion}) : super(key: key);
  final User usuario;
  final String tipoSesion;
  @override
  _PageNotificacionesSuperUsuarioState createState() => _PageNotificacionesSuperUsuarioState();
}

class _PageNotificacionesSuperUsuarioState extends State<PageNotificacionesSuperUsuario> {
  int index=0;
  int notificacionesReportados=0;
  int notificacionesQuejas=0;
  int notificacionesPagos=0;
  List<PropertyReported> inmueblesReportados=[];
  List<PropertyComplaint> inmueblesQuejas=[];
  List<MembershipPayment> membresiasPagos=[];
  UseCaseSuperUser useCaseSuperUsuario=UseCaseSuperUser();
  int total=0;
  @override
  void initState() {
    super.initState();
    try{
    useCaseSuperUsuario.getNotificationsSuperUser(widget.usuario,widget.tipoSesion)
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
    final _usuario=Provider.of<UserProvider>(context);
    
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
  Widget containerReportes(UserProvider _usuario){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: inmueblesReportados.length,
              itemBuilder: (context, index) {
                PropertyReported inmuebleReportado=inmueblesReportados[index];
                return Card(
                  child: Column(
                    children: [
                      Container(
                        height: 20,
                        child:Text(inmuebleReportado.response!=""?inmuebleReportado.response:"Pendiente",
                            style: TextStyle(
                              color: inmuebleReportado.response==""?
                        Colors.cyan:
                        inmuebleReportado.response=="Confirmado"?
                        Colors.green:Colors.red,
                            ),
                        )
                      ),
                      ItemPropertyImages(propertyTotal: inmuebleReportado.propertyTotal, index: index),
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
                                Text(inmuebleReportado.requestDate),
                                Text("Faltas:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                inmuebleReportado.soldMultiplePlaces?
                                Text("Vendido en más de un lugar"):Container(),
                                inmuebleReportado.fakeContentImage?
                                Text("Contenido falso imágen"):Container(),
                                inmuebleReportado.fakeContentText?
                                Text("Contenido falso texto"):Container(),
                                inmuebleReportado.inappropriateContent?
                                Text("Contenido imapropiado"):Container(),
                                inmuebleReportado.other?
                                Text("Otro"):Container(),
                                Text("Detalles del reporte:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(inmuebleReportado.requestObservations),
                                Text("Fecha respuesta:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                inmuebleReportado.response!=""?
                                Text(inmuebleReportado.responseDate):
                                Text(""),
                                Text("Detalles de la respuesta:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(inmuebleReportado.responseObservations),
                              ],
                            ),
                            OutlinedButton(
                              onPressed: ()async{
                                // ignore: unused_local_variable
                                String respuesta="";
                                // ignore: unused_local_variable
                                String observacionesRespuesta;
                                String respuestaInicial=inmuebleReportado.response;
                                try{
                                  respuesta=(await dialogResponderInmuebleReportado(context,inmuebleReportado));
                                  inmuebleReportado.response=respuesta;
                                  bool resultado=await useCaseSuperUsuario.answerPropertyReport(inmuebleReportado);
                                  if(resultado){
                                    if(respuestaInicial==""){
                                      notificacionesReportados--;
                                      total--;
                                      if(total<=0){
                                        _usuario.setExistsNotification(false);
                                      }
                                    }
                                    setState(() {
                                      
                                    });
                                  }
                                }catch(e){
                                  
                                }
                              }, 
                              child: Text(inmuebleReportado.response==""?
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
  Widget containerQuejas(UserProvider _usuario){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount:inmueblesQuejas.length,
              itemBuilder: (context, index) {
                PropertyComplaint queja=inmueblesQuejas[index];
                return Card(
                  child:Column(
                    children: [
                      Container(
                        height: 20,
                        child:Text(queja.response!=""?queja.response:"Pendiente",
                          style: TextStyle(
                            color: queja.response==""?   
                            Colors.cyan:
                            queja.response=="Confirmado"?
                            Colors.green:Colors.red,
                          ),
                        )
                      ),
                      ItemPropertyImages(propertyTotal: queja.propertyTotal, index: index),
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
                               Text(formatFechaUTC(DateTime.parse(queja.requestDate))),
                               Text("Faltas:",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                               ),
                               if(queja.noResponse)
                               Text("Sin respuesta mucho tiempo"),
                               if(queja.rejectedWithoutJustification)
                               Text("Rechazado sin justificación válida"),
                               if(queja.other)
                               Text("Otros"),
                               Text("Detalles del reporte:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                               ),
                               Text(queja.requestObservations),
                                Text("Fecha respuesta:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                queja.response!=""?
                                Text(queja.responseDate):
                                Text(""),
                                Text("Detalles de la respuesta:",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(queja.responseObservations),
                             ], 
                            ),
                            OutlinedButton(
                              onPressed: ()async{
                                // ignore: unused_local_variable
                                String respuesta="";
                                // ignore: unused_local_variable
                                String observacionesRespuesta;
                                try{
                                  String respuestaInicial=queja.response;
                                  respuesta=(await dialogResponderInmuebleQueja(context,queja));
                                  queja.response=respuesta;
                                  bool resultado=await useCaseSuperUsuario.answerPropertyComplaint(queja, _usuario.user.id);
                                  if(resultado){
                                    if(respuestaInicial==""){
                                      notificacionesQuejas--;
                                      total--;
                                      if(total<=0){
                                        _usuario.setExistsNotification(false);
                                      }
                                    }
                                    setState(() {
                                      
                                    });
                                  }else{
                                    queja.response=respuestaInicial;
                                  }
                                }catch(e){
                                  print(e);
                                }
                              }, 
                              child: Text(queja.response==""?
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
  Widget containerMembresiasPagos(UserProvider _usuario){
    return Container(
      child:Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: membresiasPagos.length,
              itemBuilder: (context, index) {
                MembershipPayment membresia=membresiasPagos[index];
                return Column(
                     children: [
                       ListTile(
                         leading: CircleAvatar(
                           backgroundColor: membresia.authorizationSuperUser=="Pendiente"?
                                    Colors.orange:membresia.authorizationSuperUser=="Rechazado"?Colors.redAccent:
                                    Colors.blueAccent,
                           foregroundColor: Colors.white,
                           child: Text(membresia.authorizationSuperUser.substring(0,1)),
                         ),
                         title: Text("Usuario: ${membresia.user.names} ${membresia.user.surnames}"),
                         subtitle: Text("Fecha Solicitud: ${membresia.requestDateSuperUser}"),
                         trailing: Text(membresia.membershipPlanPayment.planName,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                         ),
                         onTap: ()async{
                            try{
                              String autorizacionInicial=membresia.authorizationSuperUser;
                              String respuesta=await dialogResponderMembresiaPago(context, membresia);
                              
                              if(respuesta!=""){
                                membresia.authorizationSuperUser=respuesta;
                                bool resultado=await useCaseSuperUsuario.answerMembershipPaymentSuperUser(membresia, _usuario.user.id);
                                if(resultado){
                                  if(autorizacionInicial==""){
                                    notificacionesPagos--;
                                    total--;
                                    if(total<=0){
                                      _usuario.setExistsNotification(false);
                                    }
                                  }
                                  setState(() {
                                    
                                  });
                                }else{
                                  membresia.authorizationSuperUser=autorizacionInicial;
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
  PropertyReported inmuebleReportado
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
                    FTextFieldBasico(
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
                            inmuebleReportado.responseObservations=controller.text;
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
  PropertyComplaint queja
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
                    FTextFieldBasico(
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
                            queja.responseObservations=controller.text;
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
  MembershipPayment membresiaPago
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
  final MembershipPayment membresiaPago;
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
                        Text("Nombres: ${widget.membresiaPago.user.names}"),
                        Text("Email: ${widget.membresiaPago.user.email}"),
                        Text("Agencia: ${widget.membresiaPago.user.agencyName}"),
                        Text("Web: ${widget.membresiaPago.user.web}"),
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
                        Text("Plan: ${widget.membresiaPago.membershipPlanPayment.planName}"),
                        Text("Monto: ${widget.membresiaPago.paymentAmount}"),
                        Text("Tipo transacción: ${widget.membresiaPago.paymentMedium}"),
                        Text("Entidad financiera: ${widget.membresiaPago.bankAccount.bankName}"),
                        Text("Número de cuenta: ${widget.membresiaPago.bankAccount.accountNumber}"),
                        Text("Titular de la cuenta: ${widget.membresiaPago.bankAccount.owner}"),
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
                              image: NetworkImage(widget.membresiaPago.depositImageLink),
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