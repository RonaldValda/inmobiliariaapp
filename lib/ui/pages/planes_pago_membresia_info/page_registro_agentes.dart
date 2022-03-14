
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/datos_auxiliares.dart';
import 'package:inmobiliariaapp/data/repositories/usuario/super_usuario_repository_gql.dart';
import 'package:inmobiliariaapp/domain/entities/banco.dart';
import 'package:inmobiliariaapp/domain/entities/membresia_planes_pago.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_banco.dart';
import 'package:inmobiliariaapp/domain/usecases/generales/usecase_membresia_planes_pago.dart';
import 'package:inmobiliariaapp/domain/usecases/usuario/usecase_super_usuario.dart';
import 'package:inmobiliariaapp/ui/pages/banco/widgets/bancoItem.dart';
import 'package:inmobiliariaapp/ui/pages/membresia_formulario_deposito/page_formulario_deposito.dart';
import 'package:inmobiliariaapp/ui/provider/usuarios_info.dart';
import 'package:provider/provider.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
enum getTipoPagoAgente{
  deposito,
  tarjeta
}
enum getPlanesPago{
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
  List<CuentaBanco> bancos=[];
  List<dynamic> bancosD=[];
  List<MembresiaPlanesPago> planes=[];
  MembresiaPlanesPago planSelected=MembresiaPlanesPago.vacio();
  List<dynamic> planesD=[];
  String fechaActivacion="";
  Map<String,dynamic>? mapFechaActivacion;
  int costoTotal=0;
  UseCaseSuperUsuario useCaseSuperUsuario=UseCaseSuperUsuario();
  UseCaseBanco useCaseBanco=UseCaseBanco();
  UseCaseMembresiaPlanesPago useCaseMembresiaPlanesPago=UseCaseMembresiaPlanesPago();
  @override
  void initState() {
    super.initState();
    _controllerNombreAgencia=TextEditingController(text: "");
    _controllerWeb=TextEditingController(text:"");
    mapFechaActivacion=getAdelantarDias(true);
    costoTotal=getMontoPagar(mapFechaActivacion!, getPlanesPagoMes()[0]);
    useCaseBanco.obtenerCuentasBanco()
    .then((resultado){
      if(resultado["completado"]){
        bancos=resultado["cuentas_bancos"];
        useCaseMembresiaPlanesPago.obtenerMembresiaPlanesPago().then((value) {
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
    final usuario=Provider.of<UsuariosInfo>(context);
    _controllerNombreAgencia!.text=usuario.getUsuario.getNombreAgencia;
    _controllerWeb!.text=usuario.getUsuario.getWeb;
    
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
                                  value: planSelected.id==plan.id, 
                                  onChanged: (selected){
                                    planSelected=plan;
                                    if(planSelected.costo==0){
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
                  planSelected.costo>0?Container(
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
                                value: getTipoPagoAgente.deposito.index,
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
                                value: getTipoPagoAgente.tarjeta.index,
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
                  tipoPago==getTipoPagoAgente.deposito.index?
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
                              return BancoItem(banco: bancos[index]);
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
                  tipoPago==getTipoPagoAgente.tarjeta.index?Column(
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