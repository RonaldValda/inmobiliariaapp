
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
class ContainerInmuebleImagenes extends StatefulWidget {
  ContainerInmuebleImagenes({Key? key,
    required this.imagenesExteriores,required this.imagenesDormitorios,required this.imagenesBanios,
    required this.imagenesGaraje,required this.imagenesDependencias,required this.imagenesPrincipales,
    required this.imagenesHall,required this.imagenesJardin,required this.uploading
  }) : super(key: key);
  final List<dynamic> imagenesExteriores;
  final List<dynamic> imagenesDormitorios;
  final List<dynamic> imagenesBanios;
  final List<dynamic> imagenesGaraje;
  final List<dynamic> imagenesDependencias;
  final List<dynamic> imagenesPrincipales;
  final List<dynamic> imagenesHall;
  final List<dynamic> imagenesJardin;
  final bool uploading;
  @override
  _ContainerInmuebleImagenesState createState() => _ContainerInmuebleImagenesState();
}

class _ContainerInmuebleImagenesState extends State<ContainerInmuebleImagenes> {
  bool exterioresSeleccionado=false;
  bool dormitoriosSeleccionado=false;
  final picker=ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Container(
       //color: Colors.amber[200],
       padding: EdgeInsets.all(5),
       height: MediaQuery.of(context).size.height/1.6,
       child: Column(
         children: [
           Expanded(
             child: ListView(
               children: [
                 Column(
                   children: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                        Text("Principales",
                          style: TextStyle(fontSize: 20,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500),
                        ),
                        Text("(Obligatorio, como mínimo uno)",
                          style: TextStyle(fontSize: 12,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500),
                        )
                      ],
                     ),
                   ],
                 ),
               ],
             ),
           ),
         ],
       ),
    );
  }
}