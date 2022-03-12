import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/ui/pages/registro_inmuebles/widgets/container_pago.dart';
import 'package:inmobiliariaapp/ui/provider/inmueble_info.dart';
import 'package:provider/provider.dart';
enum getPlan{
  gratuito,
  pago
}
class ContainerInmueblePlanesPago extends StatefulWidget {
  ContainerInmueblePlanesPago({Key? key,required this.planes}) : super(key: key);
  final List<PlanesPagoPublicacion> planes;
  @override
  _ContainerInmueblePlanesPagoState createState() => _ContainerInmueblePlanesPagoState();
}

class _ContainerInmueblePlanesPagoState extends State<ContainerInmueblePlanesPago> {
  int plan=0;
  List<dynamic>? imagenComprobante=[""];
  PlanesPagoPublicacion planSelected=PlanesPagoPublicacion.vacio();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final _inmuebleInfo=Provider.of<InmuebleInfo>(context);
    if(planSelected.nombrePlan==""){
      if(_inmuebleInfo.inmuebleTotalCopia.inmueble.categoria==""){
        _inmuebleInfo.inmuebleTotalCopia.inmueble.categoria="Gratuito";
      }
      planSelected.nombrePlan=_inmuebleInfo.inmuebleTotalCopia.inmueble.categoria;
      
    }
    return Container(
      //color: Colors.blue.withOpacity(0.1),
      //height:MediaQuery.of(context).size.height/1.6,

      child: Column(
        children: [
          Container(
             //color: Colors.amber,
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children:[
                  Row(
                    children: widget.planes.map((plan){
                      return Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              children: [
                                Text(plan.nombrePlan,style: TextStyle(fontSize: 18),),
                                Text(plan.costo.toString()+r" Bs.",
                                style: TextStyle(
                                  fontSize: 20
                                ),
                                )
                              ],
                            ),
                          ),
                          Checkbox(
                            value: planSelected.nombrePlan.toUpperCase()==plan.nombrePlan.toUpperCase(), 
                            onChanged: (selected){
                              planSelected=plan;
                              _inmuebleInfo.inmuebleTotalCopia.inmueble.categoria=plan.nombrePlan;
                              setState(() {
                                
                              });
                            }
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ]
              )
            ),
            planSelected.nombrePlan.toUpperCase()=="GRATUITO"? Container(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    "Limitaciones",
                    softWrap: true,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "- Sólo 3 imágenes por inmueble son permitidas."
                        ),
                        Text(
                          "- No se permiten vídeo 2D."
                        ),
                        Text(
                          "- No se permiten tour virtual 360."
                        ),
                        Text(
                          "- No se permiten vídeo tour 360."
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ):ContainerPago()
        ],
      )
    );
  }
}