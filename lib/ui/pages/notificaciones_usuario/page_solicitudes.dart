import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/pages/home/widgets/item_property/item_property.dart';
import 'package:inmobiliariaapp/ui/pages/notificaciones_usuario/widgets/dialog_calificar_vendedor.dart';
import '../../../domain/usecases/user/usecase_user.dart';
class PageSolicitudesUsuario extends StatefulWidget {
  PageSolicitudesUsuario({Key? key,required this.inmueblesTotal}) : super(key: key);
  final List<PropertyTotal> inmueblesTotal;
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
              var propertyTotal=widget.inmueblesTotal[i];
              
              if(widget.inmueblesTotal.elementAt(i).administratorRequest.requestType=="Calificar"){
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      CalificarVendedor(inmuebleTotal: propertyTotal,),
                      ItemProperty(propertyTotal:propertyTotal,index:i),
                    ],
                  ),
                );
              }
              return Container(
                child: Column(
                  children: [
                    ItemProperty(propertyTotal: propertyTotal,index: i,),
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
  final PropertyTotal inmuebleTotal;
  @override
  _CalificarVendedorState createState() => _CalificarVendedorState();
}

class _CalificarVendedorState extends State<CalificarVendedor> {
  UseCaseUser useCaseUsuario=UseCaseUser();
  @override
  Widget build(BuildContext context) {
    return !widget.inmuebleTotal.administratorRequest.requestFinished? 
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
                    useCaseUsuario.answerUserQualificationRequest(widget.inmuebleTotal.administratorRequest.id, widget.inmuebleTotal.property.qualification)
                    .then((resultado){
                      if(resultado["completado"]){
                        widget.inmuebleTotal.administratorRequest.requestFinished=true;
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
