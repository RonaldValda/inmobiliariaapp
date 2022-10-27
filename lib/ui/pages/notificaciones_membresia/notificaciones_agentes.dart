import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/data/repositories/user/administrator_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/agent_registration.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:inmobiliariaapp/domain/usecases/user/usecase_administrator.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
import 'package:provider/provider.dart';
class NotificacionesMembresiaAdministrador extends StatefulWidget {
  NotificacionesMembresiaAdministrador({Key? key,required this.administrador}) : super(key: key);
  final User administrador;
  @override
  _NotificacionesMembresiaAdministradorState createState() => _NotificacionesMembresiaAdministradorState();
}

class _NotificacionesMembresiaAdministradorState extends State<NotificacionesMembresiaAdministrador> {
  List<MembershipPayment> membresiasPagos=[];
  List<AgentRegistration> inscripcionesAgentes=[];
  UseCaseAdministrator useCaseAdministrador=UseCaseAdministrator();
  @override
  void initState() {
    super.initState();
    useCaseAdministrador.getNotificationsAdministrator(widget.administrador.id).then((value) {
      if(value["completed"]){
        membresiasPagos=value["memberships_payments"];
        inscripcionesAgentes=value["agents_registrations"];
        print(inscripcionesAgentes.length);
        /*setState(() {
          
        });*/
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
  final List<MembershipPayment> membresiasPagos;
  final List<AgentRegistration> inscripcionesAgentes;
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
  final List<MembershipPayment> membresiasPagos;
  final List<AgentRegistration> inscripcionesAgentes;
  @override
  _PageNotificacionesAdministradorState createState() => _PageNotificacionesAdministradorState();
}

class _PageNotificacionesAdministradorState extends State<PageNotificacionesAdministrador> {
  List<String> planes=["Básico","Medio","Avanzado"];
  int notificacionesMembresias=0;
  int notificacionesInscripciones=0;
  int index=0;
  UseCaseAdministrator useCaseAdministrador=UseCaseAdministrator();
  @override
  void initState() {
    super.initState();
    notificacionesMembresias=widget.membresiasPagos.length;
    notificacionesInscripciones=widget.inscripcionesAgentes.length;
  }
  @override
  Widget build(BuildContext context) {
    final _usuario=Provider.of<UserProvider>(context);
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
        body: index==0?containerPagoMembresias():containerInscripcionesAgentes(_usuario.user)
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
                        backgroundColor: widget.membresiasPagos[index].authorization=="Pendiente"?
                                Colors.orange:widget.membresiasPagos[index].authorization=="Rechazado"?Colors.redAccent:
                                Colors.blueAccent,
                        foregroundColor: Colors.white,
                        child: Text(widget.membresiasPagos[index].authorization.substring(0,1)),
                      ),
                      title: Text("Usuario: ${widget.membresiasPagos[index].user.names}"),
                      subtitle: Text("Fecha Solicitud: ${widget.membresiasPagos[index].requestDate}"),
                      trailing: Text(widget.membresiasPagos[index].membershipPlanPayment.planName,
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
  Widget containerInscripcionesAgentes(User administrador){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.inscripcionesAgentes.length,
              itemBuilder: (context, index) {
                AgentRegistration inscripcion=widget.inscripcionesAgentes[index];
                return ListTile(
                  tileColor: (index+1)%2==0?Colors.black.withOpacity(0.05):Colors.transparent,
                  leading: CircleAvatar(
                    backgroundColor: inscripcion.response==""?
                            Colors.orange:inscripcion.response=="Rechazado"?Colors.redAccent:
                            Colors.blueAccent,
                    foregroundColor: Colors.white,
                    child:inscripcion.response!=""?Text(inscripcion.response.substring(0,1)):Text("P"),
                  ),
                  title: Text("Agente: ${inscripcion.userRequest.names} ${inscripcion.userRequest.surnames}"),
                  subtitle: Text("Fecha Solicitud: ${inscripcion.requestDate}"),

                  //trailing: Text(widget.inscripcionesAgentes[index].membresiaPlanesPago.nombrePlan),
                  onTap: ()async{
                    try{
                      AgentRegistration inscripcionAux=AgentRegistration.copyWith(inscripcion);
                      String respuesta=await dialogResponderInscripcionAgente(context, inscripcion);
                      if(respuesta=="Aprobado"){
                        inscripcion.response=respuesta;
                        inscripcion.userResponding.id=administrador.id;
                        useCaseAdministrador.answerAgentRegistrationRequest(inscripcion).then((value) {
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
  final MembershipPayment membresiaPago;
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
  final MembershipPayment membresiaPago;
  
  @override
  Widget build(BuildContext context) {
    final usuario=Provider.of<UserProvider>(context);
    return graphql.Mutation(
      options: graphql.MutationOptions(
        document: graphql.gql(mutationAnswerMembershipPayment()),
        onCompleted: (dynamic data){
          if(data!=null){
            //print(data["responderAgentePago"]);
            //membresiaPago=MembershipPayment(MembershipPayment.fromMap(data["responderAgentePago"]));
            //membresiaPago.membresiaPagoCopy(MembresiaPago.fromMap(data["responderAgentePago"]));
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
              "id_administrador":usuario.user.id,
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
  AgentRegistration inscripcionAgente
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
  final AgentRegistration inscripcionAgente;
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
                        Text("Nombres: ${widget.inscripcionAgente.userRequest.names} ${widget.inscripcionAgente.userRequest.surnames}"),
                        Text("Email: ${widget.inscripcionAgente.userRequest.email}"),
                        Text("Ciudad: ${widget.inscripcionAgente.userRequest.city}"),
                        Text("Agencia: ${widget.inscripcionAgente.userRequest.agencyName}"),
                        Text("Web: ${widget.inscripcionAgente.userRequest.web}"),
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
                              image: NetworkImage(widget.inscripcionAgente.requestBackupLink),
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
             FTextFieldBasico(
               controller: controller!, 
               labelText: "Observaciones", 
               onChanged: (x){
                 widget.inscripcionAgente.observations=x;
               }
              )
           ],
         ),
       );
  }
}