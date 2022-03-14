import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/pages/secundaria/widgets/inmueble_item_imagenes2.dart';
class InmuebleItemEncabezado2 extends StatefulWidget {
  InmuebleItemEncabezado2({Key? key,required this.inmuebleTotal,required this.width,required this.height}) : super(key: key);
  final InmuebleTotal inmuebleTotal;
  final double width;
  final double height;
  @override
  _InmuebleItemEncabezado2State createState() => _InmuebleItemEncabezado2State();
}

class _InmuebleItemEncabezado2State extends State<InmuebleItemEncabezado2> {
  double imagenHeight=0;
  double imagenWidth=0;
  bool isVertical=true;
  @override
  Widget build(BuildContext context) {
    if(MediaQuery.of(context).size.height>MediaQuery.of(context).size.width){
      isVertical=true;
      imagenWidth=MediaQuery.of(context).size.width;
      imagenHeight=imagenWidth*0.7;
    }else{
      isVertical=false;
      imagenHeight=MediaQuery.of(context).size.height*.8;
      imagenWidth=imagenHeight+imagenHeight*0.3;
    }
    return Container(
      //color: Colors.amber,
      padding: EdgeInsets.only(bottom: 0),
       child: Column(
         children: [
            Container(
              width: widget.width,
              color:Colors.transparent,
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [Container(
                        padding:EdgeInsets.only(left: 15,right: 5,),
                        child: widget.inmuebleTotal.creador.verificado?Text(widget.inmuebleTotal.creador.nombreAgencia!=""?
                          "${widget.inmuebleTotal.creador.nombreAgencia} -> Verificado":"${widget.inmuebleTotal.creador.nombres} ${widget.inmuebleTotal.creador.apellidos} -> Verificado",
                          
                          style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.w600,fontSize: 12),
                        ):Text("No verificado",
                          
                          style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.w600,fontSize: 12),
                        ),
                      ),
                      
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
                  InmuebleItemImagenes2(inmuebleTotal: widget.inmuebleTotal,width: widget.width,height: widget.height,),
                ],
              ),
            ),
         ],
       ),
    );
  }
}