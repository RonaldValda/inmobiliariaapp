import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/notificaciones_usuario/widgets/dialog_calificar_vendedor.dart';
import 'package:inmobiliariaapp/ui/pages/principal/widgets/inmueble_item/inmueble_item.dart';
class PageSolicitudesUsuario extends StatefulWidget {
  PageSolicitudesUsuario({Key? key,required this.inmueblesTotal}) : super(key: key);
  final List<InmuebleTotal> inmueblesTotal;
  @override
  _PageSolicitudesUsuarioState createState() => _PageSolicitudesUsuarioState();
}

class _PageSolicitudesUsuarioState extends State<PageSolicitudesUsuario> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Solicitudes"),
      ),
      body: Container(
        child: ListView.builder(
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            cacheExtent: 10,
            scrollDirection: Axis.vertical,
            itemCount: widget.inmueblesTotal.length,
            dragStartBehavior: DragStartBehavior.down,
            itemBuilder:(_,i){
              var inmueble=widget.inmueblesTotal[i];
              
              if(widget.inmueblesTotal.elementAt(i).getSolicitudAdministrador.tipoSolicitud=="Calificar"){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CalificarVendedor(inmuebleTotal: inmueble,),
                      InmuebleItem(inmuebleTotal:inmueble,index:i),
                    ],
                  ),
                );
              }
              return Container(
                child: Column(
                  children: [
                    InmuebleItem(inmuebleTotal: inmueble,index: i,),
                    SizedBox(height: 10,)
                  ],
                ),
              );
            },
          ),
      ),
       
        );
  }
}
class CalificarVendedor extends StatefulWidget {
  const CalificarVendedor({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _CalificarVendedorState createState() => _CalificarVendedorState();
}

class _CalificarVendedorState extends State<CalificarVendedor> {
  UseCaseUsuario useCaseUsuario=UseCaseUsuario();
  @override
  Widget build(BuildContext context) {
    return !widget.inmuebleTotal.getSolicitudAdministrador.solicitudTerminada? 
      Container(
        //height: 60,
        //color: Colors.black26,
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Row(
              children: [
                Text("Se solicita calificar al vendedor de su inmueble")
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:[
                Text("Tiempo restante: 7 días"),
                ElevatedButton(onPressed: ()async{
                  String respuesta=await dialogCalificarVendedor(context,widget.inmuebleTotal);
                  if(respuesta=="Aceptar"){
                    useCaseUsuario.responderSolicitudUsuarioCalificacion(widget.inmuebleTotal.getSolicitudAdministrador.id, widget.inmuebleTotal.getInmueble.calificacion)
                    .then((resultado){
                      if(resultado["completado"]){
                        widget.inmuebleTotal.getSolicitudAdministrador.solicitudTerminada=true;
                        setState(() { 
                        
                        });
                      }
                    });
                  }
                  
                }, 
                child: Text("Calificar Ahora"))
              ]
              
            )
          ],
        ),
      ):Container();
  }
}
