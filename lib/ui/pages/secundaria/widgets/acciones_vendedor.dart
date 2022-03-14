import  'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/datos_auxiliares.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_reportado.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
import 'package:inmobiliariaapp/domain/entities/notificacion.dart';
import 'package:inmobiliariaapp/domain/usecases/inmueble/usecase_inmueble_venta.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/grilla_imagenes.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/operaciones_imagenes.dart';
import 'package:inmobiliariaapp/widgets/estrellas_calificacion.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/iconos_acceso_usuario.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
class AccionesVendedor extends StatefulWidget {
  AccionesVendedor({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _AccionesVendedorState createState() => _AccionesVendedorState();
}

class _AccionesVendedorState extends State<AccionesVendedor> {
  List<Notificacion> notificaciones=[];
  SolicitudAdministrador solicitudAdministrador=SolicitudAdministrador.vacio();
  int numeroNotificaciones=0;
  UseCaseInmuebleVenta useCaseInmuebleVenta=UseCaseInmuebleVenta();
  @override
  void initState() {
    super.initState();
    useCaseInmuebleVenta.obtenerNotificacionesAccionesVendedor(widget.inmuebleTotal.inmueble.id)
    .then((value){
      if(value["completed"]){
        notificaciones=value["notificaciones"];
        solicitudAdministrador=value["administrador_inmueble"];
        numeroNotificaciones=value["numero_notificaciones"];
        notificaciones.sort((a,b)=>a.dato.fechaSolicitud.compareTo(b.dato.fechaSolicitud));
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
                widget.inmuebleTotal.getInmueble.autorizacion=="Inactivo"
                &&widget.inmuebleTotal.getInmueble.estadoNegociacion==""?
                IconoAccesoItem(
                icon: iconc.FaIcon(iconc.FontAwesomeIcons.solidHandPointUp,size: 20,color: Colors.blueGrey,),
                texto: "", 
                onTap: ()async{
                  String advertencia="Se enviará una solicitud al administrador para dar de alta el inmueble";
                  String respuesta="";
                  respuesta=await dialogAlertaVendedor(context, advertencia,0,false);
                  widget.inmuebleTotal.getInmueble.autorizacion="Pendiente";
                  if(respuesta=="Aceptar"){
                    useCaseInmuebleVenta.modificarEstadoInmueble(widget.inmuebleTotal, "Dar alta");
                  }
                }
              ):Container(),
              widget.inmuebleTotal.getInmueble.autorizacion!="Inactivo"
              &&widget.inmuebleTotal.getInmueble.estadoNegociacion!=""
              &&widget.inmuebleTotal.getInmueble.estadoNegociacion!="Vendido"
              
              ?
              Row(
                children: [
                  IconoAccesoItem(
                    icon: iconc.FaIcon(iconc.FontAwesomeIcons.solidHandPointDown,size: 20,color: Colors.blueGrey,),
                    texto: "", 
                    onTap: ()async{
                      try{
                        String advertencia="Se dará de baja el inmueble, además se le asignará solamente 1 estrella para su calificación";
                        String respuesta="";
                        respuesta=await dialogAlertaVendedor(context, advertencia,1,true);
                        print(respuesta);
                        if(respuesta=="Aceptar"){
                          bool completado=await useCaseInmuebleVenta.modificarEstadoInmueble(widget.inmuebleTotal, "Dar baja");
                          if(completado){
                            widget.inmuebleTotal.getInmueble.autorizacion="Inactivo";
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
                  IconoAccesoItem(
                    icon: iconc.FaIcon(iconc.FontAwesomeIcons.solidHandPointDown,size: 20,color: Colors.blueGrey,),
                    texto: " R", 
                    onTap: ()async{
                      try{
                      String advertencia="Se enviará una solicitud de baja del inmueble al administrador, no se afectará su calificación";
                      String respuesta="";
                      InmuebleTotal inmuebleAux=InmuebleTotal.copyWith(widget.inmuebleTotal);
                      respuesta=await dialogAlertaVendedorDarBaja(context,inmuebleAux,advertencia,"Dar baja y reportar");
                      if(respuesta=="Aceptar"){
                        bool completado=await useCaseInmuebleVenta.modificarEstadoInmueble(inmuebleAux, "Dar baja y reportar");
                        if(completado){
                          inmuebleAux.inmueble.autorizacion="Pendiente";
                          widget.inmuebleTotal.inmuebleTotalCopy(inmuebleAux);
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
                  IconoAccesoItem(
                    icon: iconc.FaIcon(iconc.FontAwesomeIcons.moneyBillWave,size: 20,color: Colors.blueGrey,),
                    texto: "", 
                    onTap: ()async{
                      String advertencia="Se declarará vendido el inmueble, además se le asignará solamente 3 estrellas para su calificación. ";
                      String respuesta="";
                      respuesta=await dialogAlertaVendedor(context, advertencia,3,true);
                      if(respuesta=="Aceptar"){
                        widget.inmuebleTotal.getInmueble.setEstadoInmueble("Vendido");
                        useCaseInmuebleVenta.modificarEstadoInmueble(widget.inmuebleTotal, "Vendido");
                      }
                    }
                  ),
                  IconoAccesoItem(
                    icon: iconc.FaIcon(iconc.FontAwesomeIcons.moneyBillWave,size: 20,color: Colors.blueGrey,),
                    texto: " R", 
                    onTap: ()async{
                      String advertencia="Se declarará vendido el inmueble, se enviará la solicitud de venta al administrador para su confirmación, además la cantidad de estrellas para su calificación será determinada por el propietario del inmueble vendido.";
                      String respuesta="";
                      InmuebleTotal inmuebleAux=InmuebleTotal.copyWith(widget.inmuebleTotal);
                      respuesta=await dialogAlertaVendedorDarBaja(context,inmuebleAux,advertencia,"Vendido y reportar");
                      if(respuesta=="Aceptar"){
                        //widget.inmuebleTotal.getInmueble.setEstadoInmueble("Vendido");
                        bool completado=await useCaseInmuebleVenta.modificarEstadoInmueble(inmuebleAux, "Vendido y reportar");
                        if(completado){
                          inmuebleAux.inmueble.estadoNegociacion="Vendido";
                          widget.inmuebleTotal.inmuebleTotalCopy(inmuebleAux);
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
}
Future<String> dialogAlertaVendedorDarBaja(
  BuildContext context,
  InmuebleTotal inmuebleTotal,
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
                              if(inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad!=""){  
                                if(inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.limiteContrato||inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.cancelacionContrato){
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
                              print(inmuebleTotal.solicitudAdministrador.inmuebleVendido.nroTestimonio);
                              if(inmuebleTotal.solicitudAdministrador.inmuebleVendido.nroTestimonio!=""){  
                                if(inmuebleTotal.solicitudAdministrador.inmuebleVendido.usuarioComprador.id!=""){
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
class DarBajaInmueble extends StatefulWidget {
  DarBajaInmueble({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
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
          Text("Nombre dueño: ${widget.inmuebleTotal.propietario.nombres} ${widget.inmuebleTotal.propietario.apellidos}"),
          SizedBox(height: 10,),
          Text("Nombre vendedor: ${widget.inmuebleTotal.creador.nombres} ${widget.inmuebleTotal.creador.apellidos}"),
          SizedBox(height: 10,),
          Divider(
            height: 0.2,
          ),
          CheckboxListTile(
            title: Text("Por límite de contrato"),
            value: widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.limiteContrato, 
            onChanged: (value){
              widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.limiteContrato=value!;
              if(value){
                widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.cancelacionContrato=false;
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
            value: widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.cancelacionContrato, 
            onChanged: (value){
              widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.cancelacionContrato=value!;
              if(value){
                widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.limiteContrato=false;
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
                  decoration:widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad!=""?
                  BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad),
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
    final file=await ImageUtils.pickMedia(
      isGallery: isGallery,
      cropImage: cropCustomImage,
    );
    if(file==null) return;

    setState(() {
      loadingImage=true;
      //widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad=file; 
    });
    uploadImagen(file).then((value){
        widget.inmuebleTotal.solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad=value;
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
}
class VendidoInmueble extends StatefulWidget {
  VendidoInmueble({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _VendidoInmuebleState createState() => _VendidoInmuebleState();
}

class _VendidoInmuebleState extends State<VendidoInmueble> {
  bool isGallery=true;
  TextEditingController? controllerEmail;
  TextEditingController? controllerNumeroTestimonio;
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
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
          TextFFBasico(
            controller: controllerNumeroTestimonio!, 
            labelText: "Número de testimonio",
            onChanged: (x){
              widget.inmuebleTotal.solicitudAdministrador.inmuebleVendido.nroTestimonio=x;
            }
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Expanded(
                child: TextFFBasico(
                  controller: controllerEmail!, 
                  labelText: "Email",
                  onChanged: (x){}
                ),
              ),
              IconButton(
                onPressed: ()async{
                  useCaseUsuario.buscarUsuarioEmail(controllerEmail!.text).then((value) {
                    if(value["completado"]){
                      widget.inmuebleTotal.solicitudAdministrador.inmuebleVendido.usuarioComprador=value["usuario"];
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
          Text("Nombre comprador: ${widget.inmuebleTotal.solicitudAdministrador.inmuebleVendido.usuarioComprador.nombres} ${widget.inmuebleTotal.solicitudAdministrador.inmuebleVendido.usuarioComprador.apellidos}"),
          SizedBox(height: 10,),
          Text("Nombre vendedor: ${widget.inmuebleTotal.creador.nombres} ${widget.inmuebleTotal.creador.apellidos}"),
          SizedBox(height: 10,),
          Divider(
            height: 0.2,
          ),
        ],
      ),
    );
  }
}
class PopupMenuNotificacionesAccionesVendedor extends StatefulWidget {
  PopupMenuNotificacionesAccionesVendedor({Key? key,required this.notificaciones,
  required this.numeroNotificaciones,
  required this.administradorInmueble}) : super(key: key);
  final List<Notificacion> notificaciones;
  final int numeroNotificaciones;
  final SolicitudAdministrador administradorInmueble;
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
  final List<Notificacion> notificaciones;
  final SolicitudAdministrador administradorInmueble;
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
                    title: Text(notificacion.dato is InmuebleQueja?"Reporte" :notificacion.dato.tipoSolicitud,
                      style: notificacion.dato.respuesta!=""?notificacion.dato.respuestaEntregada?styleLeido:styleNoLeido:styleLeido,
                    ),
                    subtitle: Text(
                      formatFechaUTC(DateTime.parse(notificacion.dato.fechaSolicitud)),
                      style: notificacion.dato.respuesta!=""?notificacion.dato.respuestaEntregada?styleLeido:styleNoLeido:styleLeido,
                    ),
                    trailing: Container(
                      width: 30,
                      height: 30,
                      color: notificacion.dato.respuesta==""?Colors.orange:(notificacion.dato.respuesta=="Confirmado"?Colors.green:Colors.redAccent),
                      child: Center(
                        child: Text(notificacion.dato.respuesta==""?"P":notificacion.dato.respuesta.substring(0,1),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    onTap: ()async{
                      notificacion.dato.respuestaEntregada=true;
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
  Notificacion notificacion,
  SolicitudAdministrador administradorInmueble
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
                    notificacion.dato is InmuebleQueja?
                    InformacionInmuebleQueja(
                      inmuebleQueja: notificacion.dato,
                      administradorInmueble: administradorInmueble
                    ):InformacionSolicitudAdministrador(solicitudAdministrador: notificacion.dato,)
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
  final InmuebleQueja inmuebleQueja;
  final SolicitudAdministrador administradorInmueble;
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
          if(widget.inmuebleQueja.sinRespuesta)
          Text(" - Sin respuesta mucho tiempo"),
          if(widget.inmuebleQueja.rechazadoSinJustificacion)
          Text(" - Rechazado sin justificación válida"),
          if(widget.inmuebleQueja.otro)
          Text(" - Otro"),
          Text("Observaciones del reporte: ${widget.inmuebleQueja.observacionesSolicitud}"),
          Text("Fecha reporte:${formatFechaUTC(DateTime.parse(widget.inmuebleQueja.fechaSolicitud))}"),
          if(widget.inmuebleQueja.respuesta!="")
          Text("Fecha reporte:${formatFechaUTC(DateTime.parse(widget.inmuebleQueja.fechaRespuesta))}"),
          widget.inmuebleQueja.respuesta==""?
          Text("Respuesta: Pendiente"):
          Text("Respuesta: ${widget.inmuebleQueja.respuesta}"),
          Text("Observaciones de la respuesta: ${widget.inmuebleQueja.observacionesRespuesta}")
        ],
      ),
    );
  }
}
class InformacionSolicitudAdministrador extends StatefulWidget {
  InformacionSolicitudAdministrador({Key? key,required this.solicitudAdministrador}) : super(key: key);
  final SolicitudAdministrador solicitudAdministrador;
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
          Text("Tipo solicitud: ${widget.solicitudAdministrador.tipoSolicitud}"),
          if(widget.solicitudAdministrador.tipoSolicitud=="Dar baja")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Razón de la baja"),
              if(widget.solicitudAdministrador.inmuebleDarBaja.limiteContrato)
              Text(" - Por límite de contrato"),
              if(widget.solicitudAdministrador.inmuebleDarBaja.cancelacionContrato)
              Text(" - Por cancelación de contrato")
            ],
          ),
          if(widget.solicitudAdministrador.tipoSolicitud=="Vendido")
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:[
              Text("N° Testimonio: ${widget.solicitudAdministrador.inmuebleVendido.nroTestimonio}"),
              Text("Nombres del comprador: ${widget.solicitudAdministrador.inmuebleVendido.usuarioComprador.nombres} ${widget.solicitudAdministrador.inmuebleVendido.usuarioComprador.apellidos}"),

            ]
          ),
          Text("Fecha solicitud: ${formatFechaUTC(DateTime.parse(widget.solicitudAdministrador.fechaSolicitud))}"),
          if(widget.solicitudAdministrador.respuesta!="")
          Text("Fecha reporte:${formatFechaUTC(DateTime.parse(widget.solicitudAdministrador.fechaRespuesta))}"),
          widget.solicitudAdministrador.respuesta==""?
          Text("Respuesta: Pendiente"):
          Text("Respuesta: ${widget.solicitudAdministrador.respuesta}"),
          Text("Observaciones: ${widget.solicitudAdministrador.observaciones}"),
          
          if(widget.solicitudAdministrador.respuesta=="Confirmado")
          Column(
            crossAxisAlignment:CrossAxisAlignment.start,
            children:[
              Text("Segunda aprobación"),
              Text("Fecha solicitud: ${formatFechaUTC(DateTime.parse(widget.solicitudAdministrador.fechaSolicitudSuperUsuario))}"),
              if(widget.solicitudAdministrador.respuestaSuperUsuario!="")
              Text("Fecha reporte:${formatFechaUTC(DateTime.parse(widget.solicitudAdministrador.fechaRespuestaSuperUsuario))}"),
              widget.solicitudAdministrador.respuesta==""?
              Text("Respuesta: Pendiente"):
              Text("Respuesta: ${widget.solicitudAdministrador.respuestaSuperUsuario}"),
              Text("Observaciones: ${widget.solicitudAdministrador.observacionesSuperUsuario}"),
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