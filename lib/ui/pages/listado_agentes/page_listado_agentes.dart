import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/user.dart';
import 'package:inmobiliariaapp/ui/pages/listado_agentes/widgets/dialog_vista_agente.dart';
import 'package:inmobiliariaapp/ui/pages/membresia_pagos/page_membresia_pagos.dart';
import 'package:inmobiliariaapp/widgets/estrellas_calificacion.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import '../../../domain/usecases/user/usecase_user.dart';
class PageListadoAgentes extends StatefulWidget {
  PageListadoAgentes({Key? key,required this.ciudad}) : super(key: key);
  final String ciudad;
  @override
  _PageListadoAgentesState createState() => _PageListadoAgentesState();
}

class _PageListadoAgentesState extends State<PageListadoAgentes> {
  List<User> agentes=[];
  List<User> agentesTop=[];
  List<String> carateres=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","Ñ","O","P","Q","R","S","T","U","V","W","X","Y","Z"];
  List<ItemAgenteAlfabeto> itemsAlfabeto=[];
  int index=0;
  UseCaseUser useCaseUsuario=UseCaseUser();
  @override
  void initState() {
    super.initState();
    useCaseUsuario.getAgentsCity(widget.ciudad).then((value) {
      if(value["completed"]){
        agentes=value["agentes"];
        itemsAlfabeto=listarAgentesAlfabeto();
        agentesTop=listarTop();
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Agentes"),
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
                    Icon(Icons.star,size:25),
                  ],
                ),
                text: "Top",
              ),
              Tab(
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_search,size:25),
                  ],
                ),
                text: "General",
              ),
            ]
          ),
        ),
        body: index==0?containerTop():containerGeneral()
      ),
    );
  }
  Widget containerTop(){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: agentesTop.length,
              itemBuilder: (context, index) {
                User agente=agentesTop[index];
                return ListTile(
                  leading: agente.photoLink==""?
                    CircleAvatar(
                      radius :25,
                      backgroundColor: agente.email!=""?Colors.amber:Colors.indigo,
                      child: Text(agente.names.toString().substring(0,1),style: TextStyle(fontSize: 20),),
                    )
                    :
                    CircleAvatar(
                      radius :25,
                      backgroundImage: CachedNetworkImageProvider(
                        agente.photoLink,
                        scale: 30
                      ),
                  ),
                  tileColor: (index+1)%2==0?Colors.black.withOpacity(0.02):Colors.transparent,
                  title: Text("${agente.surnames} ${agente.names}"),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${agente.agencyName}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          EstrellasCalificacionPorcentaje(puntajeTotal: agente.getQualification),
                        ],
                      )
                    ],
                  ),
                  trailing: Container(
                    width: 90,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child:Tooltip(
                            message: "WhatsApp",
                            child: InkWell(
                              child: iconc.FaIcon(iconc.FontAwesomeIcons.whatsapp),
                              onTap: (){

                              },
                            ),
                          )
                        ),
                        Container(
                          child:Tooltip(
                            message: "Llamar",
                            child: InkWell(
                              child: iconc.FaIcon(iconc.FontAwesomeIcons.phone),
                              onTap: ()async{
                                String number =agente.phoneNumber; //set the number here
                                await FlutterPhoneDirectCaller.callNumber(number);
                              },
                            ),
                          )
                        ),
                        Container(
                          child:Tooltip(
                            message: agente.web!=""?"Web":"Email",
                            child: InkWell(
                              child: agente.web!=""?Icon(Icons.web,size: 28,):Text("@",style: TextStyle(fontSize: 25,color:Colors.black54),),
                              onTap: ()async{
                              },
                            ),
                          )
                        ),
                      ],
                    ),
                  ),
                  onTap: ()async{
                    await dialogVistaAgente(context, agente);
                  },
                );
              },
            )
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context){
                    return PageMembresiaPagos();
                  }
                )
              );
            }, 
            child: Text("Verificarme")
          )
        ],
      ),
    );
  }
  Widget containerGeneral(){
    return Container(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: itemsAlfabeto.length,
              itemBuilder: (context, index) {
                ItemAgenteAlfabeto item=itemsAlfabeto[index];
                return Column(
                  children: [
                    ListTile(
                      tileColor: (index+1)%2==0?Colors.black.withOpacity(0.02):Colors.transparent,
                      title: Text("${item.caracter} ",
                        style: TextStyle(
                          fontWeight:FontWeight.bold,
                          fontSize: 20
                        ),
                      ),
                      onTap: (){
                        item.activado=!item.activado;
                        setState(() {
                          
                        });
                      },
                      trailing: Icon(!item.activado?Icons.keyboard_arrow_down:Icons.keyboard_arrow_up,size: 30,)
                    ),
                    if(item.activado)Column(
                      children: item.agentes.map((agente) {
                        return ListTile(
                          leading: agente.photoLink==""? 
                          CircleAvatar(
                              radius :25,
                              backgroundColor: agente.email!=""?Colors.amber:Colors.indigo,
                              child: Text(agente.names.toString().substring(0,1),style: TextStyle(fontSize: 20),),
                            )
                            :
                            CircleAvatar(
                              radius :25,
                              backgroundImage: CachedNetworkImageProvider(
                                agente.photoLink,
                                scale: 30
                              ),
                          ),
                          tileColor: (index+1)%2==0?Colors.black.withOpacity(0.02):Colors.transparent,
                          title: Text("${agente.surnames} ${agente.names}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${agente.agencyName}"),
                              EstrellasCalificacionPorcentaje(puntajeTotal: agente.getQualification),
                            ],
                          ),
                          trailing: Container(
                            width: 90,
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child:Tooltip(
                                    message: "WhatsApp",
                                    child: InkWell(
                                      child: iconc.FaIcon(iconc.FontAwesomeIcons.whatsapp),
                                      onTap: (){

                                      },
                                    ),
                                  )
                                ),
                                Container(
                                  child:Tooltip(
                                    message: "Llamar",
                                    child: InkWell(
                                      child: iconc.FaIcon(iconc.FontAwesomeIcons.phone),
                                      onTap: ()async{
                                        String number =agente.phoneNumber; //set the number here
                                        await FlutterPhoneDirectCaller.callNumber(number);
                                      },
                                    ),
                                  )
                                ),
                                Container(
                                  child:Tooltip(
                                    message: agente.web!=""?"Web":"Email",
                                    child: InkWell(
                                      child: agente.web!=""?Icon(Icons.web,size: 28,):Text("@",style: TextStyle(fontSize: 25,color:Colors.black54),),
                                      onTap: ()async{
                                      },
                                    ),
                                  )
                                ),
                              ],
                            ),
                          ),
                          onTap: ()async{
                            await dialogVistaAgente(context, agente);
                          },
                        );
                      }).toList(),
                    )
                  ],
                );
              },
            )
          )
        ],
      ),
    );
  }
  List<ItemAgenteAlfabeto> listarAgentesAlfabeto(){
    List<ItemAgenteAlfabeto> agentesAlfabeto=[];
    List<User> agentesAux=[];
    agentesAux.addAll(agentes);
    for(int i=0;i<carateres.length;i++){
      ItemAgenteAlfabeto item=ItemAgenteAlfabeto(caracter: carateres[i], agentes: [], cantidad: 0,activado: false);
      item.agentes.addAll(agentesAux.where((element) => element.surnames.substring(0,1).toUpperCase()==carateres[i].toUpperCase()));
      item.cantidad=item.agentes.length;
      agentesAux.removeWhere((element) => element.surnames.substring(0,1).toUpperCase()==carateres[i].toUpperCase());
      if(item.cantidad>0){
        item.agentes.sort((a,b)=>a.names.compareTo(b.names));
        agentesAlfabeto.add(item);
      }
    }
    return agentesAlfabeto;
  }
  List<User> listarTop(){
    List<User> agentesAux=[];
    agentesAux.addAll(agentes);
    agentesAux.sort((b,a)=>(a.quantityQualifiedsProperties).compareTo(b.quantityQualifiedsProperties));
    int cantidadMaxima=agentesAux[0].quantityQualifiedsProperties;
    print(cantidadMaxima);
    agentesAux.sort((b,a)=>((0.7*a.quantityQualifiedsProperties/cantidadMaxima)+0.3*a.getQualification).compareTo((0.7*b.quantityQualifiedsProperties/cantidadMaxima)+0.3*b.getQualification));
    if(agentesAux.length<10){
      return agentesAux;
    }
    return agentesAux.getRange(0,10).toList();
  }
}

class ItemAgenteAlfabeto{
  String caracter;
  int cantidad;
  bool activado;
  List<User> agentes;
  ItemAgenteAlfabeto({
    required this.caracter,
    required this.agentes,
    required this.cantidad,
    required this.activado
  });
}