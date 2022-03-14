import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/inmueble_total.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/grilla_imagenes.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:provider/provider.dart';
class ContainerInmuebleInternas extends StatefulWidget {
  ContainerInmuebleInternas({Key? key}) : super(key: key);
  @override
  _ContainerInmuebleInternasState createState() => _ContainerInmuebleInternasState();
}

class _ContainerInmuebleInternasState extends State<ContainerInmuebleInternas> {
  InmuebleTotal? inmuebleTotal;
  TextEditingController? controllerNumeroDormitorios;
  TextEditingController? controllerNumeroBanios;
  TextEditingController? controllerNumeroGaraje;
  TextEditingController? controllerPlantas;
  TextEditingController? controllerAmbientes;
  TextEditingController? controllerDetallesInternas;
  @override
  void initState() {
    super.initState();
    controllerNumeroDormitorios=TextEditingController(text: "-1");
    controllerNumeroBanios=TextEditingController(text: "-1");
    controllerNumeroGaraje=TextEditingController(text: "-1");
    controllerAmbientes=TextEditingController(text: "-1");
    controllerPlantas=TextEditingController(text: "-1");
    controllerDetallesInternas=TextEditingController(text:"");
  }
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(controllerNumeroDormitorios!.text=="-1"){
      controllerNumeroDormitorios!.text=inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.dormitorios.toString();
      controllerNumeroBanios!.text=inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.banios.toString();
      controllerNumeroGaraje!.text=inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.garaje.toString();
      controllerAmbientes!.text=inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.ambientes.toString();
      controllerPlantas!.text=inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.plantas.toString();
      controllerDetallesInternas!.text=inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.detallesInternas;
    }
    return Container(
      padding: EdgeInsets.all(10),
      //width: 400,
      height: MediaQuery.of(context).size.height/1.6,
      //width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/3,
      child: Column(
          children: [
            Expanded(child: ListView(
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 5,),
                OutlinedButton(
                  onPressed: ()async{
                    List<dynamic> imagenes=[];
                    bool uploading=false;
                    
                    imagenes.addAll(inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes["principales"]);
                    print(imagenes.length);
                    await shorwModalBotonSheetImagenes(context, imagenes, uploading, "Principales","principales");
                    //print(imagenes.length);
                    InmuebleTotal inmuebleTotal=inmuebleInfo.getInmuebleTotalCopia;
                    //inmuebleTotal.getInmueble.mapImagenes["principales"]=[];
                    //inmuebleTotal.getInmueble.mapImagenes["principales"]=imagenes;
                    //inmuebleTotal.inmuebleInternas.amoblado=false;
                    inmuebleInfo.setInmuebleTotalCopia(inmuebleTotal);
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.upload,
                        color: inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes["principales"].length>0?
                          Colors.blueAccent:Colors.grey,
                      ),
                      Text("Imágenes principales"),
                    ],
                  )
                ),
                Row(
                  children: [
                    BotonIconoSubirImagen(
                      nombreCategoria:"Plantas",
                      clave: "plantas",
                      selected: inmuebleInfo.inmuebleTotalCopia.inmuebleInternas.plantas>0, 
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextFFBasico(
                        controller: controllerPlantas!, 
                        labelText: "Plantas", 
                        onChanged: (x){
                          if(x!=""){
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.plantas=int.parse(x);
                          }else{
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.plantas=0;
                          }
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    BotonIconoSubirImagen(
                      nombreCategoria:"Ambientes",
                      clave: "ambientes",
                      selected: inmuebleInfo.inmuebleTotalCopia.inmuebleInternas.ambientes>0, 
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextFFBasico(
                        controller: controllerAmbientes!, 
                        labelText: "Ambientes", 
                        onChanged: (x){
                          if(x!=""){
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.ambientes=int.parse(x);
                          }else{
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.ambientes=0;
                          }
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    BotonIconoSubirImagen(
                      nombreCategoria:"Dormitorios",
                      clave: "dormitorios",
                      selected: inmuebleInfo.inmuebleTotalCopia.inmuebleInternas.dormitorios>0, 
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextFFBasico(
                        controller: controllerNumeroDormitorios!, 
                        labelText: "Dormitorios", 
                        onChanged: (x){
                          if(x!=""){
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.dormitorios=int.parse(x);
                          }else{
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.dormitorios=0;
                          }
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    BotonIconoSubirImagen(
                      nombreCategoria:"Baños",
                      clave: "banios",
                      selected: inmuebleInfo.inmuebleTotalCopia.inmuebleInternas.banios>0, 
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextFFBasico(
                        controller: controllerNumeroBanios!,
                        labelText: "Baños", 
                        onChanged: (x){
                          if(x!=""){
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.banios=int.parse(x);
                          }else{
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.banios=0;
                          }
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    BotonIconoSubirImagen(
                      nombreCategoria:"Garaje",
                      clave: "garaje",
                      selected: inmuebleInfo.inmuebleTotalCopia.inmuebleInternas.garaje>0, 
                    ),
                    SizedBox(width: 15,),
                    Expanded(
                      child: TextFFBasico(
                        controller: controllerNumeroGaraje!,
                        labelText: "Garaje", 
                        onChanged: (x){
                          if(x!=""){
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.garaje=int.parse(x);
                          }else{
                            inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.garaje=0;
                          }
                          setState(() {
                            
                          });
                        }
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria:"Amoblado",
                    clave: "amoblado",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.amoblado, 
                  ),
                  title: Text("Amoblado",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.amoblado, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.amoblado=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria:"Lavanderia",
                    clave: "lavanderia",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.lavanderia, 
                  ),
                  title: Text("Lavanderia",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.lavanderia, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.lavanderia=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Cuarto de lavado",
                    clave: "cuarto_lavado",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.cuartoLavado, 
                  ),
                  title: Text("Cuarto de lavado",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.cuartoLavado, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.cuartoLavado=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Churrasquero",
                    clave: "churrasquero",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.churrasquero, 
                  ),
                  title: Text("Churrasquero",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.churrasquero, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.churrasquero=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Azotea",
                    clave: "azotea",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.azotea, 
                  ),
                  title: Text("Azotea",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.azotea, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.azotea=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "[Club house]-> Condominio privado",
                    clave: "condominio_privado",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.condominioPrivado, 
                  ),
                  title: Text("[Club house]-> Condominio privado",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.condominioPrivado, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.condominioPrivado=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Cancha de fútbol, tenis, etc. en inmueble",
                    clave: "cancha",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.cancha, 
                  ),
                  title: Text("Cancha de fútbol, tenis, etc. en inmueble",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.cancha, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.cancha=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Piscina",
                    clave: "piscina",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.piscina, 
                  ),
                  title: Text("Piscina",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.piscina, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.piscina=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Sauna",
                    clave: "sauna",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.sauna, 
                  ),
                  title: Text("Sauna",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.sauna, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.sauna=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Jacuzzi",
                    clave: "jacuzzi",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.jacuzzi, 
                  ),
                  title: Text("Jacuzzi",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.jacuzzi, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.jacuzzi=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria:" Estudio",
                    clave: "estudio",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.estudio, 
                  ),
                  title: Text("Estudio",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.estudio, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.estudio=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Jardín",
                    clave: "jardin",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.jardin, 
                  ),
                  title: Text("Jardín",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.jardin, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.jardin=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Portón eléctrico",
                    clave: "porton_electrico",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.portonElectrico, 
                  ),
                  title: Text("Portón eléctrico",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.portonElectrico, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.portonElectrico=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Aire acondicionado",
                    clave: "aire_acondicionado",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.aireAcondicionado, 
                  ),
                  title: Text("Aire acondicionado",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.aireAcondicionado, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.aireAcondicionado=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Calefacción",
                    clave: "calefaccion",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.calefaccion, 
                  ),
                  title: Text("Calefacción",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.calefaccion, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.calefaccion=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Ascensor",
                    clave: "ascensor",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.ascensor, 
                  ),
                  title: Text("Ascensor",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.ascensor, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.ascensor=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Depósito",
                    clave: "deposito",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.deposito, 
                  ),
                  title: Text("Depósito",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.deposito, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.deposito=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Sótano",
                    clave: "sotano",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.sotano, 
                  ),
                  title: Text("Sótano",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.sotano, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.sotano=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Balcón",
                    clave: "balcon",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.balcon, 
                  ),
                  title: Text("Balcón",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.balcon, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.balcon=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "Tienda",
                    clave: "tienda",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.tienda, 
                  ),
                  title: Text("Tienda",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.tienda, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.tienda=value;
                    });
                  }
                ),
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  secondary: BotonIconoSubirImagen(
                    nombreCategoria: "[Amurallado]-> Terreno",
                    clave: "amurallado_terreno",
                    selected: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.amuralladoTerreno, 
                  ),
                  title: Text("[Amurallado]-> Terreno",
                    style:TextStyle(fontSize: 15,
                      color:Colors.black54,
                      fontStyle: FontStyle.italic
                    )
                  ),
                  value: inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.amuralladoTerreno, 
                  onChanged: (bool value){
                    setState(() {
                      inmuebleInfo.getInmuebleTotalCopia.getInmuebleInternas.amuralladoTerreno=value;
                    });
                  }
                ),
                SizedBox(
                  height: 5,
                ),
                TextFFBasico(
                  controller: controllerDetallesInternas!, 
                  labelText: "Detalles", 
                  onChanged: (x){
                    inmuebleInfo.inmuebleTotalCopia.inmuebleInternas.detallesInternas=x;
                  }
                ),
              ],
            ),)
          ],
      ),
    );
  }
}
class BotonIconoSubirImagen extends StatefulWidget {
  BotonIconoSubirImagen({Key? key,
    required this.nombreCategoria,
    required this.clave,
    required this.selected}) : super(key: key);
  final String nombreCategoria;
  final String clave;
  final bool selected;
  @override
  _BotonIconoSubirImagenState createState() => _BotonIconoSubirImagenState();
}

class _BotonIconoSubirImagenState extends State<BotonIconoSubirImagen> {
  bool uploading=false;
  List<dynamic> imagenes=[];
  int i=0;
  @override
  Widget build(BuildContext context) {
    final inmuebleInfo=Provider.of<InmuebleInfo>(context);
    return Container(
      margin: EdgeInsets.zero,
      padding:EdgeInsets.zero,
      width: 30,
      child: widget.selected?
      IconButton(
        padding: EdgeInsets.zero,
        splashRadius: 25,
        icon: Icon(
          Icons.upload,
          color: inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes[widget.clave].length>0?
            Colors.blueAccent:Colors.grey,
        ),
        onPressed: ()async{
          imagenes=[];
          imagenes.addAll(inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes[widget.clave]);
          await shorwModalBotonSheetImagenes(context,imagenes,uploading,widget.nombreCategoria,widget.clave);
          //inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes[widget.clave]=[];
          //inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes[widget.clave].addAll(imagenes);
          InmuebleTotal inmuebleTotal=inmuebleInfo.getInmuebleTotalCopia;
          inmuebleTotal.getInmueble.mapImagenes[widget.clave]=[];
          inmuebleTotal.getInmueble.mapImagenes[widget.clave].addAll(imagenes);
          inmuebleInfo.setInmuebleTotalCopia(inmuebleTotal);
          //print(inmuebleInfo.getInmuebleTotalCopia.getInmueble.mapImagenes[widget.clave].length);
          //print(inmuebleInfo.getInmuebleTotal.getInmueble.mapImagenes[widget.clave].length);
       
        },
      ):Container(),
    );
  }

  
}
Future<dynamic> shorwModalBotonSheetImagenes(
  BuildContext context,List<dynamic> imagenes,bool uploading,
  String nombreCategoria,String clave
) {
    return showModalBottomSheet(
      shape:RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft:Radius.circular(20),topRight: Radius.circular(20),),
      ),
      elevation: 50,
      context: context,
      isDismissible: true,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(right: 5,left: 5,top: 0,bottom: 5),
          height: MediaQuery.of(context).size.height/1.1,
          child: Column(
            children: [
              Container(
                height: 30,
                //color: Colors.blue,
                padding: EdgeInsets.only(left: 5,right: 0,top: 0,bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(clave=="principales"?"Imágenes principales":"Seleccione las imágenes ($nombreCategoria)",
                      style: TextStyle(
                        fontStyle: FontStyle.italic
                      ),
                    ),
                    IconButton(
                      splashRadius: 25,
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close)
                    )
                  ],
                ),
              ),
              Expanded(
                child: GrillaImagenes(
                  uploading: uploading, 
                  imagenes: imagenes,
                  clave: clave
                )
              )
            ],
          ),
        );
      },
    );
  }