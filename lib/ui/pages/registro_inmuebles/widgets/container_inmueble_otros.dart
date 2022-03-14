import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
class ContainerInmuebleOtros extends StatefulWidget {
  ContainerInmuebleOtros({Key? key
  }) : super(key: key);
  
  @override
  _ContainerInmuebleOtrosState createState() => _ContainerInmuebleOtrosState();
}

class _ContainerInmuebleOtrosState extends State<ContainerInmuebleOtros> {
  TextEditingController? controllerImagenes2D;
  TextEditingController? controllerVideo2D;
  TextEditingController? controllerTourVirtual360;
  TextEditingController? controllerVideoTour360;
  TextEditingController? controllerDetallesOtros;
  @override
  void initState() {
    super.initState();
    controllerImagenes2D=TextEditingController(text: "");
    controllerVideo2D=TextEditingController(text: "");
    controllerTourVirtual360=TextEditingController(text: "");
    controllerVideoTour360=TextEditingController(text: "");
    controllerDetallesOtros=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(controllerImagenes2D!.text==""){
      controllerImagenes2D!.text=inmuebleInfo.inmuebleTotal.inmueblesOtros.imagenes2DLink;
      controllerVideo2D!.text=inmuebleInfo.inmuebleTotal.inmueblesOtros.video2DLink;
      controllerTourVirtual360!.text=inmuebleInfo.inmuebleTotal.inmueblesOtros.tourVirtual360Link;
      controllerVideoTour360!.text=inmuebleInfo.inmuebleTotal.inmueblesOtros.videoTour360Link;
      controllerDetallesOtros!.text=inmuebleInfo.inmuebleTotal.inmueblesOtros.detallesOtros;
    }
    return Container(
      //height: MediaQuery.of(context).size.height/1.6,
      padding: EdgeInsets.all(5),
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/3,
      child: Column(
          children: [
            Expanded(child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Remates judiciales",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleOtros.rematesJudiciales, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleOtros.rematesJudiciales=value;
                    });
                  }
                ),
                TextFFBasico(
                  controller: controllerImagenes2D!, 
                  labelText: "Imágenes 2D (Link)", 
                  onChanged: (x){
                    if(inmuebleInfo.inmuebleTotalCopia.inmueble.categoria.toUpperCase()=="PRO360")
                      inmuebleInfo.inmuebleTotal.inmueblesOtros.imagenes2DLink=x;
                    else {
                      inmuebleInfo.inmuebleTotal.inmueblesOtros.imagenes2DLink="";
                      controllerImagenes2D!.text="";
                    }
                  }
                ),
                SizedBox(
                  height: 5,
                ),
                TextFFBasico(
                  controller: controllerVideo2D!, 
                  labelText: "Vídeo 2D (Link)", 
                  onChanged: (x){
                    if(inmuebleInfo.inmuebleTotalCopia.inmueble.categoria.toUpperCase()=="PRO360")
                      inmuebleInfo.inmuebleTotal.inmueblesOtros.video2DLink=x;
                    else {
                      inmuebleInfo.inmuebleTotal.inmueblesOtros.video2DLink=x;
                      controllerVideo2D!.text="";
                    }
                  }
                ),
                SizedBox(
                  height: 5,
                ),
                TextFFBasico(
                  controller: controllerTourVirtual360!, 
                  labelText: "Tour virtual 360 (Link)", 
                  onChanged: (x){
                    if(inmuebleInfo.inmuebleTotalCopia.inmueble.categoria.toUpperCase()=="PRO360")
                      inmuebleInfo.inmuebleTotal.inmueblesOtros.tourVirtual360Link=x;
                    else {
                      inmuebleInfo.inmuebleTotal.inmueblesOtros.tourVirtual360Link=x;
                      controllerTourVirtual360!.text="";
                    }
                  }
                ),
                SizedBox(
                  height: 5,
                ),
                TextFFBasico(
                  controller: controllerVideoTour360!, 
                  labelText: "Vídeo tour 360 (Link)", 
                  onChanged: (x){
                    if(inmuebleInfo.inmuebleTotalCopia.inmueble.categoria.toUpperCase()=="PRO360")
                      inmuebleInfo.inmuebleTotal.inmueblesOtros.videoTour360Link=x;
                    else {
                      inmuebleInfo.inmuebleTotal.inmueblesOtros.videoTour360Link=x;
                      controllerVideoTour360!.text="";
                    }
                  }
                ),
                SizedBox(
                  height: 5,
                ),
                TextFFBasico(
                  controller: controllerDetallesOtros!, 
                  labelText: "Detalles", 
                  onChanged: (x){
                    inmuebleInfo.inmuebleTotal.inmueblesOtros.detallesOtros=x;
                  }
                ),
              ],
            ),)
          ],
      ),
    );
  }
}