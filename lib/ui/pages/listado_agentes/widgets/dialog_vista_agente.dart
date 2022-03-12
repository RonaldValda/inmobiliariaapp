import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/usuario.dart';
import 'package:inmobiliariaapp/widgets/estrellas_calificacion.dart';

Future dialogVistaAgente(
  BuildContext context,
  Usuario agente
)async{
 return await showDialog(
    barrierLabel: "",
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(24, 10, 24, 0),
            title: Center(child: Text("Agente inmobiliario",style: TextStyle(fontSize: 20)),),
            children: [
              Container(
                padding: EdgeInsets.all(5),
                child: Column(
                  children:[
                    SizedBox(height:10),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nombres: ${agente.nombres}"),
                          Text("Apellidos: ${agente.apellidos}"),
                          Text("Email: ${agente.correo}"),
                          Text("Teléfono: ${agente.numeroTelefono}"),
                          Text("Agencia inmobiliaria: ${agente.nombreAgencia}"),
                          Text("Página web: ${agente.web}"),
                          Text("Calificación: ${agente.getCalificacion}"),
                          Row(
                            children: [
                              EstrellasCalificacionPorcentaje(puntajeTotal: agente.getCalificacion),
                              SizedBox(width:15),
                              Text("${agente.cantidadInmueblesCalificados} vendidos"),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 5,),
                    
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