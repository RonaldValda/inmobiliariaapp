import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/domain/entities/property.dart';
import 'package:inmobiliariaapp/domain/entities/property_total.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_adminitrator_requests_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:inmobiliariaapp/ui/utils/general_operators.dart';
import 'package:provider/provider.dart';

import '../../../../../domain/usecases/user/usecase_administrator.dart';

class ContainerAdministratorRequests extends StatefulWidget {
  ContainerAdministratorRequests({Key? key}) : super(key: key);
  @override
  _ContainerAdministratorRequestsState createState() => _ContainerAdministratorRequestsState();
}

class _ContainerAdministratorRequestsState extends State<ContainerAdministratorRequests> {
  
  AdministratorRequest solicitud=AdministratorRequest.empty();
  UseCaseAdministrator useCaseAdministrador=UseCaseAdministrator();
  @override
  Widget build(BuildContext context) {
    final userProvider=context.watch<UserProvider>();
    final administratorRequests=context.watch<PropertyAdministratorRequestsProvider>().administratorRequests;
    return Container(
          padding: EdgeInsets.all(0),
          width: double.infinity,
          height: 400*SizeDefault.scaleHeight,
          decoration: BoxDecoration(
            color: ColorsDefault.colorBackgroud,
            borderRadius: BorderRadius.only(topLeft:Radius.circular(25),topRight: Radius.circular(25),),
          ),
          //color: Colors.yellow.withOpacity(0.8),
          child: administratorRequests.length>0? Column(
            children: [
              _wHeader(),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: administratorRequests.length,
                  itemBuilder: (context, index) {
                    final request= administratorRequests[index];
                    final dateText=userProvider.sessionType=="Administrar"
                      ?"${GeneralOperators.stringToStringFormat(DateTime.parse(request.requestDate).toLocal().toString(),isOrderReverse:true)}"
                      :"${GeneralOperators.stringToStringFormat(DateTime.parse(request.requestDateSuperUser).toLocal().toString(),isOrderReverse:true)}";
                    return FListTileCommon(
                      title: "${request.requestType}", 
                      subtitle: dateText,
                      widgetTrailing: userProvider.sessionType=="Administrar"
                        ?_wTrailing(requestStatus:request.response==""?"Pendiente":request.response)
                        :_wTrailing(requestStatus:request.responseSuperUser==""?"Pendiente":request.responseSuperUser),
                      onTap: (){
                        context.read<PropertyAdministratorRequestsProvider>().setRequestCopy(request);
                        Navigator.pushNamed(context, '/screen_property_request');
                      }, 
                    );
                    //_wListTile(administratorRequests, index, inmuebleInfo, context, userProvider, _inmueblesFiltrado, filterOthersProvider);
                  },
                ),
              ),
            ],
          ):Text("Aún no tiene solicitudes",
            style: TextStyle(
              fontWeight: FontWeight.w600
            ),
          )
        );
  }

  Padding _wHeader() {
    return Padding(
      padding: EdgeInsets.all(10*SizeDefault.scaleWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row()
          ),
          TextStandard(
            text: "Solicitudes", 
            fontSize: 18*SizeDefault.scaleHeight,
            fontWeight: FontWeight.bold,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FXButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _wTrailing({required String requestStatus}) {
    return Container(
      width: 120*SizeDefault.scaleHeight,
      height: 30*SizeDefault.scaleHeight,
      decoration: BoxDecoration(
        color: ColorsDefault.colorBackgroundRequestStatus,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: TextStandard(
          text:requestStatus,
          fontSize: SizeDefault.fSizeStandard,
          color:requestStatus=="Pendiente"
          ?ColorsDefault.colorTextPending:(requestStatus=="Confirmado"?ColorsDefault.colorTextApproved:ColorsDefault.colorTextRefused),
        ),
      ),
    );
  }
  String generarTextoAlerta(String tipoSolicitud){
    String texto="";
    if(tipoSolicitud=="Dar baja") {
      texto="Solicitud de baja del inmueble";
    }else if(tipoSolicitud=="Dar alta"){
      texto="Solicitud de alta del inmueble";
    }else if(tipoSolicitud=="Vendido"){
      texto="Solicitud para declarar vendido el inmueble";
    }
    return texto;
  }
}
class PageComprobanteDepositoInmueble extends StatefulWidget {
  PageComprobanteDepositoInmueble({Key? key,required this.inmuebleTotal}) : super(key: key);
  final PropertyTotal inmuebleTotal;
  @override
  _PageComprobanteDepositoInmuebleState createState() => _PageComprobanteDepositoInmuebleState();
}

class _PageComprobanteDepositoInmuebleState extends State<PageComprobanteDepositoInmueble> {
  double heigthImagen=0;
  double widthImagen=0;
  @override
  Widget build(BuildContext context) {
    final PropertyVoucher inmuebleComprobante=widget.inmuebleTotal.administratorRequest.propertyVoucher;
    heigthImagen=MediaQuery.of(context).size.height/1.7;
    widthImagen=MediaQuery.of(context).size.width/1.1;
    return Scaffold(
      appBar: AppBar(
        title: Text("Comprobante depósito"),
      ),
      body: Container(
        child:Column(
          children: [
            Text("Medio pago: ${inmuebleComprobante.paymentMedium}"),
            Text("Cuenta: ${inmuebleComprobante.bankAccount.accountNumber} | ${inmuebleComprobante.bankAccount.bankName}"),
            Text("Número de transacción: ${inmuebleComprobante.transactionNumber}"),
            Text("Monto pago: ${inmuebleComprobante.paymentAmount}"),
            Text("Depositante: ${inmuebleComprobante.depositorName}"),
            Container(
              alignment: Alignment.bottomLeft,
              height: heigthImagen,
              width: widthImagen,
              margin: EdgeInsets.all(0),
              decoration: 
                BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(inmuebleComprobante.depositImageLink),
                  //image:(_image[index] is String)? (NetworkImage(_image[index].toString())):FileImage(_image[index] as File),
                  fit: BoxFit.fill
                ),
              )
            )
          ],
        )
      ),
    );
  }
}