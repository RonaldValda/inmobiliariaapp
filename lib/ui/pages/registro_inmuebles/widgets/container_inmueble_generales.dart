import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/dropdown_ciudades.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/dropdown_tipo_contrato.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/dropdown_tipo_inmueble.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/inkwell_propietario.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/inkwell_zona.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
class ContainerInmuebleGenerales extends StatefulWidget {
  ContainerInmuebleGenerales({Key? key,
    }) : super(key: key);
  @override
  _ContainerInmuebleGeneralesState createState() => _ContainerInmuebleGeneralesState();
}

class _ContainerInmuebleGeneralesState extends State<ContainerInmuebleGenerales> {
  TextEditingController? controllerNombrePropietario;
  TextEditingController? controllerDireccion;
  TextEditingController? controllerSuperficieTerreno;
  TextEditingController? controllerSuperficieConstruccion;
  TextEditingController? controllerTamanioFrente;
  TextEditingController? controllerPrecio;
  TextEditingController? controllerTiempoConstruccion;
  TextEditingController? controllerNumeroDuenios;
  TextEditingController? controllerNumeroPisos;
  TextEditingController? controllerDetallesGenerales;
  @override
  void initState() {
    super.initState();
    controllerNombrePropietario= TextEditingController(text: "");
    controllerDireccion=TextEditingController(text: "");
    controllerPrecio=TextEditingController(text: "");
    controllerSuperficieTerreno=TextEditingController(text: "");
    controllerSuperficieConstruccion=TextEditingController(text: "");
    controllerTiempoConstruccion=TextEditingController(text: "");
    controllerTamanioFrente=TextEditingController(text: "");
    controllerNumeroDuenios=TextEditingController(text: "");
    controllerDetallesGenerales=TextEditingController(text: "");
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    //controllerDireccion!.value=TextEditingValue(text:"1234");
    if(controllerDireccion!.text==""){
    controllerDireccion!.text=inmuebleInfo.getInmuebleTotalCopia.getInmueble.direccion;
    controllerPrecio!.text=inmuebleInfo.getInmuebleTotalCopia.getInmueble.precio.toString();
    controllerSuperficieTerreno!.text=inmuebleInfo.getInmuebleTotalCopia.getInmueble.superficieTerreno.toString();
    controllerSuperficieConstruccion!.text=inmuebleInfo.getInmuebleTotalCopia.getInmueble.superficieConstruccion.toString();
     controllerTamanioFrente!.text=inmuebleInfo.getInmuebleTotalCopia.getInmueble.tamanioFrente.toString();
    controllerTiempoConstruccion!.text=inmuebleInfo.getInmuebleTotalCopia.getInmueble.antiguedadConstruccion.toString();
    controllerNumeroDuenios!.text=inmuebleInfo.getInmuebleTotalCopia.getInmueble.numeroDuenios.toString();
    controllerDetallesGenerales!.text=inmuebleInfo.getInmuebleTotalCopia.getInmueble.detallesGenerales;
    }
    return Container(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            //height: MediaQuery.of(context).size.height/1.6,
            child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      primary: false,
                      scrollDirection: Axis.vertical,
                      children: [
                        DropdownCiudades(),
                        DropdownTipoInmueble(),
                        DropdownTipoContrato(),
                        SizedBox(height:5),
                        TextFFBasico(
                          controller: controllerPrecio!, 
                          labelText: "Precio", 
                          onChanged: (x){
                            inmuebleInfo.getInmuebleTotalCopia.getInmueble.precio=int.parse(x);
                          }
                        ),
                      InkWellZona(),
                      SizedBox(height: 5,),
                      //TextFieldUno(controller: widget.controllerNombreZona, hintText: "Zona",etiqueta: "Zona",heightContainer: 35,widthContainer: 220,widthEtiqueta: 70,),
                      TextFFBasico(
                        controller: controllerDireccion!, 
                        labelText: "Dirección", 
                        onChanged: (x){
                          inmuebleInfo.getInmuebleTotalCopia.getInmueble.direccion=x.toString();
                        }
                      ),
                      SizedBox(height: 5,),
                      InkWellPropietario(),
                      /*TextFFBasico(
                        controller: controllerNombrePropietario!, 
                        labelText: "Nombre propietario", 
                        onChanged: (x){
                        }
                      ),*/
                      
                      SizedBox(height: 5,),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Mascotas permitidas",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.mascotasPermitidas, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.mascotasPermitidas=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Sin hipoteca",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.sinHipoteca, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.sinHipoteca=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Construcción a estrenar",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.construccionEstrenar, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.construccionEstrenar=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Materiales de primera",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.materialesPrimera, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.materialesPrimera=value;
                          });
                        }
                      ),
                      TextFFBasico(
                        controller: controllerSuperficieTerreno!, 
                        labelText: "Sup. del terreno en m2", 
                        onChanged: (x){
                          inmuebleInfo.getInmuebleTotalCopia.getInmueble.superficieTerreno=int.parse(x);
                        }
                      ),
                      SizedBox(height: 5,),
                      TextFFBasico(
                        controller: controllerSuperficieConstruccion!, 
                        labelText: "Sup. de construcción en m2", 
                        onChanged: (x){
                          inmuebleInfo.getInmuebleTotalCopia.getInmueble.superficieConstruccion=int.parse(x);
                        }
                      ),
                      SizedBox(height: 5,),
                      TextFFBasico(
                        controller: controllerTamanioFrente!, 
                        labelText: "Tamaño de frente", 
                        onChanged: (x){
                          inmuebleInfo.getInmuebleTotalCopia.getInmueble.tamanioFrente=int.parse(x);
                        }
                      ),
                      SizedBox(height: 5,),
                      TextFFBasico(
                        controller: controllerTiempoConstruccion!, 
                        labelText: "Antigüedad de construcción", 
                        onChanged: (x){
                          inmuebleInfo.getInmuebleTotalCopia.getInmueble.antiguedadConstruccion=int.parse(x);
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Proyectos preventa",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.proyectoPreventa, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.proyectoPreventa=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Inmueble compartido",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.isInmuebleCompartido, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.setInmuebleCompartido(value);
                          });
                        }
                      ),
                      TextFFBasico(
                        controller: controllerNumeroDuenios!, 
                        labelText: "Número de dueños", 
                        onChanged: (x){
                          inmuebleInfo.getInmuebleTotalCopia.getInmueble.numeroDuenios=int.parse(x);
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Servicios básicos",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.serviciosBasicos, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.serviciosBasicos=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Gas domiciliario",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.gasDomiciliario, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.gasDomiciliario=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Wi-Fi",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.wifi, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.wifi=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Medidor independiente",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.medidorIndependiente, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.medidorIndependiente=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Termotanques",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.termotanque, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.termotanque=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Calle asfaltada",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.calleAsfaltada, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.calleAsfaltada=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Transporte  (0 - 100m)",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.transporte, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.transporte=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Preparado para discapacidad",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.preparadoDiscapacidad, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.preparadoDiscapacidad=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Papeles en orden",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.papelesOrden,
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.papelesOrden=value;
                          });
                        }
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text("Habilitado para crédito de vivienda social",
                          style:TextStyle(fontSize: 15,
                            color:Colors.black54,
                            fontStyle: FontStyle.italic
                          )
                        ),
                        value: inmuebleInfo.inmuebleTotalCopia.getInmueble.habilitadoCredito, 
                        onChanged: (bool value){
                          setState(() {
                            inmuebleInfo.inmuebleTotalCopia.getInmueble.habilitadoCredito=value;
                          });
                        }
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      TextFFBasico(
                        controller: controllerDetallesGenerales!, 
                        labelText: "Detalles", 
                        onChanged: (x){
                          inmuebleInfo.inmuebleTotalCopia.inmueble.detallesGenerales=x;
                        }
                      ),
                    ],
                  ),)
                ],
            ),
          ),
        ],
      ),
    );
  }
}
