import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/entities/solicitud_administrador.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_administrador.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/acciones_inmueble_super_usuario.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_otros_info.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';

String generarTextoNotificacion(String tipoSolicitud){
  String texto="";
  if(tipoSolicitud=="Dar Alta") {
    texto="Solicitud de Alta del inmueble";
  }
  return texto;
}
Future dialogRespuestaSolicitud(
  BuildContext context,
  SolicitudAdministrador solicitud,
  InmuebleTotal inmuebleTotal,
  Usuario usuarioComprador,
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
                width: MediaQuery.of(context).size.width/1.2,
                //height: 200,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Text(mensaje),
                    SizedBox(height: 10,),
                    solicitud.inmuebleDarBaja.id!=""?
                    ComprobanteDarBajaView(
                      solicitudAdministrador: solicitud, 
                      inmuebleTotal: inmuebleTotal
                    ):Container(),
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
                            solicitud.respuesta="Confirmado";
                            solicitud.observaciones=_controller.text;
                            solicitud.solicitudTerminada=true;
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
                            solicitud.respuesta="Rechazado";
                            solicitud.observaciones=_controller.text;
                            solicitud.solicitudTerminada=true;
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

class PopupMenuSolicitudesAdministrador extends StatefulWidget {
  PopupMenuSolicitudesAdministrador({Key? key,required this.administradorSolicitudes}) : super(key: key);
  final List<SolicitudAdministrador> administradorSolicitudes;
  @override
  _PopupMenuSolicitudesAdministradorState createState() => _PopupMenuSolicitudesAdministradorState();
}

class _PopupMenuSolicitudesAdministradorState extends State<PopupMenuSolicitudesAdministrador> {
  @override
  Widget build(BuildContext context) {
    final usuario=Provider.of<UsuariosInfo>(context);
    return Container(
          height:30,
          width: 40,
          
          child: PopupMenuButton(
            tooltip: "Solicitudes",
            elevation: 30,
            offset: const Offset(0, 40),
            color: Colors.white.withOpacity(0.8),
            enableFeedback: false,
            child: IconoNotificacionSolicitud(administradorSolicitudes: widget.administradorSolicitudes,),
            //icon: Ico
            padding: EdgeInsets.zero,
            itemBuilder: (context){
              return [
                PopupMenuItem<int>(
                  padding: EdgeInsets.all(5),
                  value: 0, 
                  child: usuario.tipoSesion=="Supervisar"?
                    PopupMenuItemSolicitudesAdministradorSuperUsuario(administradorSolicitudes: widget.administradorSolicitudes):
                    PopupMenuItemSolicitudes(administradorSolicitudes: widget.administradorSolicitudes,)
                ),
              ];
            }
          ),
        );
  }
}
class IconoNotificacionSolicitud extends StatefulWidget {
  IconoNotificacionSolicitud({Key? key,required this.administradorSolicitudes}) : super(key: key);
  final List<SolicitudAdministrador> administradorSolicitudes;
  @override
  _IconoNotificacionSolicitudState createState() => _IconoNotificacionSolicitudState();
}

class _IconoNotificacionSolicitudState extends State<IconoNotificacionSolicitud> {
  String numeroNotificacion="5";
  @override
  void initState() {
    super.initState();
    
    //numeroNotificacion=widget.inmuebles.length.toString();
  }
  @override
  Widget build(BuildContext context) {
    if(widget.administradorSolicitudes.length>9){
      numeroNotificacion="9+";
    }else{
      numeroNotificacion=widget.administradorSolicitudes.length.toString();
    }
    return InkWell(
      child: Stack(
          children: [
            InkWell(
              child:Icon(
                Icons.message,
                  color: Colors.black38,
                  size: 30,
                ),
                onTap: (){
                  setState(() {
                    numeroNotificacion="0";
                  });
                },
            ),
            numeroNotificacion!="0"? Container(
              width: 40,
              height: 40,
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(top: 0),
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffc32c37),
                    border: Border.all(color: Colors.white, width: 1)),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Center(
                    child: Text(
                      numeroNotificacion.toString(),
                      //_counter.toString(),
                      style: TextStyle(fontSize: 10,color: Colors.white),
                    ),
                  ),
                ),
              ),
            ):Container(
              width: 30,
              height: 30,
            ),
          ],
        ),
    );
  }
}
class PopupMenuItemSolicitudes extends StatefulWidget {
  PopupMenuItemSolicitudes({Key? key,required this.administradorSolicitudes}) : super(key: key);
  final List<SolicitudAdministrador> administradorSolicitudes;
  @override
  _PopupMenuItemSolicitudesState createState() => _PopupMenuItemSolicitudesState();
}

