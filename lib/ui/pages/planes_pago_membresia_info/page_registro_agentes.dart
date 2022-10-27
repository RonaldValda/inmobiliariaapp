
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/datos_auxiliares.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/domain/entities/membership_plan_payment.dart';
import 'package:inmobiliariaapp/domain/usecases/general/usecase_bank.dart';
import 'package:inmobiliariaapp/ui/pages/administration_management/widgets/bank_item.dart';
import 'package:inmobiliariaapp/ui/pages/membresia_formulario_deposito/page_formulario_deposito.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';

import '../../../domain/usecases/general/usecase_membership_plan_payment.dart';
import '../../../domain/usecases/user/usecase_super_user.dart';
enum GetTipoPagoAgente{
  deposito,
  tarjeta
}
enum GetPlanesPago{
  basico,
  medio,
  avanzado
}
class PagePlanesPagoMembresiaInfo extends StatefulWidget {
  PagePlanesPagoMembresiaInfo({Key? key}) : super(key: key);

  @override
  _PagePlanesPagoMembresiaInfoState createState() => _PagePlanesPagoMembresiaInfoState();
}

class _PagePlanesPagoMembresiaInfoState extends State<PagePlanesPagoMembresiaInfo> {
  final color=Colors.black54;
  final colorFill=Colors.white;
  TextEditingController? _controllerNombreAgencia;
  TextEditingController? _controllerWeb;
  int tipoPago=0;
  int plan=0;
  List<dynamic> imagenComprobante=[""];
  List<BankAccount> bancos=[];
  List<dynamic> bancosD=[];
  List<MembershipPlanPayment> planes=[];
  MembershipPlanPayment planSelected=MembershipPlanPayment.empty();
  List<dynamic> planesD=[];
  String fechaActivacion="";
  Map<String,dynamic>? mapFechaActivacion;
  int costoTotal=0;
  UseCaseSuperUser useCaseSuperUsuario=UseCaseSuperUser();
  UseCaseBank useCaseBanco=UseCaseBank();
  UseCaseMembershipPlanPayment useCaseMembresiaPlanesPago=UseCaseMembershipPlanPayment();
  @override
  void initState() {
    super.initState();
    _controllerNombreAgencia=TextEditingController(text: "");
    _controllerWeb=TextEditingController(text:"");
    mapFechaActivacion=getAdelantarDias(true);
    costoTotal=getMontoPagar(mapFechaActivacion!, getPlanesPagoMes()[0]);
    useCaseBanco.getBankAccounts()
    .then((resultado){
      if(resultado["completado"]){
        bancos=resultado["cuentas_bancos"];
        useCaseMembresiaPlanesPago.getMembershipPlanPayment().then((value) {
          if(value["completado"]){
            planes.addAll(value["membresias_planes_pago"]);
            setState(() {
            
            });
          }
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    final usuario=Provider.of<UserProvider>(context);
    _controllerNombreAgencia!.text=usuario.user.agencyName;
    _controllerWeb!.text=usuario.user.web;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Membresía información"),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding:EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Text("Planes de pago",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: planes.map((plan){
                            return Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    children: [
                                      Text(plan.planName,style: TextStyle(fontSize: 18),),
                                      Text(plan.cost.toString()+r" Bs.",
                                      style: TextStyle(
                                        fontSize: 20
                                      ),
                                      )
                                    ],
                                  ),
                                ),
                                Checkbox(
                                  value: planSelected.id==plan.id, 
                                  onChanged: (selected){
                                    planSelected=plan;
                                    if(planSelected.cost==0){
                                      tipoPago=0;
                                    }
                                    setState(() {
                                      
                                    });
                                  }
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  //InfoPlanesPago(plan: planSelected.nombrePlan),
                  planSelected.cost>0?Container(
                  //color: Colors.amber,
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Depósito o transferencia",style: TextStyle(fontSize: 16),),
                            ),
                            Container(
                              child: Radio<int>(
                                groupValue: tipoPago,
                                value: GetTipoPagoAgente.deposito.index,
                                onChanged: (value){
                                  setState(() {
                                    tipoPago=value!;
                                    mapFechaActivacion=getAdelantarDias(true);
                                    costoTotal=getMontoPagar(mapFechaActivacion!, getPlanesPagoMes()[plan]);
                                  });
                                }
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width:20),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text("Tarjeta",style: TextStyle(fontSize: 16),),
                            ),
                            Container(
                              child: Radio<int>(
                                groupValue: tipoPago,
                                value: GetTipoPagoAgente.tarjeta.index,
                                onChanged: (value){
                                  setState(() {
                                    tipoPago=value!;
                                    mapFechaActivacion=getAdelantarDias(false);
                                    costoTotal=getMontoPagar(mapFechaActivacion!, getPlanesPagoMes()[plan]);
                                  });
                                  
                                }
                              ),
                            ),
                          ],
                        ),
                      ]
                    )
                  ):Container(),
                  tipoPago==GetTipoPagoAgente.deposito.index?
                  Container(
                    //color: Colors.amber,
                    height:MediaQuery.of(context).size.height/1.7,
                    child: Column(
                      children: [
                        Expanded(
                          child: GridView.builder(
                            itemCount: bancos.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (context,index){
                              return BankItem(bank: bancos[index]);
                            }
                          )
                        ),
                      ],
                    ),
                  ):Container(),
                  Container(
                    //color: Colors.amber,
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Text(
                          "Fecha de activación : ${mapFechaActivacion!["dia"]}/${mapFechaActivacion!["mes"]}/${mapFechaActivacion!["anio"]}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ),
                  //tipoPago==getTipoPagoAgente.deposito.index?ContainerPago(imagenComprobante: imagenComprobante):Container(),
                  tipoPago==GetTipoPagoAgente.tarjeta.index?Column(
                    children: [
                      Container(
                        child:Text("IMPORTANTE: La habilitación es al instante"),
                      ),
                      Container(),
                    ],
                  ):Container()
                ],
              ),
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context){
                      return PageFormularioDeposito(plan: planSelected,metodoPago: tipoPago ,bancos: bancos,
                      );
                    }
                  )
                );
              }, 
              child: Container(
                width: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Siguiente ->"),
                  ],
                ))
            ),//TextFieldUsuario(color: color, colorFill: colorFill, hintText: hintText, icono: icono, controller: controller)
          ],
        ),
      ),
    );
  }
}