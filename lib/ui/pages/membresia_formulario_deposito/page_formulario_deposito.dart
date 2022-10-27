import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inmobiliariaapp/auxiliares/datos_auxiliares.dart';
import 'package:inmobiliariaapp/domain/entities/membership_payment.dart';
import 'package:inmobiliariaapp/domain/entities/bank.dart';
import 'package:inmobiliariaapp/domain/entities/membership_plan_payment.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:inmobiliariaapp/domain/usecases/user/usecase_user.dart';
import 'package:inmobiliariaapp/widgets/popup_menu_cuenta_banco.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';
enum GetTipoTransaction{
  deposito,
  transferencia
}
// ignore: must_be_immutable
class PageFormularioDeposito extends StatefulWidget {
  PageFormularioDeposito({Key? key,required this.plan,required this.metodoPago,
  required this.bancos}) : super(key: key);
  final MembershipPlanPayment plan;
  final int metodoPago;
  final List<BankAccount> bancos;
  bool uploading=false;
  final picker=ImagePicker();
  @override
  _PageFormularioDepositoState createState() => _PageFormularioDepositoState();
}

class _PageFormularioDepositoState extends State<PageFormularioDeposito> {
  TextEditingController? controllerNumeroDeposito;
  TextEditingController? controllerNombreDepositante;
  List<dynamic> comprobanteDeposito=[""];
  int tipoTransaccion=0;
  String fechaActivacion="";
  Map<String,dynamic>? mapFechaActivacion;
  BankAccount cuentaBanco=BankAccount.empty();
  double heigthImagen=0;
  double widthImagen=0;
  final picker=ImagePicker();
  bool uploading=false;
  MembershipPayment membresiaPago=MembershipPayment.empty();
  @override
  void initState() { 
    super.initState();
    controllerNombreDepositante=TextEditingController(text: "");
    controllerNumeroDeposito=TextEditingController(text: "");
    mapFechaActivacion=getAdelantarDias(true);
    membresiaPago.paymentMedium="Depósito";
    membresiaPago.membershipPlanPayment=widget.plan;
    membresiaPago.paymentAmount=widget.plan.cost;
    //costoTotal=getMontoPagar(mapFechaActivacion!, widget.plan.costo);
  }
  @override
  Widget build(BuildContext context) {
    dynamic imagen=membresiaPago.depositImageLink;
    heigthImagen=MediaQuery.of(context).size.height/1.7;
    widthImagen=MediaQuery.of(context).size.width/1.1;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Pago con depósito o transferencia"),
      ),
      body: Container(
        //color: Colors.black87,
        padding: EdgeInsets.symmetric(vertical: 5),
        //height:500,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    children: [
                      Text("Plan ${widget.plan.planName}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text(
                        "Fecha de activacion : ${mapFechaActivacion!["dia"]}/${mapFechaActivacion!["mes"]}/${mapFechaActivacion!["anio"]}",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      Text("Monto a pagar : ${widget.plan.cost.toString()} Bs.",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            FTextFieldBasico(
                              controller: controllerNumeroDeposito!, 
                              labelText: "Número de depósito", 
                              onChanged: (x){
                                membresiaPago.transactionNumber=x;
                              }
                            ),
                            SizedBox(height:10),
                            FTextFieldBasico(
                              controller: controllerNombreDepositante!, 
                              labelText: "Depositante", 
                              onChanged: (x){
                                membresiaPago.depositorName=x;
                              }
                            ),
                            PopupMenuCuentaBanco(cuentaBanco: membresiaPago.bankAccount,bancos: widget.bancos,
                              heightContainer: 70,
                              widthEtiqueta: MediaQuery.of(context).size.width,
                              widthContainer: MediaQuery.of(context).size.width
                            ),
                            SizedBox(height:5),
                          ],
                        ),
                      ),
                      
                      
                      Container(
                        //color: Colors.amber,
                        child:Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Row(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Depósito",style: TextStyle(fontSize: 13),),
                                ),
                                Container(
                                  child: Radio<int>(
                                    groupValue: tipoTransaccion,
                                    value: GetTipoTransaction.deposito.index,
                                    onChanged: (value){
                                      membresiaPago.paymentMedium="Depósito";
                                      setState(() {
                                        tipoTransaccion=value!;
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
                                  child: Text("Transferencia",style: TextStyle(fontSize: 13),),
                                ),
                                Container(
                                  child: Radio<int>(
                                    groupValue: tipoTransaccion,
                                    value: GetTipoTransaction.transferencia.index,
                                    onChanged: (value){
                                      setState(() {
                                        membresiaPago.paymentMedium="Transferencia";
                                        tipoTransaccion=value!;
                                      });
                                      
                                    }
                                  ),
                                ),
                              ],
                            ),
                          ]
                        )
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      (imagen is File)?Container(
                            alignment: Alignment.bottomLeft,
                            height: heigthImagen,
                            width: widthImagen,
                            margin: EdgeInsets.all(0),
                            decoration: 
                            BoxDecoration(
                              image: DecorationImage(
                                image: FileImage(imagen),
                                //image:(_image[index] is String)? (NetworkImage(_image[index].toString())):FileImage(_image[index] as File),
                                fit: BoxFit.fill
                              ),
                            )
                            
                          )
                      :
                      (imagen as String)!=""?Container(
                        height: heigthImagen,
                        width:widthImagen,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.3),
                          image: DecorationImage(
                            image: NetworkImage(imagen),
                            fit: BoxFit.fitHeight,
                            scale: 1.5
                          )
                        ),
                      ):Container(
                        height: heigthImagen,
                        width:widthImagen,
                        color: Colors.grey.withOpacity(.3),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          //widget.urlComprobantePago.toUpperCase();
                          if(!uploading) chooseImage();
                        }, 
                        child: Text("Subir comprobante")
                      )
                    ],
                  ),
                ],
              ),
            ),
            
            BotonRegistrarMembresiaPago(
              membresia: membresiaPago,
            )
          ],
        ),  
      ),
    );
  }
  chooseImage() async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery);
    setState(() {
     // widget.imagenComprobante.removeAt(0);
     membresiaPago.depositImageLink=File(pickedFile!.path);
      //widget.imagenComprobante.add(File(pickedFile!.path));
      //print(widget.imagenComprobante[0]);
    });
    // ignore: unnecessary_null_comparison
    if(pickedFile!.path == null) picker.retrieveLostData();
  }
}
class BotonRegistrarMembresiaPago extends StatefulWidget {
  const BotonRegistrarMembresiaPago({Key? key,
  required this.membresia}) : super(key: key);
  final MembershipPayment membresia;

