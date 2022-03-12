import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_planes_pago.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_membresia_planes_pago.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/widgets/textField_modelos.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';
enum unidad_medida_tiempo{
  dias,
  meses
}
class PageRegistroMembresiaPlanesPago extends StatefulWidget {
  PageRegistroMembresiaPlanesPago({Key? key}) : super(key: key);

  @override
  _PageRegistroMembresiaPlanesPagoState createState() => _PageRegistroMembresiaPlanesPagoState();
}

class _PageRegistroMembresiaPlanesPagoState extends State<PageRegistroMembresiaPlanesPago> {
  TextEditingController? controllerCosto;
  TextEditingController? controllerNombrePlan;
  TextEditingController? controllerTiempo;
  MembresiaPlanesPago membresia=MembresiaPlanesPago.vacio();
  List<MembresiaPlanesPago> membresiasPlanesPago=[];
  UseCaseMembresiaPlanesPago useCaseMembresiaPlanesPago=UseCaseMembresiaPlanesPago();
  int valorUnidad=0;
  int selected=-1;
  @override
  void initState() {
    super.initState();
    controllerCosto=TextEditingController(text: "0");
    controllerNombrePlan=TextEditingController(text: "");
    controllerTiempo=TextEditingController(text: "0");
    useCaseMembresiaPlanesPago.obtenerMembresiaPlanesPago().then((value) {
      if(value["completado"]){
        membresiasPlanesPago.addAll(value["membresias_planes_pago"]);
        setState(() {
        
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Membresía planes pago"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: membresiasPlanesPago.length,
                itemBuilder: (context, index) {
                  MembresiaPlanesPago memb=membresiasPlanesPago[index];
                  return ListTile(
                    selected: selected==index,
                    selectedTileColor: Colors.blue.withOpacity(0.11),
                    tileColor: (index+1)%2==0?Colors.transparent:Colors.black.withOpacity(0.02),
                    leading: IconButton(
                      onPressed: (){
                        membresiasPlanesPago[index].activo=!membresiasPlanesPago[index].activo;
                        useCaseMembresiaPlanesPago.modificarMembresiaPlanesPago(membresiasPlanesPago[index]).then((resultado){
                          if(resultado["completado"]){
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se guardaron los cambios"));
                          }else{
                            membresiasPlanesPago[index].activo=!membresiasPlanesPago[index].activo;
                             ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Algo salió mal intentelo de nuevo"));
                          }
                        }).whenComplete(() {
                          setState(() {
                            
                          });
                        });
                      }, 
                      icon: memb.activo?
                        Icon(Icons.check,color: Colors.green,size: 30,)
                        :
                        Icon(Icons.close,color: Colors.red,size: 30,),
                    ),
                    title: Text(memb.nombrePlan,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    subtitle: Text("${memb.tiempo} ${memb.unidadMedidaTiempo}"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${memb.costo.toString()} Bs.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        
                      ],
                    ),
                    onTap: (){
                      if(memb.unidadMedidaTiempo=="Meses"){
                        valorUnidad=unidad_medida_tiempo.meses.index;
                      }else{
                        valorUnidad=unidad_medida_tiempo.dias.index;
                      }
                      
                      if(selected!=index){
                        membresia=MembresiaPlanesPago.copyWith(memb);
                        controllerCosto!.text=memb.costo.toString();
                        controllerNombrePlan!.text=memb.nombrePlan;
                        controllerTiempo!.text=memb.tiempo.toString();
                        selected=index;
                      }else{
                        membresia=MembresiaPlanesPago.vacio();
                        controllerCosto!.text="0";
                        controllerNombrePlan!.text="";
                        controllerTiempo!.text="1";
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
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black12
                  )
                )
              ),
              padding:EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text("Días"),
                          Radio(
                            value: unidad_medida_tiempo.dias.index,
                            groupValue: valorUnidad, 
                            onChanged: (i){
                              valorUnidad=int.parse(i.toString());
                              setState(() {
                                
                              });
                            }
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text("Meses"),
                          Radio(
                            value: unidad_medida_tiempo.meses.index, 
                            groupValue: valorUnidad, 
                            onChanged: (i){
                              valorUnidad=int.parse(i.toString());
                              setState(() {
                                
                              });
                            }
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextFFBasico(
                    controller: controllerNombrePlan!, 
                    labelText: "Nombre del plan", 
                    onChanged: (x){
                      membresia.nombrePlan=x;
                    }
                  ),
                  SizedBox(height:5),
                  TextFFBasico(
                    controller: controllerTiempo!, 
                    labelText: "Tiempo", 
                    onChanged: (x){
                      if(x!=""){
                        membresia.tiempo=int.parse(x);
                      }
                    }
                  ),
                  SizedBox(height:5),
                  TextFFBasico(
                    controller: controllerCosto!, 
                    labelText: "Costo", 
                    onChanged: (x){
                      if(x!=""){
                        membresia.costo=int.parse(x);
                      }
                    }
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(selected<0){
                        membresia.activo=true;
                        useCaseMembresiaPlanesPago.registrarMembresiaPlanesPago(membresia).then((value){
                          if(value["completado"]){
                            membresiasPlanesPago.add(value["membresia_planes_pago"]);
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Registro completado"));
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Algo salió mal intentelo de nuevo"));
                          }
                        }).whenComplete((){
                          setState(() {
                            
                          });
                        });
                      }else{
                        useCaseMembresiaPlanesPago.modificarMembresiaPlanesPago(membresia).then((resultado){
                          if(resultado["completado"]){
                            membresiasPlanesPago.removeWhere((element) => element.id==membresia.id);
                            membresiasPlanesPago.add(membresia);
                            membresiasPlanesPago.sort((a,b)=>a.nombrePlan.compareTo(b.nombrePlan));
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se guardaron los cambios"));
                          }else{
                             ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Algo salió mal intentelo de nuevo"));
                          }
                        }).whenComplete(() {
                          setState(() {
                            
                          });
                        });
                      }
                    }, 
                    child: Text(selected<0?"Registrar":"Modificar")
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}