class _PopupMenuItemSolicitudesState extends State<PopupMenuItemSolicitudes> {
  
  double altura=300;
  SolicitudAdministrador solicitud=SolicitudAdministrador.vacio();
  UseCaseAdministrador useCaseAdministrador=UseCaseAdministrador();
  @override
  Widget build(BuildContext context) {
    final _mapaFiltroOtros=Provider.of<MapaFiltroOtrosInfo>(context);
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final usuarioInfo=Provider.of<UsuariosInfo>(context);
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    return Container(
          padding: EdgeInsets.all(0),
          width: 300,
          height: MediaQuery.of(context).size.height*0.3,
          //color: Colors.yellow.withOpacity(0.8),
          child: widget.administradorSolicitudes.length>0? Column(
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
                  itemCount: widget.administradorSolicitudes.length,
                  itemBuilder: (context, index) {
                    solicitud=widget.administradorSolicitudes[index];
                    return ListTile(
                        title: Text(solicitud.tipoSolicitud,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic
                          ),
                        ),
                        subtitle: Text(DateTime.parse(widget.administradorSolicitudes[index].fechaSolicitud).toLocal().toString()),
                        trailing: Container(
                          width: 30,
                          height: 30,
                          color: solicitud.respuesta==""?Colors.orange:(solicitud.respuesta=="Confirmado"?Colors.green:Colors.redAccent),
                          child: Center(
                            child: Text(!widget.administradorSolicitudes[index].solicitudTerminada?"P":widget.administradorSolicitudes[index].respuesta.substring(0,1),
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        onTap: ()async{
                          Usuario usuarioComprador=Usuario.vacio();
                          //print("asd ${inmuebleInfo.inmuebleTotal.inmuebleComprobante.id}");
                          widget.administradorSolicitudes[index].linkRespaldoSolicitud=inmuebleInfo.inmuebleTotal.inmuebleComprobante.linkImagenDeposito;
                          String mensaje=generarTextoAlerta(solicitud.tipoSolicitud);
                          await dialogRespuestaSolicitud(context,widget.administradorSolicitudes[index],inmuebleInfo.inmuebleTotal,usuarioComprador,mensaje);
                          
                          if(widget.administradorSolicitudes[index].respuesta!=""){
                            solicitud=widget.administradorSolicitudes[index];
                            Map<String,dynamic> mapRespuesta=await useCaseAdministrador.responderSolicitudAdministrador(usuarioInfo.usuario,inmuebleInfo.inmuebleTotal.solicitudAdministrador, widget.administradorSolicitudes[index]);
                            if(mapRespuesta["completed"]){
                              //print("mensaje ${mapRespuesta["mensaje"]}");
                              if(mapRespuesta["mensaje"]=="Registro concluido"){
                                //print("object");
                                inmuebleInfo.inmuebleTotal.getSolicitudAdministrador.respuesta=solicitud.respuesta;
                                inmuebleInfo.inmuebleTotal.getSolicitudAdministrador.solicitudTerminada=true;
                                inmuebleInfo.inmuebleTotal.getSolicitudAdministrador.observaciones=solicitud.observaciones;
                                inmuebleInfo.inmuebleTotal.getSolicitudAdministrador.linkRespaldoSolicitud=solicitud.linkRespaldoSolicitud;
                                inmuebleInfo.inmuebleTotal.getSolicitudAdministrador.linkRespaldoRespuesta=solicitud.linkRespaldoRespuesta;
                                _inmueblesFiltrado.setInmueblesItem(inmuebleInfo.inmuebleTotal, _mapaFiltroOtros.getMapaFiltroOrden,"Modificar");
                                
                              }
                            }else{
                              
                              //print("mensaje 1 ${mapRespuesta["mensaje"]}");
                              if(mapRespuesta["mensaje"]=="El inmueble está a cargo de otro administrador"){
                                if(inmuebleInfo.inmuebleTotal.getSolicitudAdministrador.usuarioRespondedor.id==""){
                                  Navigator.pop(context);
                                  _inmueblesFiltrado.setInmueblesItem(inmuebleInfo.inmuebleTotal, _mapaFiltroOtros.getMapaFiltroOrden,"Eliminar");
                                }
                              }else{

                              }
                            }
                          }
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
class PageComprobanteDepositoInmueble extends StatefulWidget {
  PageComprobanteDepositoInmueble({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _PageComprobanteDepositoInmuebleState createState() => _PageComprobanteDepositoInmuebleState();
}

class _PageComprobanteDepositoInmuebleState extends State<PageComprobanteDepositoInmueble> {
  double heigthImagen=0;
  double widthImagen=0;
  @override
  Widget build(BuildContext context) {
    final InmuebleComprobante inmuebleComprobante=widget.inmuebleTotal.inmuebleComprobante;
    heigthImagen=MediaQuery.of(context).size.height/1.7;
    widthImagen=MediaQuery.of(context).size.width/1.1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Comprobante depósito"),
      ),
      body: Container(
        child:Column(
          children: [
            Text("Medio pago: ${inmuebleComprobante.medioPago}"),
            Text("Cuenta: ${inmuebleComprobante.cuentaBanco.numeroCuenta} | ${inmuebleComprobante.cuentaBanco.nombreBanco}"),
            Text("Número de transacción: ${inmuebleComprobante.numeroTransaccion}"),
            Text("Monto pago: ${inmuebleComprobante.montoPago}"),
            Text("Depositante: ${inmuebleComprobante.nombreDepositante}"),
            Container(
              alignment: Alignment.bottomLeft,
              height: heigthImagen,
              width: widthImagen,
              margin: EdgeInsets.all(0),
              decoration: 
                BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(inmuebleComprobante.linkImagenDeposito),
                  //image:(_image[index] is String)? (NetworkImage(_image[index].toString())):FileImage(_image[index] as File),
                  fit: BoxFit.fill
                ),
              )
            )
          ],
        )
      ),
    );
  }
}
class ComprobanteDarBajaView extends StatelessWidget {
  const ComprobanteDarBajaView({Key? key,required this.solicitudAdministrador,required this.inmuebleTotal}) : super(key: key);
  final SolicitudAdministrador solicitudAdministrador;
  final InmuebleTotal inmuebleTotal;
  @override
  Widget build(BuildContext context) {
    print(solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Email del dueño: ${inmuebleTotal.propietario.correo}"),
          Text("Nombres del dueño: ${inmuebleTotal.propietario.nombres} ${inmuebleTotal.propietario.apellidos}"),
          Text("Email del vendedor: ${inmuebleTotal.creador.correo}"),
          Text("Nombres del vendedor: ${inmuebleTotal.creador.nombres} ${inmuebleTotal.creador.apellidos}"),
          Text("Motivo de la baja: ${solicitudAdministrador.inmuebleDarBaja.limiteContrato?"Por límite de contrato":"Por cancelación de contrato"}"),
           Container(
              alignment: Alignment.bottomLeft,
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(0),
              decoration: 
                BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad),
                  //image:(_image[index] is String)? (NetworkImage(_image[index].toString())):FileImage(_image[index] as File),
                  fit: BoxFit.fill
                ),
              )
            )
        ],
      ),
    );
  }
}
class ComprobanteVendidoView extends StatelessWidget {
  const ComprobanteVendidoView({Key? key,required this.solicitudAdministrador,required this.inmuebleTotal}) : super(key: key);
  final SolicitudAdministrador solicitudAdministrador;
  final InmuebleTotal inmuebleTotal;
  @override
  Widget build(BuildContext context) {
    print(solicitudAdministrador.inmuebleDarBaja.imagenDocumentoPropiedad);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Nº Testimonio: ${solicitudAdministrador.inmuebleVendido.nroTestimonio}"),
          Text("Email del comprador: ${solicitudAdministrador.inmuebleVendido.usuarioComprador.correo}"),
          Text("Nombres del comprador: ${solicitudAdministrador.inmuebleVendido.usuarioComprador.nombres} ${solicitudAdministrador.inmuebleVendido.usuarioComprador.apellidos}"),
          Text("Email del vendedor: ${inmuebleTotal.creador.correo}"),
          Text("Nombres del vendedor: ${inmuebleTotal.creador.nombres} ${inmuebleTotal.creador.apellidos}"),
        ],
      ),
    );
  }
}