import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:provider/provider.dart';
import 'inmueble_item_encabezado.dart';
import 'inmueble_item_pie_pagina.dart';
class InmuebleItem extends StatefulWidget {
  final InmuebleTotal inmuebleTotal;
  final int index;
  InmuebleItem({Key? key,required this.inmuebleTotal,required this.index}) : super(key: key);

  @override
  _InmuebleItemState createState() => _InmuebleItemState();
}

class _InmuebleItemState extends State<InmuebleItem> {
  bool modoVertical=false;
  @override
  Widget build(BuildContext context) {
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    if(_estadoWidgets.isVerMapa){
      modoVertical=true;
    }else{
      if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
        modoVertical=true;
      }else{
        modoVertical=false;
      }
    }
    
    return Card(
      semanticContainer: true,
      borderOnForeground: false,
      elevation: 2,
      margin: EdgeInsets.all(5),
      shadowColor:  widget.inmuebleTotal.inmueble.categoria=="Pro360"?Color.fromRGBO(212, 175, 55, 1):widget.inmuebleTotal.inmueble.categoria=="Pro"?Colors.blue.withOpacity(0.5):Colors.grey.withOpacity(0.4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: widget.inmuebleTotal.inmueble.categoria=="Pro360"?Color.fromRGBO(212, 175, 55, 1):widget.inmuebleTotal.inmueble.categoria=="Pro"?Colors.blue.withOpacity(0.5):Colors.grey.withOpacity(0.4),
          width: 2,
          style: BorderStyle.solid
        )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:[
          Container(
            alignment: AlignmentDirectional.topCenter,
            margin: EdgeInsets.all(0),
            child: modoVertical?Column(
              children: [
                InmuebleItemEncabezado(inmuebleTotal: widget.inmuebleTotal,index: widget.index),
                PiePagina(inmuebleTotal: widget.inmuebleTotal,index: widget.index)
              ],
            ):Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                InmuebleItemEncabezado(inmuebleTotal: widget.inmuebleTotal,index: widget.index),
                PiePagina(inmuebleTotal: widget.inmuebleTotal,index: widget.index)
              ],
            ),
          ),
        ]
      ),
    );
  }
}


