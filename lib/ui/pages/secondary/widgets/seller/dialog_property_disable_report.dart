import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/f_list_tile.dart';
import 'package:inmobiliariaapp/ui/common/f_show_modal_bottom_sheet.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:provider/provider.dart';

import 'container_document_property_image.dart';

Future dialogPropertyDisableReport(
  BuildContext context,
)async{
 return await showDialog(
    barrierDismissible: true,
    context: context,
    builder: (BuildContext ctx){
      return StatefulBuilder(
        builder: (BuildContext ctx,StateSetter setState){
          return SimpleDialog(
            contentPadding: EdgeInsets.zero,
            titlePadding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
            children: [
              Container(
                width: 300*SizeDefault.scaleWidth,
                child: _ContainerPropertyDisableReport()
              )
            ],
          );
        }
      );
    }
  ); 
}
class _ContainerPropertyDisableReport extends StatefulWidget {
  _ContainerPropertyDisableReport({Key? key}) : super(key: key);

  @override
  State<_ContainerPropertyDisableReport> createState() => __ContainerPropertyDisableReportState();
}

class __ContainerPropertyDisableReportState extends State<_ContainerPropertyDisableReport> {
  int _step=0;
  @override
  void initState() {
    context.read<RegistrationPropertyProvider>().initSoldReport();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 370*SizeDefault.scaleWidth,
      padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth,vertical: 20*SizeDefault.scaleWidth),
      child: _step==0?_wStepData(context):_step==1?_wStepConfirm(context):_wStepSuccess(),
    );
  }

  Widget _wStepData(BuildContext context){
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    final mapValidate=registrationPropertyProvider.mapValidateDisableReport;
    final propertyTotal=registrationPropertyProvider.propertyTotalCopy;
    final propertyVoucher=propertyTotal.administratorRequest.propertyVoucher;
    final userBuyer=propertyVoucher.userBuyer;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            TextStandard(
              text: "Dar baja y reportar", 
              fontSize: SizeDefault.fSizeTitle,
              fontWeight: FontWeight.bold,
              color: ColorsDefault.colorPrimary,
            ),
            SizedBox(height: 20*SizeDefault.scaleWidth,),
            _wCheckboxListTile(
              title: "Cancelación de contrato",
              value: propertyVoucher.contractCancel,
              onChanged: (value){
                setState(() {
                  propertyVoucher.contractCancel=value;
                  propertyVoucher.contractLimit=!value;
                });
              }
            ),
            _wCheckboxListTile(
              title: "Límite de contrato",
              value: propertyVoucher.contractLimit,
              onChanged: (value){
                setState(() {
                  propertyVoucher.contractLimit=value;
                  propertyVoucher.contractCancel=!value;
                });
              }
            ),
            SizedBox(height: 10*SizeDefault.scaleWidth,),
            FListTile(
              title: "Documento de propiedad", 
              colorText: ColorsDefault.colorText,
              errorText: mapValidate["property_document"],
              onTap: ()async{
                await fShowModalBottomSheet(
                  context: context, 
                  widget: ContainerDocumentPropertyImage()
                );
              }, 
            ),
            SizedBox(height: 5*SizeDefault.scaleWidth,),
            SizedBox(height: 20*SizeDefault.scaleWidth,),
          ],
        ),
        _wButtonsStepData(context)
      ],
    );
  }

  Row _wButtonsStepData(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonOutlinedPrimary(
            text: "Cancelar",
            color: ColorsDefault.colorTextError, 
            onPressed: (){
              Navigator.pop(context);
            }
          )
        ),
        SizedBox(width: 5*SizeDefault.scaleWidth),
        Expanded(
          child: ButtonPrimary(
            text: "Continuar", 
            onPressed: ()async{
              if(context.read<RegistrationPropertyProvider>().validateDisableReport()){
                setState(() {
                  _step++;
                });
              }
            }
          )
        ),
      ],
    );
  }

  Widget _wStepConfirm(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            SizedBox(height: 20*SizeDefault.scaleWidth,),
            TextInfo(
              text: "Se enviará el reporte para dar de baja el inmueble, por lo cuál ya no se visualizará en la sección de comprar, si se confirma esta solicitud por el administrador, se le anulará la calificación de este inmueble, esto no afectará a su reputación como vendedor", 
              fontSize: SizeDefault.fSizeStandard,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5*SizeDefault.scaleWidth,),
            TextInfo(
              text: "¿Desea continuar?", 
              fontSize: SizeDefault.fSizeStandard,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20*SizeDefault.scaleWidth,),
          ],
        ),
        _wButtonsStepConfirm(context)
      ],
    );
  }

  Row _wButtonsStepConfirm(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ButtonOutlinedPrimary(
            text: "Atrás",
            color: ColorsDefault.colorTextError, 
            onPressed: (){
              setState(() {
                _step--;
              });
            }
          )
        ),
        SizedBox(width: 5*SizeDefault.scaleWidth),
        Expanded(
          child: ButtonPrimary(
            text: "Confirmar", 
            onPressed: ()async{
              if(await context.read<RegistrationPropertyProvider>().updatePropertyStatus(context: context,actionType: "Dar baja y reportar")){
                setState(() {
                  _step=2;
                });
              }
            }
          )
        ),
      ],
    );
  }

  Widget _wStepSuccess(){
    return Column(
      children: [
        SizedBox(height: 30*SizeDefault.scaleWidth,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.check,
                color: ColorsDefault.colorPrimary,
                size: 30*SizeDefault.scaleWidth,
              ),
            ),
          ],
        ),
        SizedBox(height: 30*SizeDefault.scaleWidth,),
        Padding(
          padding: EdgeInsets.only(bottom: 10*SizeDefault.scaleWidth,left: 20*SizeDefault.scaleWidth,right:  20*SizeDefault.scaleWidth),
          child: TextInfo(
            text: "La operación se realizó exitósamente", 
            textAlign: TextAlign.center,
            fontSize: SizeDefault.fSizeStandard,
            color: ColorsDefault.colorPrimary,
          ),
        ),
      ],
    );
  }
  CheckboxListTile _wCheckboxListTile({required String title,required bool value,required Function onChanged}) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      title: TextStandard(text: title, fontSize: SizeDefault.fSizeStandard),
      checkColor: ColorsDefault.colorBackgroud,
      activeColor: ColorsDefault.colorPrimary,
      
      value: value, 
      onChanged: (value){
        onChanged(value);
      }
    );
  }
}