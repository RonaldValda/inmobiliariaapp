import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_planes_pago_publicacion.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
class PagePlanesPagoPublicacion
 extends StatefulWidget {
  PagePlanesPagoPublicacion({Key? key}) : super(key: key);

  @override
  _PagePlanesPagoPublicacionState createState() => _PagePlanesPagoPublicacionState();
}

class _PagePlanesPagoPublicacionState extends State<PagePlanesPagoPublicacion> {
  TextEditingController? controllerNombrePlan;
  TextEditingController? controllerCosto;
  List<PlanesPagoPublicacion> planes=[];
  PlanesPagoPublicacion planSeleccionado=PlanesPagoPublicacion.vacio();
  UseCasePlanesPagoPublicacion useCasePlanesPagoPublicacion=UseCasePlanesPagoPublicacion();
  int selected=-1;
  @override
  void initState() {
    super.initState();
    controllerNombrePlan=TextEditingController(text: "");
    controllerCosto=TextEditingController(text: "0");
    useCasePlanesPagoPublicacion.obtenerPlanesPagoPublicacion().then((value){
      if(value["completed"]){
        planes=value["planes_pago_publicacion"];
        setState(() {
          
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Planes pago publicación"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: planes.length,
                itemBuilder: (context, index) {
                  PlanesPagoPublicacion plan=planes[index];
                  return ListTile(
                    selected: selected==index,
                    selectedTileColor: Colors.blue.withOpacity(0.11),
                    tileColor: (index+1)%2==0?Colors.transparent:Colors.black.withOpacity(0.02),
                    leading: IconButton(
                      onPressed: (){
                        plan.activo=!plan.activo;
                        useCasePlanesPagoPublicacion.modificarPlanesPagoPublicacion(plan)
                        .then((resultado){
                          if(resultado["completado"]){
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se guardaron los cambios"));
                          }else{
                            plan.activo=!plan.activo;
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Algo salió mal intentelo de nuevo"));
                          }
                          setState(() {
                            
                          });
                        });
                      }, 
                      icon: plan.activo?
                        Icon(Icons.check,color: Colors.green,size: 30,)
                        :
                        Icon(Icons.close,color: Colors.red,size: 30,),
                    ),
                    title: Text(plan.nombrePlan,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${plan.costo.toString()} Bs.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        
                      ],
                    ),
                    onTap: (){
                      if(selected!=index){
                        planSeleccionado=PlanesPagoPublicacion.copyWith(plan);
                        controllerCosto!.text=plan.costo.toString();
                        controllerNombrePlan!.text=plan.nombrePlan;
                        selected=index;
                      }else{
                        planSeleccionado=PlanesPagoPublicacion.vacio();
                        controllerCosto!.text="0";
                        controllerNombrePlan!.text="";
                        selected=-1;
                      }
                      setState(() {
                        
                      });
                    },
                  );
                },
              )
            ),
            Container(
              padding:EdgeInsets.fromLTRB(10, 10, 10, 0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black12
                  )
                )
              ),
              child: Column(
                children: [
                  TextFFBasico(
                    controller: controllerNombrePlan!, 
                    labelText: "Nombre del plan", 
                    onChanged: (x){
                      planSeleccionado.nombrePlan=x;
                    }
                  ),
                  SizedBox(height: 5,),
                  TextFFBasico(
                    controller: controllerCosto!, 
                    labelText: "Costo", 
                    onChanged: (x){
                      if(x!=""){
                        planSeleccionado.costo=int.parse(x);
                      }
                    }
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          primary: Colors.blue.withOpacity(0.2),
                          elevation: 0
                        ),
                        onPressed: (){
                          if(selected<0){
                            planSeleccionado.activo=true;
                            useCasePlanesPagoPublicacion.registrarPlanesPagoPublicacion(planSeleccionado)
                            .then((value){
                              if(value["completado"]){
                                planSeleccionado.id=value["plan_pago_publicacion"].id;
                                planes.add(planSeleccionado);
                                planSeleccionado=PlanesPagoPublicacion.vacio();
                                ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Registro completado"));
                                setState(() {
                                  
                                });
                              }else{
                                 ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Algo salió mal intentelo de nuevo"));
                              }
                            });
                          }
                        }, 
                        child: Text(selected<0?"Registrar":"Modificar",
                          style: TextStyle(color: Colors.blue),
                        )
                      ),
                      SizedBox(width: 5,),
                      if(selected>=0)
                      ElevatedButton(
                        style:  ElevatedButton.styleFrom(
                          primary: Colors.red.withOpacity(0.3),
                          elevation: 0
                        ),
                        onPressed: (){
                          useCasePlanesPagoPublicacion.eliminarPlanesPagoPublicacion(planSeleccionado.id)
                          .then((resultado) {
                            if(resultado["completado"]){
                              planes.removeAt(selected);
                              selected=-1;
                              planSeleccionado=PlanesPagoPublicacion.vacio();
                              ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Registro eliminado"));
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Algo salió mal intentelo de nuevo"));
                            }
                            setState(() {
                              
                            });
                          });
                        }, 
                        child: Text("Eliminar",style: TextStyle(color: Colors.red),))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}