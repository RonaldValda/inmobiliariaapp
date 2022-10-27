import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/membership_plan_payment.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:inmobiliariaapp/widgets/utils.dart';

import '../../../domain/usecases/general/usecase_membership_plan_payment.dart';
enum GetUnitMeasureTime{
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
  MembershipPlanPayment membresia=MembershipPlanPayment.empty();
  List<MembershipPlanPayment> membresiasPlanesPago=[];
  UseCaseMembershipPlanPayment useCaseMembresiaPlanesPago=UseCaseMembershipPlanPayment();
  int valorUnidad=0;
  int selected=-1;
  @override
  void initState() {
    super.initState();
    controllerCosto=TextEditingController(text: "0");
    controllerNombrePlan=TextEditingController(text: "");
    controllerTiempo=TextEditingController(text: "0");
    useCaseMembresiaPlanesPago.getMembershipPlanPayment().then((value) {
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
                  MembershipPlanPayment memb=membresiasPlanesPago[index];
                  return ListTile(
                    selected: selected==index,
                    selectedTileColor: Colors.blue.withOpacity(0.11),
                    tileColor: (index+1)%2==0?Colors.transparent:Colors.black.withOpacity(0.02),
                    leading: IconButton(
                      onPressed: (){
                        membresiasPlanesPago[index].active=!membresiasPlanesPago[index].active;
                        useCaseMembresiaPlanesPago.updateMembershipPlanPayment(membresiasPlanesPago[index]).then((resultado){
                          if(resultado["completado"]){
                            ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Se guardaron los cambios"));
                          }else{
                            membresiasPlanesPago[index].active=!membresiasPlanesPago[index].active;
                             ScaffoldMessenger.of(context).showSnackBar(showSnackBar("Algo salió mal intentelo de nuevo"));
                          }
                        }).whenComplete(() {
                          setState(() {
                            
                          });
                        });
                      }, 
                      icon: memb.active?
                        Icon(Icons.check,color: Colors.green,size: 30,)
                        :
                        Icon(Icons.close,color: Colors.red,size: 30,),
                    ),
                    title: Text(memb.planName,
                      style: TextStyle(
                        fontSize: 18
                      ),
                    ),
                    subtitle: Text("${memb.time} ${memb.unitMeasureTime}"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${memb.cost.toString()} Bs.",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        
                      ],
                    ),
                    onTap: (){
                      if(memb.unitMeasureTime=="Meses"){
                        valorUnidad=GetUnitMeasureTime.meses.index;
                      }else{
                        valorUnidad=GetUnitMeasureTime.dias.index;
                      }
                      
                      if(selected!=index){
                        membresia=MembershipPlanPayment.copyWith(memb);
                        controllerCosto!.text=memb.cost.toString();
                        controllerNombrePlan!.text=memb.planName;
                        controllerTiempo!.text=memb.time.toString();
                        selected=index;
                      }else{
                        membresia=MembershipPlanPayment.empty();
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
                            value: GetUnitMeasureTime.dias.index,
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
                            value: GetUnitMeasureTime.meses.index, 
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
                  FTextFieldBasico(
                    controller: controllerNombrePlan!, 
                    labelText: "Nombre del plan", 
                    onChanged: (x){
                      membresia.planName=x;
                    }
                  ),
                  SizedBox(height:5),
                  FTextFieldBasico(
                    controller: controllerTiempo!, 
                    labelText: "Tiempo", 
                    onChanged: (x){
                      if(x!=""){
                        membresia.time=int.parse(x);
                      }
                    }
                  ),
                  SizedBox(height:5),
                  FTextFieldBasico(
                    controller: controllerCosto!, 
                    labelText: "Costo", 
                    onChanged: (x){
                      if(x!=""){
                        membresia.cost=int.parse(x);
                      }
                    }
                  ),
                  ElevatedButton(
                    onPressed: (){
                      if(selected<0){
                        membresia.active=true;
                        useCaseMembresiaPlanesPago.registerMembershipPlanPayment(membresia).then((value){
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
                        useCaseMembresiaPlanesPago.updateMembershipPlanPayment(membresia).then((resultado){
                          if(resultado["completado"]){
                            membresiasPlanesPago.removeWhere((element) => element.id==membresia.id);
                            membresiasPlanesPago.add(membresia);
                            membresiasPlanesPago.sort((a,b)=>a.planName.compareTo(b.planName));
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