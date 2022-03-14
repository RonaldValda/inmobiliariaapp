import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/provider/estado_widgets.dart';
import 'package:inmobiliariaapp/ui/provider/lista_inmuebles_filtrado.dart';
import 'package:inmobiliariaapp/ui/provider/mapa_filtro_internas_info.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' as iconc;
class PiePagina2 extends StatefulWidget {
  final InmuebleTotal inmuebleTotal;
  final int index;
  PiePagina2({Key? key,required this.inmuebleTotal,required this.index}) : super(key: key);

  @override
  _PiePagina2State createState() => _PiePagina2State();
}

class _PiePagina2State extends State<PiePagina2> {
   bool mostrarIcono=false;
   double sizeTexto1=12;
   double sizeTexto2=11;
  @override
  Widget build(BuildContext context) {
    final _estadoWidgets=Provider.of<EstadoWidgets>(context);
    double heightInfo=0;
    double widthInfo=0;
    final _inmueblesFiltrado=Provider.of<ListadoInmueblesFiltrado>(context);
    final _mapaFiltroInternas=Provider.of<MapaFiltroInternasInfo>(context);
    
    //print("priamero");
    //print(widget.inmuebleTotal.getInmueble.getHistorialPrecios);
    return Container(
      //color: Colors.red,
      padding: EdgeInsets.fromLTRB(10, 5, 5, 5),
       child: Row(
         //crossAxisAlignment: CrossAxisAlignment.start,
         mainAxisAlignment:MainAxisAlignment.spaceBetween,
         children: [
           Container(
             //width: widthInfo,
             //height: heightInfo,
             //color: Colors.amber,
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 Align(
                   alignment: Alignment.centerLeft,
                   child: 
                   widgetPrecios()
                 ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Wrap(
                    verticalDirection: VerticalDirection.down,
                    children: [
                      Text("${widget.inmuebleTotal.getInmuebleInternas.getDormitorios.toString()} ",
                        style: TextStyle(fontSize: sizeTexto1,fontWeight: FontWeight.w600)
                      ),
                      Tooltip(
                        showDuration: Duration(seconds: 1),
                        waitDuration: Duration(milliseconds: 10),
                        message: "Dormitorios",
                        child: iconc.FaIcon(iconc.FontAwesomeIcons.bed,size:sizeTexto1),
                      ),
                      
                      Text(" | ${(widget.inmuebleTotal.inmueble.precio/widget.inmuebleTotal.inmueble.superficieTerreno).floor()} ",
                        style: TextStyle(fontSize: sizeTexto1,fontWeight: FontWeight.w600)
                      ),
                      Tooltip(
                        showDuration: Duration(seconds: 1),
                        waitDuration: Duration(milliseconds: 10),
                        message: "Dólares por metro cuadrado",
                        child: Text("DPM",
                          style: TextStyle(
                            fontSize: sizeTexto1,fontWeight: FontWeight.w600
                          ),
                        ),
                      ),
                      Text(" | ${widget.inmuebleTotal.getInmueble.getSuperficieTerreno.toString()}m2 ",
                        style: TextStyle(fontSize: sizeTexto1,fontWeight: FontWeight.w600)
                      ),
                      Tooltip(
                        showDuration: Duration(seconds: 1),
                        waitDuration: Duration(milliseconds: 10),
                        message: "Superficie terreno",
                        child: iconc.FaIcon(iconc.FontAwesomeIcons.vectorSquare,size: sizeTexto1),
                      ),
                    ],
                  ),
                ),
                
                Row(
                  children: [
                    Text(
                      "${widget.inmuebleTotal.getInmueble.direccion} |${widget.inmuebleTotal.getInmueble.nombreZona} |${widget.inmuebleTotal.getInmueble.getCiudad}",
                      style: TextStyle(fontSize: sizeTexto2,fontStyle: FontStyle.italic)
                    ),
                    
                  ],
                ),
               ],
             ),
           ),
         ],
       )
    );
  }

  Wrap widgetPrecios() {
    //print(widget.inmuebleTotal.getInmueble.getHistorialPrecios);
    return Wrap(
      verticalDirection: VerticalDirection.down,
      direction: Axis.vertical,
      children: [
        widget.inmuebleTotal.getInmueble.getHistorialPrecios.length>1?
        (widget.inmuebleTotal.getInmueble.getHistorialPrecios[widget.inmuebleTotal.getInmueble.getHistorialPrecios.length-1]<
        widget.inmuebleTotal.getInmueble.getHistorialPrecios[widget.inmuebleTotal.getInmueble.getHistorialPrecios.length-2]?
        Row(
          children: [
            Text(
            "${widget.inmuebleTotal.getInmueble.getHistorialPrecios[widget.inmuebleTotal.getInmueble.getHistorialPrecios.length-1].toString()}"+r"$",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(width: 10,),
            Text(
            "${widget.inmuebleTotal.getInmueble.getHistorialPrecios[widget.inmuebleTotal.getInmueble.getHistorialPrecios.length-2].toString()}"+r"$",
              style: TextStyle(
                fontSize: 15,
                color: Colors.red,
                fontStyle: FontStyle.italic,
                fontFamily: "fonts/Schyler-Regular.ttf",
                decoration:TextDecoration.lineThrough,
                decorationThickness: 2,                     
                decorationColor: Colors.red
              ),  
            ),
            
            
          ],
        )
        :
        Text(
          "${widget.inmuebleTotal.getInmueble.getPrecio.toString()}"+r"$",
          style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              )
        )
        ):Text(
          "${widget.inmuebleTotal.getInmueble.getPrecio.toString()}"+r"$",
          style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              )  
        ),
      ],
    );
  }
}