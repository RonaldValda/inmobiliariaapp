
import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/auxiliares/datos_auxiliares.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/ui/pages/planes_pago_membresia_info/page_registro_agentes.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:provider/provider.dart';
class PageMembresiaPagos extends StatefulWidget {
  PageMembresiaPagos({Key? key}) : super(key: key);

  @override
  _PageMembresiaPagosState createState() => _PageMembresiaPagosState();
}

class _PageMembresiaPagosState extends State<PageMembresiaPagos> {
  List<MembershipPayment> membresiaPagos=[];
  List membresiaPagosD=[];
  List<String> planes=["Básico","Medio","Avanzado"];
  UseCaseUser useCaseUsuario=UseCaseUser();
  late UserProvider usProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      usProvider=Provider.of<UserProvider>(context,listen: false);
      useCaseUsuario.getMembershipPayments(usProvider.user.id)
      .then((resultado){
        if(resultado["completado"]){
          membresiaPagos=resultado["membresia_pagos"];
          setState(() {
            
          });
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Membresia Pagos"),
       ),
       body: Container(
         //color: Colors.black12,
         child: Column(
           children: [
             ListaMembresiaPagos(membresiaPagos: membresiaPagos),
             ElevatedButton(
               onPressed: ()async{
                 bool permitido=true;
                 String mensaje="";
                 /*if(membresiaPagos.length>0){
                   if(membresiaPagos[membresiaPagos.length-1].autorizacion=="Aprobado"){
                    DateTime diaInicio=DateTime.parse(membresiaPagos[membresiaPagos.length-1].fechaInicio).toUtc();
                    DateTime diaActual=DateTime.now().toUtc();
                    if(membresiaPagos[membresiaPagos.length-1].mes==diaActual.month){
                      permitido=false;
                      mensaje="Usted aún tiene una suscripción vigente";
                    }
                   }else if(membresiaPagos[membresiaPagos.length-1].autorizacion=="Pendiente"){
                      permitido=false;
                      mensaje="No puede pagar membresía, aun tiene una autorización pendiente";
                    }
                 }*/
                 if(permitido){
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return PagePlanesPagoMembresiaInfo(
                        );
                      }
                    )
                  );
                  setState(() {
                    
                  });
                 }
                 else{
                   ScaffoldMessenger.of(context).showSnackBar(_showSnackBar(mensaje));
                 }
               }, 
               child: Text("Pagar membresía")
             )
           ],
         ),
       ),
    );
  }
  SnackBar _showSnackBar(String texto){
    SnackBar snackBar=SnackBar(
      content: Text(texto),
      action: SnackBarAction(
        label: 'OK',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    return snackBar;
  }
}
class ListaMembresiaPagos extends StatefulWidget {
  ListaMembresiaPagos({Key? key,required this.membresiaPagos}) : super(key: key);
  final List<MembershipPayment> membresiaPagos;
  @override
  _ListaMembresiaPagosState createState() => _ListaMembresiaPagosState();
}

class _ListaMembresiaPagosState extends State<ListaMembresiaPagos> {
  List<String> planes=["Básico","Medio","Avanzado"];
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
          itemCount: widget.membresiaPagos.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                  title: Text(widget.membresiaPagos[index].membershipPlanPayment.planName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Autorización: "+widget.membresiaPagos[index].authorizationSuperUser,
                        
                      ),
                      widget.membresiaPagos[index].initialDate!=""?
                      Text("Vigencia: ${formatFechaUTC(DateTime.parse(widget.membresiaPagos[index].initialDate))} / ${formatFechaUTC(DateTime.parse(widget.membresiaPagos[index].finalDate))}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ):Text("Fecha solicitud: ${formatFechaUTC(DateTime.parse(widget.membresiaPagos[index].requestDate))}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ],
                  ),
                  trailing: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                        Text(widget.membresiaPagos[index].paymentAmount.toString()+" Bs.",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Divider()
              ],
            );
          },
        ),
      );
  }
}