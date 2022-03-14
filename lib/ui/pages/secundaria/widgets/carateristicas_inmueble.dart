
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:provider/provider.dart';
class CaracteristicasInmueble extends StatefulWidget {
  CaracteristicasInmueble({Key? key}) : super(key: key);

  @override
  _CaracteristicasInmuebleState createState() => _CaracteristicasInmuebleState();
}

class _CaracteristicasInmuebleState extends State<CaracteristicasInmueble> {
  double heightContainer=0;
  double widthContainer=0;
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    //heightContainer=MediaQuery.of(context).size.height-(MediaQuery.of(context).size.width*0.8);
    //heightContainer=100;
    return Container(
      //color: Colors.accents.elementAt(10),
      //color: Colors.red,
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      width: MediaQuery.of(context).size.width,
      //height: heightContainer,
      child: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            //height: 500,
            child: Column(
              children: [
                CaracteristicaInmuebleItem(
                  numero: 2, 
                  titulo: "Generales", 
                  onTap: (){
                    if(inmuebleInfo.caracteristicaSeleccionada==2){
                      inmuebleInfo.setCaracteristicaSeleccionada(-1);
                    }else{
                      inmuebleInfo.setCaracteristicaSeleccionada(2);
                    }
                  }
                ),
                CaracteristicaInmuebleItem(
                  numero: 0, 
                  titulo: "Internas", 
                  onTap: (){
                    if(inmuebleInfo.caracteristicaSeleccionada==0){
                      inmuebleInfo.setCaracteristicaSeleccionada(-1);
                    }else{
                      inmuebleInfo.setCaracteristicaSeleccionada(0);
                    }
                  }
                ),
                CaracteristicaInmuebleItem(
                  numero: 1, 
                  titulo: "Comunidad", 
                  onTap: (){
                    if(inmuebleInfo.caracteristicaSeleccionada==1){
                      inmuebleInfo.setCaracteristicaSeleccionada(-1);
                    }else{
                      inmuebleInfo.setCaracteristicaSeleccionada(1);
                    }
                  }
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class CaracteristicaInmuebleItem extends StatefulWidget {
  CaracteristicaInmuebleItem({Key? key,
  required this.numero,
  required this.titulo,
  required this.onTap
  }) : super(key: key);
  final int numero;
  final String titulo;
  final VoidCallback onTap;
  @override
  _CaracteristicaInmuebleItemState createState() => _CaracteristicaInmuebleItemState();
}

class _CaracteristicaInmuebleItemState extends State<CaracteristicaInmuebleItem> {
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: inmuebleInfo.caracteristicaSeleccionada==widget.numero?Colors.lightBlue.withOpacity(0.1):Colors.transparent,
        border: widget.numero>0?
            Border.symmetric(horizontal: BorderSide(color: Colors.black45,width: 0.5)):
            Border(top: BorderSide(color: Colors.black45,width: 0.5))
      ),
      //color: Colors.cyan,
      height: MediaQuery.of(context).size.height<960?50:60,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Text(widget.titulo,
                style: GoogleFonts.aladin(
                  textStyle:TextStyle(fontSize: 20,)
                ),
              ),
            ),
            Icon(Icons.check),
          ],
        ),
        onTap: widget.onTap,
      ),
    );
  }
}
/*
ListTile(
            selectedTileColor: Colors.lightBlue.withOpacity(0.1),
            
            //selected: inmuebleInfo.caracteristicaSeleccionada==widget.numero,
            title: Text(widget.titulo),
            trailing: Icon(Icons.check),
            onTap: widget.onTap,
          ),

*/