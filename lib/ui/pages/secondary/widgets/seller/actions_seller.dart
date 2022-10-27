import  'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_reported.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/secondary/widgets/common/button_icon_notification_requests.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_plan_provider.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_notification_user_requests_provider.dart';
import 'package:inmobiliariaapp/ui/utils/general_operators.dart';
import 'package:provider/provider.dart';

import 'dialog_lower_price.dart';
class ActionsSeller extends StatefulWidget {
  ActionsSeller({Key? key}) : super(key: key);
  
  @override
  _ActionsSellerState createState() => _ActionsSellerState();
}

class _ActionsSellerState extends State<ActionsSeller> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final notificationNumber=context.watch<PropertyNotificationUserRequestsProvider>().notificationsNumber;
    final propertyTotalLast=context.watch<PropertiesProvider>().propertyTotalLast;
    final property=propertyTotalLast.property;
    return Container(
      margin: EdgeInsets.only(left:10*SizeDefault.scaleHeight,bottom: 20*SizeDefault.scaleHeight),
      padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
      height: 60*SizeDefault.scaleWidth,
      width: SizeDefault.swidth*0.75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorsDefault.colorBackgroud,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            spreadRadius: 0.5,
            blurRadius: 1,
            offset: Offset(0,1)
          )
        ]
      ),
      child: Row(
        children: [
          Expanded(
            child: ListView(
              scrollDirection:Axis.horizontal,
              shrinkWrap: true,
              children: [
                if(property.authorization!="Pendiente - Corregir datos")
                Container(
                  margin: EdgeInsets.only(right: 5*SizeDefault.scaleWidth),
                  width: 120*SizeDefault.scaleWidth,
                  child: ButtonPrimary(
                    fontSize: 11*SizeDefault.scaleHeight,
                    text: "Ver datos",
                    color: ColorsDefault.colorPrimary,
                    colorText: ColorsDefault.colorText,
                    onPressed: (){
                      context.read<RegistrationPropertyProvider>().setPropertyTotalCopy(propertyTotalLast);
                      context.read<RegistrationPropertyPlanProvider>().init(context: context);
                      Navigator.pushNamed(context, '/screen_registration_property');
                    },
                  ),
                ),
                if(property.authorization=="Pendiente - Corregir datos")
                Container(
                  margin: EdgeInsets.only(right: 5*SizeDefault.scaleWidth),
                  width: 120*SizeDefault.scaleWidth,
                  child: ButtonPrimary(
                    fontSize: 11*SizeDefault.scaleHeight,
                    text:"Corregir datos",
                    color: ColorsDefault.colorButtonAddImage,
                    colorText: ColorsDefault.colorText,
                    onPressed: (){
                      final requestLast=context.read<PropertyNotificationUserRequestsProvider>()
                      .administratorRequestLast(requestType: property.publicationDate==""?"Publicar":"Actualizar");
                      propertyTotalLast.administratorRequest=AdministratorRequest.copyWith(requestLast);
                      if(property.publicationDate!=""){
                        if(requestLast.propertyVoucher.id!=""){
                          propertyTotalLast.property.allowedUpdate=propertyTotalLast.property.counterUpdate;
                        }
                      }
                      context.read<RegistrationPropertyProvider>().setPropertyTotalCopy(propertyTotalLast);
                      context.read<RegistrationPropertyPlanProvider>().init(context: context);
                      if(property.publicationDate==""){
                        Navigator.pushNamed(context, '/screen_registration_property_choise_plan');
                      }else{
                        Navigator.pushNamed(context, '/screen_registration_property');
                      }
                     
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 5*SizeDefault.scaleWidth),
                  width: 110*SizeDefault.scaleWidth,
                  child: ButtonPrimary(
                    fontSize: 11*SizeDefault.scaleHeight,
                    text: "Rebajar precio",
                    color: property.authorization=="Activo"&&property.negotiationStatus!="Vendido"?ColorsDefault.colorPrimary:ColorsDefault.colorButtonDisabled,
                    colorText: property.authorization=="Activo"&&property.negotiationStatus!="Vendido"?ColorsDefault.colorText:ColorsDefault.colorTextDisabled,
                    onPressed: ()async{
                      if(property.authorization=="Activo"&&property.negotiationStatus!="Vendido"){
                        context.read<RegistrationPropertyProvider>().setPropertyTotalCopy(propertyTotalLast);
                        context.read<RegistrationPropertyPlanProvider>().init(context: context);
                        await dialogLowerPrice(context);
                      }
                    },
                  ),
                ),
              ],
            )
          ),
          
          ButtonIconNotificationRequests(
            existsNotification: notificationNumber>0, 
            onTap: ()async{
              await fShowModalBottomSheet(
                context: context, 
                widget: _ContainerPropertyNotificationUserRequests()
              );
            }
          ),
          
        ],
      ),
    );
  }
}
class _ContainerPropertyNotificationUserRequests extends StatefulWidget {
  _ContainerPropertyNotificationUserRequests({Key? key}) : super(key: key);
  @override
  __ContainerPropertyNotificationUserRequestsState createState() => __ContainerPropertyNotificationUserRequestsState();
}

