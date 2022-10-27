import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';

Future<String> dialogCalificarVendedor(
  BuildContext context,
  PropertyTotal inmuebleTotal
)async{
  //TextEditingController _controller=TextEditingController();
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: const Center(child: Text("Calificando vendedor",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                width: 250,
                //height: 250,
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CalificarEstrellas(inmuebleTotal: inmuebleTotal),
                          Text(
                            "Se le asignará la calificación al vendedor",
                            style:TextStyle(
                              color:Colors.black54,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          Text(
                            "¿Desea continuar?",
                            style:TextStyle(
                              color:Colors.black54,
                              fontWeight: FontWeight.w600
                            )
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: (){
                            String respuesta="Aceptar";
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Aceptar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        ElevatedButton(
                          onPressed: (){
                            String respuesta="Cancelar";
                            Navigator.pop(context,respuesta);
                          }, 
                          child: Text("Cancelar"),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red
                          ),
                        ),
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
class CalificarEstrellas extends StatefulWidget {
  const CalificarEstrellas({Key? key,required this.inmuebleTotal}) : super(key: key);
  final PropertyTotal inmuebleTotal;
  @override
  _CalificarEstrellasState createState() => _CalificarEstrellasState();
}

class _CalificarEstrellasState extends State<CalificarEstrellas> {
  Color color=Color.fromRGBO(255, 186, 14, 1);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          IconButton(
            icon: widget.inmuebleTotal.property.qualification>=1 ?
            Icon(Icons.star,size: 30,color: color,):Icon(Icons.star_border,size: 30,color: color,),
            onPressed: (){
              if(widget.inmuebleTotal.property.qualification==1){
                widget.inmuebleTotal.property.qualification=0;
              }else{
                widget.inmuebleTotal.property.qualification=1;
              }
              setState(() {
                
              });
            },
          ),
          IconButton(
            icon: widget.inmuebleTotal.property.qualification>=2 ?
            Icon(Icons.star,size: 30,color: color,):Icon(Icons.star_border,size: 30,color: color,),
            onPressed: (){
              if(widget.inmuebleTotal.property.qualification==2){
                widget.inmuebleTotal.property.qualification=0;
              }else{
                widget.inmuebleTotal.property.qualification=2;
              }
              
              setState(() {
                
              });
            },
          ),
          IconButton(
            icon: widget.inmuebleTotal.property.qualification>=3 ?
            Icon(Icons.star,size: 30,color: color,):Icon(Icons.star_border,size: 30,color: color,),
            onPressed: (){
              if(widget.inmuebleTotal.property.qualification==3){
                widget.inmuebleTotal.property.qualification=0;
              }else{
                widget.inmuebleTotal.property.qualification=3;
              }
              setState(() {
                
              });
            },
          ),
          IconButton(
            icon: widget.inmuebleTotal.property.qualification>=4 ?
            Icon(Icons.star,size: 30,color: color,):Icon(Icons.star_border,size: 30,color: color,),
            onPressed: (){
              if(widget.inmuebleTotal.property.qualification==4){
                widget.inmuebleTotal.property.qualification=0;
              }else{
                widget.inmuebleTotal.property.qualification=4;
              }
              setState(() {
                
              });
            },
          ),
          IconButton(
            icon: widget.inmuebleTotal.property.qualification==5 ?
            Icon(Icons.star,size: 30,color: color,):Icon(Icons.star_border,size: 30,color: color,),
            onPressed: (){
              if(widget.inmuebleTotal.property.qualification==5){
                widget.inmuebleTotal.property.qualification=0;
              }else{
                widget.inmuebleTotal.property.qualification=5;
              }
              setState(() {
                
              });
            },
          ),
        ],
      ),
    );
  }
}