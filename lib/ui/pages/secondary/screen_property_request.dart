import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inmobiliariaapp/domain/entities/administrator_request.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/home/properties_provider.dart';
import 'package:inmobiliariaapp/ui/provider/secondary/property_adminitrator_requests_provider.dart';
import 'package:inmobiliariaapp/ui/provider/user/user_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

import '../../common/colors_default.dart';
import 'widgets/administrator/container_images_voucher.dart';
class ScreenPropertyRequest extends StatefulWidget {
  ScreenPropertyRequest({Key? key}) : super(key: key);

  @override
  State<ScreenPropertyRequest> createState() => _ScreenPropertyRequestState();
}

class _ScreenPropertyRequestState extends State<ScreenPropertyRequest> {
  SizedBox _sizedBox=SizedBox(height: 10*SizeDefault.scaleHeight,);
  TextEditingController _controllerObservations=TextEditingController(text: "");
  String _textReject="Rechazar";
  @override
  Widget build(BuildContext context) {
    final sessionType=context.read<UserProvider>().sessionType;
    final requestCopy=context.read<PropertyAdministratorRequestsProvider>().requestCopy;
    
    if(_controllerObservations.text==""){
      if(sessionType=="Administrar"){
        _controllerObservations.text=requestCopy.observations;
      }else{
        _controllerObservations.text=requestCopy.observationsSuperUser;
      }
    }
    return Scaffold(
      backgroundColor: ColorsDefault.colorBackgroud,
      appBar: AppBar(
        title: TextTitle(
          fontSize: SizeDefault.fSizeTitle,
          text: "Solicitud",
        ),
        leading: FBackButton(),
        centerTitle: true,
        elevation: 0,
      ),
      
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: SizeDefault.paddingHorizontalBody,vertical: 20*SizeDefault.scaleHeight,),
          children: [
            _wPlanPaid(context: context),
            _sizedBox,
            FTextFieldBasico(
              controller: _controllerObservations, 
              labelText: "Observación:", 
              onChanged: (x){
                if(sessionType=="Administrar"){
                  requestCopy.observations=x;
                }else{
                  requestCopy.observationsSuperUser=x;
                }
              }
            ),
            SizedBox(height: 40*SizeDefault.scaleHeight,),

            if((sessionType=="Administrar"&&requestCopy.response=="")||(sessionType=="Supervisar"&&requestCopy.responseSuperUser==""))
            _wButtonsActionsRequest(sessionType, requestCopy, context)
          ],
        ),
      ),
    );
  }

  Row _wButtonsActionsRequest(String sessionType, AdministratorRequest requestCopy, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ButtonOutlinedPrimary(
            text: _textReject,
            color: ColorsDefault.colorTextRefused,
            onLongPress: (){
              setState(() {
                if(_textReject=="Rechazar"){
                  _textReject="Bloquear";
                }else{
                  _textReject="Rechazar";
                }
              });
            },
            onPressed: (){
              if(sessionType=="Administrar"){
                if(_textReject=="Rechazar"){
                  requestCopy.response="Rechazado";
                }else{
                  requestCopy.response="Bloqueado";
                }
                if(requestCopy.requestType=="Vendido"){
                  requestCopy.requestFinished=true;
                }else{
                  requestCopy.requestFinished=false;
                }
                
                _controllerObservations.text=requestCopy.observations;
                context.read<PropertyAdministratorRequestsProvider>().answerAdministratorRequest(context: context);
              }else{
                if(_textReject=="Rechazar"){
                  requestCopy.responseSuperUser="Rechazado";
                }else{
                  requestCopy.responseSuperUser="Bloqueado";
                }
                if(requestCopy.requestType=="Vendido"){
                  requestCopy.requestFinishedSuperUser=true;
                }else{
                  requestCopy.requestFinishedSuperUser=false;
                }
                _controllerObservations.text=requestCopy.observationsSuperUser;
                context.read<PropertyAdministratorRequestsProvider>().answerAdministratorRequestSuperUser(context: context);
              }
            },
          ),
        ),
        SizedBox(width:20*SizeDefault.scaleWidth),
        Expanded(
          child: ButtonPrimary(
            text: "Aprobar",
            onPressed: (){
              if(sessionType=="Administrar"){
                requestCopy.response="Confirmado";
                requestCopy.requestFinished=true;
                _controllerObservations.text=requestCopy.observations;
                context.read<PropertyAdministratorRequestsProvider>().answerAdministratorRequest(context: context);
              }else{
                requestCopy.responseSuperUser="Confirmado";
                requestCopy.requestFinishedSuperUser=true;
                _controllerObservations.text=requestCopy.observationsSuperUser;
                context.read<PropertyAdministratorRequestsProvider>().answerAdministratorRequestSuperUser(context: context);
              }
            },
          ),
        )
      ],
    );
  }

  Widget _wPlanFree({required BuildContext context}){
    final requestCopy=context.read<PropertyAdministratorRequestsProvider>().requestCopy;
    final propertyVoucher=context.read<PropertyAdministratorRequestsProvider>().requestCopy.propertyVoucher;
    final property=context.read<PropertiesProvider>().propertyTotalLast.property;
    print(propertyVoucher.agentDNIImageLink);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _wRichText(label: "Tipo solicitud: ", data: requestCopy.requestType),
        _sizedBox,
        _wRichText(label: "Estado solicitud: ", data: requestCopy.response),
        _sizedBox,
        _wRichText(label: "Categoría inmueble: ", data: property.category),
        _sizedBox,
        if(propertyVoucher.documentPropertyImageLink!="")
        FListTile(
          title: "Documento de propiedad", 
          colorText: ColorsDefault.colorText,
          onTap: ()async{
            print(requestCopy.propertyVoucher.documentPropertyImageLink);
            await fShowModalBottomSheet(
              context: context, 
              widget: ContainerImagesVoucher(
                linkImage: propertyVoucher.documentPropertyImageLink,
                title: "Documento de propiedad",
              )
            );
          }, 
        ),
        propertyVoucher.documentSalesImageLink!=""
        ?Column(
          children: [
            _sizedBox,
            FListTile(
              title: "Documento exclusivo de venta", 
              colorText: ColorsDefault.colorText,
              onTap: ()async{
                await fShowModalBottomSheet(
                  context: context, 
                  widget: ContainerImagesVoucher(
                    linkImage: propertyVoucher.documentSalesImageLink,
                    title: "Documento exclusivo de venta",
                  )
                );
              }, 
            ),
          ],
        ):SizedBox(),
        _sizedBox,
        if(propertyVoucher.ownerDNIImageLink!="")
        FListTile(
          title: "Cédula de identidad del propietario", 
          colorText: ColorsDefault.colorText,
          onTap: ()async{
            await fShowModalBottomSheet(
              context: context, 
              widget: ContainerImagesVoucher(
                linkImage: propertyVoucher.ownerDNIImageLink,
                title: "Cédula de identidad del propietario",
              )
            );
          }, 
        ),
        propertyVoucher.agentDNIImageLink!=""
        ?Column(
          children: [
            _sizedBox,
            FListTile(
              title: "Cédula de identidad del agente", 
              colorText: ColorsDefault.colorText,
              onTap: ()async{
                await fShowModalBottomSheet(
                  context: context, 
                  widget: ContainerImagesVoucher(
                    linkImage: propertyVoucher.agentDNIImageLink,
                    title: "Cédula de identidad del agente",
                  )
                );
              }, 
            ),
          ],
        ):SizedBox(),
      ],
    );
  }

  Widget _wPlanPaid({required BuildContext context}){
    final requestCopy=context.read<PropertyAdministratorRequestsProvider>().requestCopy;
    final propertyVoucher=context.read<PropertyAdministratorRequestsProvider>().requestCopy.propertyVoucher;
    final property=context.read<PropertiesProvider>().propertyTotalLast.property;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _wRichText(label: "Tipo solicitud: ", data: requestCopy.requestType),
        _sizedBox,
        _wRichText(label: "Categoría inmueble: ", data: property.category),
        if(propertyVoucher.publicationPlanPayment.id!="")
        Column(
          children: [
            _sizedBox,
            _wRichText(label: "Plan: ", data: propertyVoucher.publicationPlanPayment.planName),
            _sizedBox,
            _wRichText(label: "Costo: ", data: "${propertyVoucher.publicationPlanPayment.cost.toString()} Bs."),
          ],
        ),
        _sizedBox,
        if(propertyVoucher.bankAccount.id!="")
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _wRichText(label: "Entidad financiera: ", data: propertyVoucher.bankAccount.bankName),
            _sizedBox,
            _wRichText(label: "Número de cuenta: ", data: propertyVoucher.bankAccount.accountNumber),
            _sizedBox,
            _wRichText(label: "Titular de la cuenta: ", data: propertyVoucher.bankAccount.owner),
            _sizedBox,
            _wRichText(label: "Número de transacción: ", data: "${propertyVoucher.transactionNumber}"),
            _sizedBox,
            _wRichText(label: "Nombre del depositante: ", data: propertyVoucher.depositorName),
            _sizedBox,
          ],
        ),
        if(propertyVoucher.documentPropertyImageLink!="")
        FListTile(
          title: "Documento de propiedad", 
          colorText: ColorsDefault.colorText,
          onTap: ()async{
            print(requestCopy.propertyVoucher.documentPropertyImageLink);
            await fShowModalBottomSheet(
              context: context, 
              widget: ContainerImagesVoucher(
                linkImage: propertyVoucher.documentPropertyImageLink,
                title: "Documento de propiedad",
              )
            );
          }, 
        ),
         if(propertyVoucher.documentSalesImageLink!="")
         Column(
          children: [
            _sizedBox,
            FListTile(
              title: "Documento exclusivo de venta", 
              colorText: ColorsDefault.colorText,
              onTap: ()async{
                await fShowModalBottomSheet(
                  context: context, 
                  widget: ContainerImagesVoucher(
                    linkImage: propertyVoucher.documentSalesImageLink,
                    title: "Documento exclusivo de venta",
                  )
                );
              }, 
            ),
          ],
        ),
        if(propertyVoucher.ownerDNIImageLink!="")
        Column(
          children: [
            _sizedBox,
            FListTile(
              title: "Cédula de identidad del propietario", 
              colorText: ColorsDefault.colorText,
              onTap: ()async{
                await fShowModalBottomSheet(
                  context: context, 
                  widget: ContainerImagesVoucher(
                    linkImage: propertyVoucher.ownerDNIImageLink,
                    title: "Cédula de identidad del propietario",
                  )
                );
              }, 
            ),
          ],
        ),
        if(propertyVoucher.agentDNIImageLink!="")
        Column(
          children: [
            _sizedBox,
            FListTile(
              title: "Cédula de identidad del agente", 
              colorText: ColorsDefault.colorText,
              onTap: ()async{
                await fShowModalBottomSheet(
                  context: context, 
                  widget: ContainerImagesVoucher(
                    linkImage: propertyVoucher.agentDNIImageLink,
                    title: "Cédula de identidad del agente",
                  )
                );
              }, 
            ),
          ],
        ),
        if(propertyVoucher.depositImageLink!="")
        Column(
          children: [
            _sizedBox,
            FListTile(
              title: "Comprobante de depósito", 
              colorText: ColorsDefault.colorText,
              onTap: ()async{
                await fShowModalBottomSheet(
                  context: context, 
                  widget: ContainerImagesVoucher(
                    linkImage: propertyVoucher.depositImageLink,
                    title: "Cédula de identidad del agente",
                  )
                );
              }, 
            ),
          ],
        ),
        _sizedBox,
        FListTile(
          title: "Datos del inmueble", 
          colorText: ColorsDefault.colorText,
          onTap: ()async{
            
          }, 
        ),
        _sizedBox,
        FListTile(
          title: "Imágenes del inmueble", 
          colorText: ColorsDefault.colorText,
          onTap: ()async{
            
          }, 
        ),
        
      ],
    );
  }

  RichText _wRichText({required String label, required String data}) {
    return RichText(
      text: TextSpan(
        text: label,
        style: _styleLabel(),
        children: [
          TextSpan(
            text: data,
            style: _styleData()
          )
        ]
      ),
    );
  }

  TextStyle _styleLabel(){
    return GoogleFonts.notoSans(
      fontSize: SizeDefault.fSizeStandard,
      fontWeight: FontWeight.w400,
      color: ColorsDefault.colorTextInfo,
    );
  }

  TextStyle _styleData(){
    return GoogleFonts.notoSans(
      fontSize: SizeDefault.fSizeStandard,
      fontWeight: FontWeight.w600,
      color: ColorsDefault.colorText,
    );
  }
  
}