class __ContainerPropertyNotificationUserRequestsState extends State<_ContainerPropertyNotificationUserRequests> {
  @override
  Widget build(BuildContext context) {
    final notificationsProperty=context.watch<PropertyNotificationUserRequestsProvider>().notificationsProperty;
    return Container(
          padding: EdgeInsets.all(0),
          width: double.infinity,
          height: 400*SizeDefault.scaleHeight,
          decoration: BoxDecoration(
            color: ColorsDefault.colorBackgroud,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25),),
          ),
          //color: Colors.yellow.withOpacity(0.8),
          child: notificationsProperty.length>0? Column(
            children: [
              _wHeader(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: notificationsProperty.length,
                  itemBuilder: (context, index) {
                    final notificationn= notificationsProperty[index];
                    final dateText="${GeneralOperators.stringToStringFormat(DateTime.parse(notificationn.date).toLocal().toString(),isOrderReverse:true)}";                  
                    String requestStatus="";
                    String requestType="";
                    bool readNotification=true;
                    if(notificationn.data is AdministratorRequest){
                      final AdministratorRequest request=notificationn.data;
                      requestType=request.requestType;
                      if(request.response==""){
                        requestStatus="Pendiente";
                      }else{
                        requestStatus=request.response;
                        readNotification=request.deliveredResponse;
                      }
                    }else{
                      final PropertyComplaint complaint=notificationn.data;
                      requestType="Queja";
                      if(complaint.response==""){
                        requestStatus="Pendiente";
                      }else{
                        requestStatus=complaint.response;
                        readNotification=complaint.deliveredResponse;
                      }
                    }
                    return FListTileCommon(
                      title: requestType, 
                      fontWeightTitle: readNotification?null:FontWeight.w700,
                      fontWeightSubtitle: readNotification?null:FontWeight.w600,
                      subtitle: dateText,
                      widgetTrailing: _wTrailing(requestStatus:requestStatus),
                      onTap: (){
                        if(!readNotification){
                          if(notificationn.data is AdministratorRequest){
                            context.read<PropertyNotificationUserRequestsProvider>().readNotificationAdministratorRequestUser(request: notificationn.data);
                          }
                        }
                       // context.read<PropertyAdministratorRequestsProvider>().setRequestCopy(request);
                       // Navigator.pushNamed(context, '/screen_property_request');
                      }, 
                    );
                    //_wListTile(administratorRequests, index, inmuebleInfo, context, userProvider, _inmueblesFiltrado, filterOthersProvider);
                  },
                ),
              ),
            ],
          ):Text("Aún no tiene solicitudes",
            style: TextStyle(
              fontWeight: FontWeight.w600
            ),
          )
        );
  }

  Padding _wHeader() {
    return Padding(
      padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row()
          ),
          TextStandard(
            text: "Solicitudes", 
            fontSize: 18*SizeDefault.scaleHeight,
            fontWeight: FontWeight.bold,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FXButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _wTrailing({required String requestStatus}) {
    return Container(
      width: 120*SizeDefault.scaleHeight,
      height: 30*SizeDefault.scaleHeight,
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroundRequestStatus,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextStandard(
          text:requestStatus,
          fontSize: SizeDefault.fSizeStandard,
          color:requestStatus=="Pendiente"
          ?ColorsDefault.colorTextPending:(requestStatus=="Confirmado"?ColorsDefault.colorTextApproved:ColorsDefault.colorTextRefused),
        ),
      ),
    );
  }
}


