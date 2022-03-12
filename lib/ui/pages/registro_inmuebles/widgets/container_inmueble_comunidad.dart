import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
class ContainerInmuebleComunidad extends StatefulWidget {
  ContainerInmuebleComunidad({Key? key}) : super(key: key);
  @override
  _ContainerInmuebleComunidadState createState() => _ContainerInmuebleComunidadState();
}

class _ContainerInmuebleComunidadState extends State<ContainerInmuebleComunidad> {
  TextEditingController? controllerDetallesComunidad;
  @override
  void initState() {
    super.initState();
    controllerDetallesComunidad=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(controllerDetallesComunidad!.text==""){
      controllerDetallesComunidad!.text=inmuebleInfo.getInmuebleTotalCopia.inmuebleComunidad.detallesComunidad;
    }
    return Container(
      //width: 400,
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height/1.6,
      
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/3,
      child: Column(
          children: [
            Expanded(child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Iglesia",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.iglesia, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.iglesia=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Parque infantil",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.parqueInfantil, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.parqueInfantil=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Escuela",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.escuela, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.escuela=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Universidad",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.universidad, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.universidad=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Plazuela",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.plazuela, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.plazuela=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Módulo policial",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.moduloPolicial, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.moduloPolicial=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Sauna / piscina pública",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.saunaPiscinaPublica, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.saunaPiscinaPublica=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Gym público",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.gymPublico, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.gymPublico=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Centro deportivo",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.centroDeportivo, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.centroDeportivo=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Puesto salud",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.puestoSalud, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.puestoSalud=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text("Zona comercial",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.zonaComercial, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleComunidad.zonaComercial=value;
                    });
                  }
                ),
                SizedBox(
                  height: 5,
                ),
                TextFFBasico(
                  controller: controllerDetallesComunidad!, 
                  labelText: "Detalles", 
                  onChanged: (x){
                    inmuebleInfo.inmuebleTotalCopia.inmuebleComunidad.detallesComunidad=x;
                  }
                ),
              ],
            ),)
          ],
      ),
    );
  }
}