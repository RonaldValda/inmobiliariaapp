import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
class LabelProperty extends StatefulWidget {
  LabelProperty({Key? key,required this.propertyTotal}) : super(key: key);
  final PropertyTotal propertyTotal;
  @override
  _LabelPropertyState createState() => _LabelPropertyState();
}

class _LabelPropertyState extends State<LabelProperty> {
  
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: widget.propertyTotal.property.negotiationStatus=="Vendido"?-2.3:0,
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
              child: 
              //usuario.sessionType=="Administrar"?_wLabelAdministrator(widget.propertyTotal):
              _wLabelCommon(widget.propertyTotal),
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
  Widget _wLabelCommon(PropertyTotal propertyTotal){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight:Radius.circular(10),
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10)),
          gradient:gradientComun(propertyTotal.property.negotiationStatus),
      ),
      width: 30*SizeDefault.scaleWidth,
      child: RotatedBox(
        quarterTurns: 1,
        child: Align(
          alignment: Alignment.center,
          child: Wrap(
            children: [
              TextStandard(
                text: propertyTotal.property.negotiationStatus, 
                fontSize: SizeDefault.fSizeStandard,
                fontWeight: FontWeight.w500,
                color: ColorsDefault.colorBackgroud,
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
    }else if(tipoSolicitud=="Vendido"){
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