  @override
  _BotonRegistrarMembresiaPagoState createState() => _BotonRegistrarMembresiaPagoState();
}

class _BotonRegistrarMembresiaPagoState extends State<BotonRegistrarMembresiaPago> {
  UseCaseUser useCaseUsuario=UseCaseUser();
  @override
  Widget build(BuildContext context) {
    final usuario=Provider.of<UserProvider>(context);
    return ElevatedButton(
      onPressed: ()async{
        //Navigator.popAndPushNamed(context, routeName);
        String rutaImagen=await uploadFile([widget.membresia.depositImageLink]);
        widget.membresia.depositImageLink=rutaImagen;
        widget.membresia.user=usuario.user;
        useCaseUsuario.registerMembershipPayment(widget.membresia)
        .then((resultado) {
          if(resultado["completed"]){
            usuario.membershipsPayments.add(resultado["membrerships_payments"]);
            Navigator.pop(context);
          }
        });
      },
      child: Text("Enviar")
    );
  }

  Future<String> uploadFile(List<dynamic> imagenes) async{
    firebase_storage.Reference? ref;
    String linkLogoBanco="";
    for(var img in imagenes){
      if(img is File){
        // ignore: unnecessary_cast
        ref=firebase_storage.FirebaseStorage.instance.ref().child('images/${(img as File).path}');
        await ref.putFile(img).whenComplete(() async{
          await ref!.getDownloadURL().then((value) {
            linkLogoBanco=value;
          });
        });
      }else{
        linkLogoBanco=img as String;
      }
    }
    return linkLogoBanco;
  }
}