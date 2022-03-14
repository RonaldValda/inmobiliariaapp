import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/inmueble_item/inmueble_item_imagenes.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
class InmuebleItemEncabezado extends StatefulWidget {
  final InmuebleTotal inmuebleTotal;
  final int index;
  InmuebleItemEncabezado({Key? key,required this.inmuebleTotal,required this.index}) : super(key: key);

  @override
  _InmuebleItemEncabezadoState createState() => _InmuebleItemEncabezadoState();
}

class _InmuebleItemEncabezadoState extends State<InmuebleItemEncabezado> {
  double width=0;
  bool modoVertical=false;
  @override
  Widget build(BuildContext context) {
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    final usuario=Provider.of<UsuariosInfo>(context);
    if(_estadoWidgets.isVerMapa){
      width=250;
      modoVertical=true;
    }else{
      if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
        width=MediaQuery.of(context).size.width;
        modoVertical=true;
      }else{
        width=MediaQuery.of(context).size.width*0.6;
        modoVertical=false;
      }
    }
    
    return Container(
      //color: Colors.amber,
      padding: modoVertical?EdgeInsets.only(bottom: 0):EdgeInsets.only(bottom: 15),
       child: Column(
         children: [
            Container(
              width: width,
              color:Colors.transparent,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      usuario.tipoSesion=="Administrar"?Container(
                        padding:EdgeInsets.only(left: 15,right: 5,),
                        child: Text(
                          widget.inmuebleTotal.getSolicitudAdministrador.respuesta==""?"Pendiente":widget.inmuebleTotal.getSolicitudAdministrador.respuesta,
                          style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.w600),
                        ),
                        decoration: BoxDecoration(
                          color:Colors.cyan[100],
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
                          
                        ),
                      ):
                      usuario.tipoSesion=="Supervisar"?Container(
                        padding:EdgeInsets.only(left: 15,right: 5,),
                        child: Text(
                          widget.inmuebleTotal.getSolicitudAdministrador.respuestaSuperUsuario==""?"Pendiente":widget.inmuebleTotal.getSolicitudAdministrador.respuestaSuperUsuario,
                          style: TextStyle(color: Colors.red[900],fontWeight: FontWeight.w600),
                        ),
                        decoration: BoxDecoration(
                          color:Colors.cyan[100],
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
                          
                        ),
                      )
                      :
                      usuario.tipoSesion=="Vender"?Container(
                        padding:EdgeInsets.only(left: 15,right: 5,),
                        child: Text(
                          widget.inmuebleTotal.getInmueble.getAutorizacion,
                          style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.w600),
                        ),
                        decoration: BoxDecoration(
                          color:Colors.cyan[100],
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),topRight: Radius.circular(20)),
                        ),
                      ):Container(),
                      usuario.tipoSesion=="Comprar"?Container(
                        padding:EdgeInsets.only(left: 15,right: 5,),
                        child: widget.inmuebleTotal.creador.verificado?Text(widget.inmuebleTotal.creador.nombreAgencia!=""?
                          "${widget.inmuebleTotal.creador.nombreAgencia} -> Verificado":"${widget.inmuebleTotal.creador.nombres} ${widget.inmuebleTotal.creador.apellidos} -> Verificado",
                          style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.w600),
                        ):Text("No verificado",
                          style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.w600),
                        ),
                      ):Container(),
                      
                      Container(
                        child:Row(
                          children: [
                            Text(widget.inmuebleTotal.getCreador.getNombreAgencia,style: TextStyle(color: Colors.black,fontSize: 15),),
                            SizedBox(
                              width:10
                            )
                          ],
                        )
                      )
                      
                    ],
                  ),
                  InmuebleItemImagenes(inmuebleTotal: widget.inmuebleTotal,index: widget.index),
                ],
              ),
            ),
         ],
       ),
    );
  }
}