/*class ActionsSeller extends StatefulWidget {
  ActionsSeller({Key? key,required this.inmuebleTotal}) : super(key: key);
  final PropertyTotal inmuebleTotal;
  @override
  _ActionsSellerState createState() => _ActionsSellerState();
}

class _ActionsSellerState extends State<ActionsSeller> {
  List<Notificationn> notificaciones=[];
  AdministratorRequest solicitudAdministrador=AdministratorRequest.empty();
  int numeroNotificaciones=0;
  UseCasePropertySale useCaseInmuebleVenta=UseCasePropertySale();
  @override
  void initState() {
    super.initState();
    useCaseInmuebleVenta.getNotificationsActionsSalesperson(widget.inmuebleTotal.property.id)
    .then((value){
      if(value["completed"]){
        notificaciones=value["notificaciones"];
        solicitudAdministrador=value["administrador_inmueble"];
        numeroNotificaciones=value["numero_notificaciones"];
        notificaciones.sort((a,b)=>a.data.fechaSolicitud.compareTo(b.data.fechaSolicitud));
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Column(
         children: [
           Row(
              children: [
                widget.inmuebleTotal.property.authorization=="Inactivo"
                &&widget.inmuebleTotal.property.negotiationStatus==""?
                IconAccessItem(
                icon: iconc.FaIcon(iconc.FontAwesomeIcons.solidHandPointUp,size: 20,color: Colors.blueGrey,),
                text: "", 
                onTap: ()async{
                  String advertencia="Se enviará una solicitud al administrador para dar de alta el inmueble";
                  String respuesta="";
                  respuesta=await dialogAlertaVendedor(context, advertencia,0,false);
                  widget.inmuebleTotal.property.authorization="Pendiente";
                  if(respuesta=="Aceptar"){
                    useCaseInmuebleVenta.updatePropertyStatus(widget.inmuebleTotal, "Dar alta");
                  }
                }
              ):Container(),
              widget.inmuebleTotal.property.authorization!="Inactivo"
              &&widget.inmuebleTotal.property.negotiationStatus!=""
              &&widget.inmuebleTotal.property.negotiationStatus!="Vendido"
              
              ?
              Row(
                children: [
                  IconAccessItem(
                    icon: iconc.FaIcon(iconc.FontAwesomeIcons.solidHandPointDown,size: 20,color: Colors.blueGrey,),
                    text: "", 
                    onTap: ()async{
                      try{
                        String advertencia="Se dará de baja el inmueble, además se le asignará solamente 1 estrella para su calificación";
                        String respuesta="";
                        respuesta=await dialogAlertaVendedor(context, advertencia,1,true);
                        print(respuesta);
                        if(respuesta=="Aceptar"){
                          bool completado=await useCaseInmuebleVenta.updatePropertyStatus(widget.inmuebleTotal, "Dar baja");
                          if(completado){
                            widget.inmuebleTotal.property.authorization="Inactivo";
                            setState(() {
                              
                            });
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se dió de baja el inmueble"));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("¡ERROR! Vuelva a intentarlo"));
                          }
                        }
                      }catch(e){
                        print(e);
                      }
                    }
                  ),
                  IconAccessItem(
                    icon: iconc.FaIcon(iconc.FontAwesomeIcons.solidHandPointDown,size: 20,color: Colors.blueGrey,),
                    text: " R", 
                    onTap: ()async{
                      try{
                      String advertencia="Se enviará una solicitud de baja del inmueble al administrador, no se afectará su calificación";
                      String respuesta="";
                      PropertyTotal inmuebleAux=PropertyTotal.copyWith(widget.inmuebleTotal);
                      respuesta=await dialogAlertaVendedorDarBaja(context,inmuebleAux,advertencia,"Dar baja y reportar");
                      if(respuesta=="Aceptar"){
                        bool completado=await useCaseInmuebleVenta.updatePropertyStatus(inmuebleAux, "Dar baja y reportar");
                        if(completado){
                          inmuebleAux.property.authorization="Pendiente";
                          //widget.inmuebleTotal.inmuebleTotalCopy(inmuebleAux);
                          setState(() {
                            
                          });
                           ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se envió el reporte para dar de baja"));
                        }else{
                           ScaffoldMessenger.of(context).showSnackBar(showSnackBar("¡ERROR! Vuelva a intentarlo"));
                        }
                      }
                    }catch(e){

                    }
                    }
                  ),
                  IconAccessItem(
                    icon: iconc.FaIcon(iconc.FontAwesomeIcons.moneyBillWave,size: 20,color: Colors.blueGrey,),
                    text: "", 
                    onTap: ()async{
                      String advertencia="Se declarará vendido el inmueble, además se le asignará solamente 3 estrellas para su calificación. ";
                      String respuesta="";
                      respuesta=await dialogAlertaVendedor(context, advertencia,3,true);
                      if(respuesta=="Aceptar"){
                        widget.inmuebleTotal.property.negotiationStatus="Vendido";
                        useCaseInmuebleVenta.updatePropertyStatus(widget.inmuebleTotal, "Vendido");
                      }
                    }
                  ),
                  IconAccessItem(
                    icon: iconc.FaIcon(iconc.FontAwesomeIcons.moneyBillWave,size: 20,color: Colors.blueGrey,),
                    text: " R", 
                    onTap: ()async{
                      String advertencia="Se declarará vendido el inmueble, se enviará la solicitud de venta al administrador para su confirmación, además la cantidad de estrellas para su calificación será determinada por el propietario del inmueble vendido.";
                      String respuesta="";
                      PropertyTotal inmuebleAux=PropertyTotal.copyWith(widget.inmuebleTotal);
                      respuesta=await dialogAlertaVendedorDarBaja(context,inmuebleAux,advertencia,"Vendido y reportar");
                      if(respuesta=="Aceptar"){
                        //widget.inmuebleTotal.getInmueble.setEstadoInmueble("Vendido");
                        bool completado=await useCaseInmuebleVenta.updatePropertyStatus(inmuebleAux, "Vendido y reportar");
                        if(completado){
                          inmuebleAux.property.negotiationStatus="Vendido";
                          //widget.inmuebleTotal.inmuebleTotalCopy(inmuebleAux);
                          setState(() {
                            
                          });
                          ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se envió el reporte de venta"));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(showSnackBar("¡ERROR! Vuelva a intentarlo"));
                        }
                      }
                    }
                  )
                ],
              ):Container(),
              PopupMenuNotificacionesAccionesVendedor(notificaciones: notificaciones, numeroNotificaciones: numeroNotificaciones,administradorInmueble:solicitudAdministrador)
            ],
            ),
         ],
       ),
    );
  }
}
Future<String> dialogAlertaVendedor(
  BuildContext context,
  String advertencia,
  int cantidadEstrellas,
  bool calificacionAfectada
)async{
  //TextEditingController _controller=TextEditingController();
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: const Center(child: Text("Alerta",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: 250,
                //height: 250,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.zero,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          EstrellasCalificacion(cantidadEstrellas: cantidadEstrellas,),
                          Text(
                            advertencia,
                            style:TextStyle(
                              color:Colors.black54,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          Text(
                            "¿Desea continuar?",
                            style:TextStyle(
                              color:Colors.black54,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            String respuesta="Aceptar";
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Aceptar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            String respuesta="Cancelar";
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Cancelar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                        ),
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
}*/
/*
Future<String> dialogAlertaVendedorDarBaja(
  BuildContext context,
  PropertyTotal inmuebleTotal,
  String alerta,
  String tipoAccion,
)async{
  //TextEditingController _controller=TextEditingController();
  String textoError="";
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: const Center(child: Text("Alerta",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: MediaQuery.of(context).size.width/1.2,
                //height: 250,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          tipoAccion=="Dar baja y reportar"?
                          DarBajaInmueble(inmuebleTotal: inmuebleTotal):
                          VendidoInmueble(inmuebleTotal: inmuebleTotal),
                          EstrellasCalificacion(cantidadEstrellas: 3,),
                          Text(
                            alerta,
                            style:TextStyle(
                              color:Colors.black54,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          Text(
                            "¿Desea continuar?",
                            style:TextStyle(
                              color:Colors.black54,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ],
                      ),
                    ),
                    Text(textoError,
                        style: TextStyle(
                          color: Colors.red
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            String respuesta="Aceptar";
                            if(tipoAccion=="Dar baja y reportar"){
                              if(inmuebleTotal.administratorRequest.propertyUnsubscribe.documentPropertyImageLink!=""){  
                                if(inmuebleTotal.administratorRequest.propertyUnsubscribe.contractLimit||inmuebleTotal.administratorRequest.propertyUnsubscribe.contractCancel){
                                  Navigator.pop(context,respuesta);
                                }else{
                                  textoError="¡ERROR! Debe seleccionar alguna de las opciones";
                                  setState(() {
                                    
                                  });
                                }
                              }else{
                                textoError="¡ERROR! Debe subir el documento de propiedad (inmueble)";
                                setState(() {
                                  
                                });
                              }
                            }else{
                              print(inmuebleTotal.administratorRequest.propertySold.testimonyNumber);
                              if(inmuebleTotal.administratorRequest.propertySold.testimonyNumber!=""){  
                                if(inmuebleTotal.administratorRequest.propertySold.userBuyer.id!=""){
                                  //print(inmuebleTotal.solicitudAdministrador.inmuebleVendido.usuarioComprador.id);
                                  Navigator.pop(context,respuesta);
                                }else{
                                  textoError="¡ERROR! Debe buscar al usuario comprador";
                                  setState(() {
                                    
                                  });
                                }
                              }else{
                                textoError="¡ERROR! Debe completar el número de testimonio";
                                setState(() {
                                  
                                });
                              }
                            }
                          }, 
                          child: Text("Aceptar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            String respuesta="Cancelar";
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Cancelar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                        ),
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
*/
/*
class DarBajaInmueble extends StatefulWidget {
  DarBajaInmueble({Key? key,required this.inmuebleTotal}) : super(key: key);
  final PropertyTotal inmuebleTotal;
  @override
  _DarBajaInmuebleState createState() => _DarBajaInmuebleState();
}

class _DarBajaInmuebleState extends State<DarBajaInmueble> {
  bool isGallery=true;
  bool loadingImage=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nombre dueño: ${widget.inmuebleTotal.owner.names} ${widget.inmuebleTotal.owner.surnames}"),
          SizedBox(height: 10,),
          Text("Nombre vendedor: ${widget.inmuebleTotal.creator.names} ${widget.inmuebleTotal.creator.surnames}"),
          SizedBox(height: 10,),
          Divider(
            height: 0.2,
          ),
          CheckboxListTile(
            title: Text("Por límite de contrato"),
            value: widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.contractLimit, 
            onChanged: (value){
              widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.contractLimit=value!;
              if(value){
                widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.contractCancel=false;
              }
              setState(() {
                
              });
            }
          ),
          Divider(
            height: 0.2,
          ),
          
          CheckboxListTile(
            title: Text("Por cancelación de contrato"),
            value: widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.contractCancel, 
            onChanged: (value){
              widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.contractCancel=value!;
              if(value){
                widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.contractLimit=false;
              }
              setState(() {
                
              });
            }
          ),
          Divider(
            height: 0.2,
          ),
          Text("Imágen del documento de propiedad",
            style: TextStyle(
              color: Colors.blue
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2.5,
            child: Stack(
              children: [
                Container(
                  //color: Colors.black12,
                  decoration:widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.documentPropertyImageLink!=""?
                  BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.documentPropertyImageLink),
                      fit: BoxFit.cover
                    )
                  ):BoxDecoration(
                    color:Colors.black12
                  )
                ),
                loadingImage?Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,

                  ),
                ):Container(),
                Container(
                  margin: EdgeInsets.all(10),
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black45,
                    
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: onPressedUploadImage,
                    icon: Icon(Icons.upload,color: Colors.white,)
                  ),
                )
              ],
            ),
          ),
          
        ],
      ),
    );
  }
  void onPressedUploadImage() async{
    /*final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );*/
    final file=await ImageUtils.uploadImage();
    if(file==null) return;

    setState(() {
      loadingImage=true;
      //widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad=file; 
    });
    uploadImagen(file).then((value){
        widget.inmuebleTotal.administratorRequest.propertyUnsubscribe.documentPropertyImageLink=value;
    }).onError((error, stackTrace) {
      loadingImage=false;
      setState(() {
        
      });
    }).whenComplete(() {
      setState(() {
        loadingImage=false;
      });
    });
  }
}*/
/*
class VendidoInmueble extends StatefulWidget {
  VendidoInmueble({Key? key,required this.inmuebleTotal}) : super(key: key);
  final PropertyTotal inmuebleTotal;
  @override
  _VendidoInmuebleState createState() => _VendidoInmuebleState();
}

class _VendidoInmuebleState extends State<VendidoInmueble> {
  bool isGallery=true;
  TextEditingController? controllerEmail;
  TextEditingController? controllerNumeroTestimonio;
  UseCaseUser useCaseUsuario=UseCaseUser();
  @override
  void initState() {
    super.initState();
    controllerEmail=TextEditingController(text: "");
    controllerNumeroTestimonio=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FTextFieldBasico(
            controller: controllerNumeroTestimonio!, 
            labelText: "Número de testimonio",
            onChanged: (x){
              widget.inmuebleTotal.administratorRequest.propertySold.testimonyNumber=x;
            }
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: FTextFieldBasico(
                  controller: controllerEmail!, 
                  labelText: "Email",
                  onChanged: (x){}
                ),
              ),
              IconButton(
                onPressed: ()async{
                  useCaseUsuario.searchUserEmail(controllerEmail!.text).then((value) {
                    if(value["completado"]){
                      widget.inmuebleTotal.administratorRequest.propertySold.userBuyer=value["usuario"];
                    }else{

                    }
                  }).whenComplete((){
                    setState(() {
                      
                    });
                  });
                },
                 icon: Icon(Icons.search)
                )
            ],
          ),
          Divider(
            height: 0.2,
          ),
          SizedBox(height: 10,),
          Text("Nombre comprador: ${widget.inmuebleTotal.administratorRequest.propertySold.userBuyer.names} ${widget.inmuebleTotal.administratorRequest.propertySold.userBuyer.surnames}"),
          SizedBox(height: 10,),
          Text("Nombre vendedor: ${widget.inmuebleTotal.creator.names} ${widget.inmuebleTotal.creator.surnames}"),
          SizedBox(height: 10,),
          Divider(
            height: 0.2,
          ),
        ],
      ),
    );
  }
}*/
/*
class PopupMenuNotificacionesAccionesVendedor extends StatefulWidget {
  PopupMenuNotificacionesAccionesVendedor({Key? key,required this.notificaciones,
  required this.numeroNotificaciones,
  required this.administradorInmueble}) : super(key: key);
  final List<Notificationn> notificaciones;
  final int numeroNotificaciones;
  final AdministratorRequest administradorInmueble;
  @override
  _PopupMenuNotificacionesAccionesVendedorState createState() => _PopupMenuNotificacionesAccionesVendedorState();
}

class _PopupMenuNotificacionesAccionesVendedorState extends State<PopupMenuNotificacionesAccionesVendedor> {
  @override
  Widget build(BuildContext context) {
    return Container(
          height:40,
          width: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border:Border.all(color:Colors.blueGrey,style: BorderStyle.solid)
          ),
          child: PopupMenuButton(
            tooltip: "Solicitudes",
            elevation: 30,
            offset: const Offset(0, 40),
            color: Colors.white.withOpacity(0.8),
            enableFeedback: false,
            child: Row(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                Icon(Icons.message,color:Colors.blueGrey),
                if(widget.numeroNotificaciones>0)Container(
                  width:25,
                  height:25,
                  decoration: BoxDecoration(
                    color:Colors.red,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child:Center(
                    child: Text(widget.numeroNotificaciones.toString(),
                      style:TextStyle(
                        color:Colors.white
                      )
                    )
                  )
                )
              ]
            ),
            //icon: Ico
            padding: EdgeInsets.zero,
            itemBuilder: (context){
              return [
                PopupMenuItem<int>(
                  padding: EdgeInsets.all(5),
                  value: 0, 
                  child: PopupMenuItemNotificacionesAccionesVendedor(notificaciones: widget.notificaciones,administradorInmueble:widget.administradorInmueble)
                ),
              ];
            }
          ),
        );
  }
}
class PopupMenuItemNotificacionesAccionesVendedor extends StatefulWidget {
  PopupMenuItemNotificacionesAccionesVendedor({Key? key,required this.notificaciones,required this.administradorInmueble}) : super(key: key);
  final List<Notificationn> notificaciones;
  final AdministratorRequest administradorInmueble;
  @override
  _PopupMenuItemNotificacionesAccionesVendedorState createState() => _PopupMenuItemNotificacionesAccionesVendedorState();
}

class _PopupMenuItemNotificacionesAccionesVendedorState extends State<PopupMenuItemNotificacionesAccionesVendedor> {
  TextStyle styleNoLeido=TextStyle(
    fontWeight:FontWeight.bold
  );
  TextStyle styleLeido=TextStyle(

  );
  
  double altura=300;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0),
      width: 300,
      height: MediaQuery.of(context).size.height*0.3,
      //color: Colors.yellow.withOpacity(0.8),
      child: widget.notificaciones.length>0? Column(
        children: [
          Text("Solicitudes",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700

            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.notificaciones.length,
              itemBuilder: (context, index) {
                var notificacion=widget.notificaciones[index];
                return ListTile(
                    title: Text(notificacion.data is PropertyComplaint?"Reporte" :notificacion.data.requestType,
                      style: notificacion.data.responser!=""?notificacion.data.respuestaEntregada?styleLeido:styleNoLeido:styleLeido,
                    ),
                    subtitle: Text(
                      formatFechaUTC(DateTime.parse(notificacion.data.fechaSolicitud)),
                      style: notificacion.data.responser!=""?notificacion.data.respuestaEntregada?styleLeido:styleNoLeido:styleLeido,
                    ),
                    trailing: Container(
                      width: 30,
                      height: 30,
                      color: notificacion.data.responser==""?Colors.orange:(notificacion.data.responser=="Confirmado"?Colors.green:Colors.redAccent),
                      child: Center(
                        child: Text(notificacion.data.responser==""?"P":notificacion.data.responser.substring(0,1),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    onTap: ()async{
                      notificacion.data.respuestaEntregada=true;
                      setState(() {
                        
                      });
                      await dialogInfoSolicitud(context,"Reporte",notificacion,widget.administradorInmueble);
                    },
                  );
              },
            ),
          ),
        ],
      ):Text("Aún no tiene solicitudes",
        style: TextStyle(
          fontWeight: FontWeight.w600
        ),
      )
    );
  }
}
Future dialogInfoSolicitud(
  BuildContext context,
  String titulo,
  Notificationn notificacion,
  AdministratorRequest administradorInmueble
)async{
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: Text(titulo, style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                //height: 200,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    notificacion.data is PropertyComplaint?
                    InformacionInmuebleQueja(
                      inmuebleQueja: notificacion.data,
                      administradorInmueble: administradorInmueble
                    ):InformacionSolicitudAdministrador(solicitudAdministrador: notificacion.data,)
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
class InformacionInmuebleQueja extends StatefulWidget {
  InformacionInmuebleQueja({Key? key,required this.inmuebleQueja,required this.administradorInmueble}) : super(key: key);
  final PropertyComplaint inmuebleQueja;
  final AdministratorRequest administradorInmueble;
  @override
  _InformacionInmuebleQuejaState createState() => _InformacionInmuebleQuejaState();
}

class _InformacionInmuebleQuejaState extends State<InformacionInmuebleQueja> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text("Detalle del reporte"),
          if(widget.inmuebleQueja.noResponse)
          Text(" - Sin respuesta mucho tiempo"),
          if(widget.inmuebleQueja.rejectedWithoutJustification)
          Text(" - Rechazado sin justificación válida"),
          if(widget.inmuebleQueja.other)
          Text(" - Otro"),
          Text("Observaciones del reporte: ${widget.inmuebleQueja.requestObservations}"),
          Text("Fecha reporte:${formatFechaUTC(DateTime.parse(widget.inmuebleQueja.requestDate))}"),
          if(widget.inmuebleQueja.response!="")
          Text("Fecha reporte:${formatFechaUTC(DateTime.parse(widget.inmuebleQueja.responseDate))}"),
          widget.inmuebleQueja.response==""?
          Text("Respuesta: Pendiente"):
          Text("Respuesta: ${widget.inmuebleQueja.response}"),
          Text("Observaciones de la respuesta: ${widget.inmuebleQueja.responseObservations}")
        ],
      ),
    );
  }
}*/
/*
class InformacionSolicitudAdministrador extends StatefulWidget {
  InformacionSolicitudAdministrador({Key? key,required this.solicitudAdministrador}) : super(key: key);
  final AdministratorRequest solicitudAdministrador;
  @override
  _InformacionSolicitudAdministradorState createState() => _InformacionSolicitudAdministradorState();
}

class _InformacionSolicitudAdministradorState extends State<InformacionSolicitudAdministrador> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.all(10),
      child:Column(
        crossAxisAlignment:CrossAxisAlignment.start,
        children: [
          Text("Primera aprobación"),
          Text("Tipo solicitud: ${widget.solicitudAdministrador.requestType}"),
          if(widget.solicitudAdministrador.requestType=="Dar baja")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Razón de la baja"),
              if(widget.solicitudAdministrador.propertyUnsubscribe.contractLimit)
              Text(" - Por límite de contrato"),
              if(widget.solicitudAdministrador.propertyUnsubscribe.contractCancel)
              Text(" - Por cancelación de contrato")
            ],
          ),
          if(widget.solicitudAdministrador.requestType=="Vendido")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text("N° Testimonio: ${widget.solicitudAdministrador.propertySold.testimonyNumber}"),
              Text("Nombres del comprador: ${widget.solicitudAdministrador.propertySold.userBuyer.names} ${widget.solicitudAdministrador.propertySold.userBuyer.surnames}"),

            ]
          ),
          Text("Fecha solicitud: ${formatFechaUTC(DateTime.parse(widget.solicitudAdministrador.requestDate))}"),
          if(widget.solicitudAdministrador.response!="")
          Text("Fecha reporte:${formatFechaUTC(DateTime.parse(widget.solicitudAdministrador.responseDate))}"),
          widget.solicitudAdministrador.response==""?
          Text("Respuesta: Pendiente"):
          Text("Respuesta: ${widget.solicitudAdministrador.response}"),
          Text("Observaciones: ${widget.solicitudAdministrador.observations}"),
          
          if(widget.solicitudAdministrador.response=="Confirmado")
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text("Segunda aprobación"),
              Text("Fecha solicitud: ${formatFechaUTC(DateTime.parse(widget.solicitudAdministrador.requestDateSuperUser))}"),
              if(widget.solicitudAdministrador.responseSuperUser!="")
              Text("Fecha reporte:${formatFechaUTC(DateTime.parse(widget.solicitudAdministrador.responseDateSuperUser))}"),
              widget.solicitudAdministrador.response==""?
              Text("Respuesta: Pendiente"):
              Text("Respuesta: ${widget.solicitudAdministrador.responseSuperUser}"),
              Text("Observaciones: ${widget.solicitudAdministrador.observationsSuperUser}"),
            ]
          ),
          
        ],
      )
    );
  }
  Widget containerUsuarioCo(){
    Container container=Container(
      child: Column(
        children:[
          
        ]
      ),
    );
    return container;
  }
}
*/