import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
class InmuebleEtiqueta extends StatefulWidget {
  InmuebleEtiqueta({Key? key,required this.inmuebleTotal}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  @override
  _InmuebleEtiquetaState createState() => _InmuebleEtiquetaState();
}

class _InmuebleEtiquetaState extends State<InmuebleEtiqueta> {
  
  @override
  Widget build(BuildContext context) {
    final UsuariosInfo usuario=Provider.of<UsuariosInfo>(context);
    return Transform.rotate(
      angle: widget.inmuebleTotal.inmueble.estadoNegociacion=="Vendido"?-2.3:0,
      child: Container( 
        child: Column(
            children:[
              Expanded(
                flex:1,
                child: Container(
                  width: 20,
                  color:Colors.transparent,
                ),
              ),
              Expanded(
                flex:7,
                child: usuario.tipoSesion=="Administrar"?wigetEtiquetaAdministrador(widget.inmuebleTotal):wigetEtiquetaComun(widget.inmuebleTotal),
              ),
              Expanded(
                flex:1,
                child: Container(
                  color:Colors.transparent,
                  width: 20,
                ),
              )
            ]
          ),
      ),
    );
  }
  Widget wigetEtiquetaAdministrador(InmuebleTotal inmuebleTotal){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight:Radius.circular(10),
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(10)),
          gradient:gradientAdministrador(widget.inmuebleTotal.getSolicitudAdministrador.tipoSolicitud),
      ),
      width: 20,
      child: RotatedBox(
        quarterTurns: 1,
        child: Text(widget.inmuebleTotal.getSolicitudAdministrador.tipoSolicitud,
        textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            color: Colors.white
          ),
        ),
      ),
    );
  }
  Widget wigetEtiquetaComun(InmuebleTotal inmuebleTotal){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight:Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
          gradient:gradientComun(inmuebleTotal.getInmueble.getEstadoNegociacion),
      ),
      width: 30,
      child: RotatedBox(
        quarterTurns: 1,
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [Text(widget.inmuebleTotal.getInmueble.getEstadoNegociacion,
            textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.white
              ),
            ),
            ]
          ),
        ),
      ),
    );
  }
  LinearGradient gradientAdministrador(String tipoSolicitud){
    if(tipoSolicitud=="Dar Alta"){
      return LinearGradient(colors: [Colors.green,Colors.greenAccent]);
    }else if(tipoSolicitud=="Dar Baja"){
      return LinearGradient(colors: [Colors.red,Colors.redAccent]);
    }else if(tipoSolicitud=="Venta"){
      return LinearGradient(colors: [Colors.blue,Colors.blue]);
    }
    return LinearGradient(colors: [Colors.blue,Colors.blue]);
  }
  LinearGradient gradientComun(String estadoInmueble){
    if(estadoInmueble=="Sin negociar"){
      return LinearGradient(colors: [Colors.grey,Colors.grey]);
    }else if(estadoInmueble=="Negociación inicial"){
      return LinearGradient(colors: [Colors.lightGreen,Colors.lightGreenAccent]);
    }else if(estadoInmueble=="Negociación avanzada"){
      return LinearGradient(colors: [Colors.green,Colors.greenAccent]);
    }else if(estadoInmueble=="Vendido"){
      return LinearGradient(colors: [Colors.red,Colors.redAccent]);
    }
    return LinearGradient(colors: [Colors.blue,Colors.blue]);
  }
}