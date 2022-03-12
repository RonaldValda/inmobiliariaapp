import 'package:flutter/material.dart';
class EstrellasCalificacion extends StatelessWidget {
  const EstrellasCalificacion({Key? key,required this.cantidadEstrellas}) : super(key: key);
  final int cantidadEstrellas;
 
  @override 
  Widget build(BuildContext context) {
    Color color=Color.fromRGBO(255, 186, 14, 1);
    return Container(
      //color: Colors.black12,
      child: Row(
        children: [
          
          cantidadEstrellas>0?Icon(Icons.star,color: color,):Icon(Icons.star_border,color: color,),
          cantidadEstrellas>1?Icon(Icons.star,color: color,):Icon(Icons.star_border,color: color,),
          cantidadEstrellas>2?Icon(Icons.star,color: color,):Icon(Icons.star_border,color: color,),
          cantidadEstrellas>3?Icon(Icons.star,color: color,):Icon(Icons.star_border,color: color,),
          cantidadEstrellas>4?Icon(Icons.star,color: color,):Icon(Icons.star_border,color: color,),
        ],
      )
    );
  }
}
class EstrellasCalificacionPorcentaje extends StatelessWidget {
  const EstrellasCalificacionPorcentaje({Key? key,required this.puntajeTotal}) : super(key: key);
  final double puntajeTotal;
 
  @override 
  Widget build(BuildContext context) {
    Color color=Color.fromRGBO(255, 186, 14, 1);
    return Container(
      //color: Colors.black12,
      child: Row(
        children: [
          
          puntajeTotal>0?
          ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds)=>LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [puntajeTotal-0,1-(puntajeTotal-0)],
              colors: [color,Colors.grey]).createShader(bounds),
            child: Icon(Icons.star,),
          ):
          Icon(Icons.star,color: Colors.grey,),
          
          puntajeTotal>1?ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds)=>LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [puntajeTotal-1,1-(puntajeTotal-1)],
              colors: [color,Colors.grey]).createShader(bounds),
            child: Icon(Icons.star,),
          ):Icon(Icons.star,color: Colors.grey,),
          puntajeTotal>2?ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds)=>LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [puntajeTotal-2,1-(puntajeTotal-2)],
              colors: [color,Colors.grey]).createShader(bounds),
            child: Icon(Icons.star,),
          ):Icon(Icons.star,color: Colors.grey,),
          puntajeTotal>3?ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds)=>LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [puntajeTotal-3,1-(puntajeTotal-3)],
              colors: [color,Colors.grey]).createShader(bounds),
            child: Icon(Icons.star,),
          ):Icon(Icons.star,color: Colors.grey,),
          puntajeTotal>4?ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds)=>LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: [puntajeTotal-4,1-(puntajeTotal-4)],
              colors: [color,Colors.grey]).createShader(bounds),
            child: Icon(Icons.star,),
          ):Icon(Icons.star,color: Colors.grey,),
        ],
      )
    );
  }
}