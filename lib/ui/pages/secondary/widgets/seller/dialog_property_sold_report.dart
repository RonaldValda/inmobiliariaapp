import 'package:flutter/material.dart';
import 'package:inmobiliariaapp/ui/common/buttons.dart';
import 'package:inmobiliariaapp/ui/common/colors_default.dart';
import 'package:inmobiliariaapp/ui/common/size_default.dart';
import 'package:inmobiliariaapp/ui/common/texts.dart';
import 'package:inmobiliariaapp/ui/pages/utils/debouncer.dart';
import 'package:inmobiliariaapp/ui/provider/registration_property/registration_property_provider.dart';
import 'package:inmobiliariaapp/widgets/f_text_fields.dart';
import 'package:provider/provider.dart';

Future dialogPropertySoldReport(
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
              borderRadius: BorderRadius.circular(SizeDefault.radiusDialog)
            ),
            children: [
              Container(
                width: 300*SizeDefault.scaleWidth,
                child: _ContainerPropertySoldReport()
              )
            ],
          );
        }
      );
    }
  ); 
}
class _ContainerPropertySoldReport extends StatefulWidget {
  _ContainerPropertySoldReport({Key? key}) : super(key: key);

  @override
  State<_ContainerPropertySoldReport> createState() => __ContainerPropertySoldReportState();
}

class __ContainerPropertySoldReportState extends State<_ContainerPropertySoldReport> {
  int _step=0;
  TextEditingController _controllerTestimonyNumber=TextEditingController(text: "");
  TextEditingController _controllerEmail=TextEditingController(text: "");
  final Debouncer debouncer=Debouncer();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420*SizeDefault.scaleWidth,
      padding: EdgeInsets.symmetric(horizontal: 20*SizeDefault.scaleWidth,vertical: 20*SizeDefault.scaleWidth),
      child: _step==0?_stepData(context):_step==1?_wStepConfirm(context):_wStepSuccess(),
    );
  }

  Widget _stepData(BuildContext context){
    final registrationPropertyProvider=context.watch<RegistrationPropertyProvider>();
    final mapValidate=registrationPropertyProvider.mapValidateSoldReport;
    final propertyTotal=registrationPropertyProvider.propertyTotalCopy;
    final propertyVoucher=propertyTotal.administratorRequest.propertyVoucher;
    final userBuyer=propertyVoucher.userBuyer;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            TextStandard(
              text: "Declarar vendido y reportar", 
              fontSize: SizeDefault.fSizeTitle,
              fontWeight: FontWeight.bold,
              color: ColorsDefault.colorPrimary,
            ),
            SizedBox(height: 20*SizeDefault.scaleWidth,),
            FTextFieldBasico(
              controller: _controllerTestimonyNumber, 
              labelText: "Número testimonio", 
              errorText: mapValidate["testimony_number"],
              onChanged: (x){
                propertyVoucher.testimonyNumber=x;
              }
            ),
            SizedBox(height: 5*SizeDefault.scaleWidth,),
            TextInfo(
              text: "Usuario comprador", 
              fontSize: SizeDefault.fSizeStandard,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w500,
            ),
            SizedBox(height: 5*SizeDefault.scaleWidth,),
            FTextFieldBasico(
              controller: _controllerEmail, 
              labelText: "Email", 
              textInputType: TextInputType.emailAddress,
              errorText: mapValidate["user_buyer"],
              onChanged: (x){
                debouncer.execute(
                  () { 
                    context.read<RegistrationPropertyProvider>().searchUserBuyer(context: context, email: _controllerEmail.text);
                  }
                  ,1
                );
              }
            ),
            SizedBox(height: 5*SizeDefault.scaleWidth,),
            FTextFieldOnTapDisabled(
              labelText: "Nombres",
              text: userBuyer.namesSurnames,
              errorText: "",
              onTap: (){},
            ),
            SizedBox(height: 20*SizeDefault.scaleWidth,),
          ],
        ),
        _wButtonsStepData(context)
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
              text: "Se enviará el reporte de venta al administrador para su revisión, por mientras el inmueble no estará visible en la sección de comprar, si es aprobado esta solicitud, el inmueble se declarará vendido y se le asignará una calificación tomando en cuenta los dias que transcurrieron entre la publicación y la venta del inmueble", 
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
              if(context.read<RegistrationPropertyProvider>().validateSoldReport()){
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
              if(await context.read<RegistrationPropertyProvider>().updatePropertyStatus(context: context,actionType: "Vendido y reportar")){
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
}